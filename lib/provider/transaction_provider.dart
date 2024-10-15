import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/transaction_model.dart';

class TransactionProvider extends ChangeNotifier {
  List<TransactionModel> _transactions = [];
  late Database _db;

  List<TransactionModel> get transactions => _transactions;

  TransactionProvider() {
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    _db = await _openDatabase();
    await _loadTransactions();
  }

  // Getter to calculate net cash in
  double get netCashIn {
    return _transactions
        .where((t) => t.transactionType == 'Cash In')
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  // Getter to calculate net cash out
  double get netCashOut {
    return _transactions
        .where((t) => t.transactionType == 'Cash Out')
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  // Getter to calculate net balance
  double get netBalance {
    return netCashIn - netCashOut;
  }

  Future<Database> _openDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'transactions.db'),
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE transactions(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              transaction_type TEXT,
              amount REAL,
              netBalance REAL,
              netCashIn REAL,
              netCashOut REAL,
              description TEXT,
              payment_mode TEXT,
              transaction_date TEXT,
              transaction_time TEXT
          )''',
        );
      },
      version: 1,
    );
  }

  Future<void> _loadTransactions() async {
    final List<Map<String, dynamic>> maps = await _db.query('transactions');

    _transactions = List.generate(maps.length, (i) {
      return TransactionModel(
        id: maps[i]['id'],
        transactionType: maps[i]['transaction_type'],
        amount: maps[i]['amount'],
        netBalance: maps[i]['netBalance'],
        netCashIn: maps[i]['netCashIn'],
        netCashOut: maps[i]['netCashOut'],
        description: maps[i]['description'],
        paymentMode: maps[i]['payment_mode'],
        transactionDate: maps[i]['transaction_date'],
        transactionTime: maps[i]['transaction_time'],
      );
    });
    notifyListeners();
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    await _db.insert(
      'transactions',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await _loadTransactions();  // Refresh the data
  }

  Future<void> deleteTransaction(int id) async {
    await _db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
    await _loadTransactions();  // Refresh the data
  }

  Future<void> updateTransaction(TransactionModel transaction) async {
    await _db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
    await _loadTransactions();  // Refresh the data
  }
}
