class TransactionModel {
  final int? id;
  final String transactionType;
  final double amount;
  final double netBalance;
  final double netCashIn;
  final double netCashOut;
  final String description;
  final String paymentMode;
  final String transactionDate;
  final String transactionTime;

  TransactionModel({
    this.id,
    required this.transactionType,
    required this.amount,
    required this.netBalance,
    required this.netCashIn,
    required this.netCashOut,
    required this.description,
    required this.paymentMode,
    required this.transactionDate,
    required this.transactionTime,
  });

  // Convert a Transaction into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transaction_type' : transactionType,
      'amount': amount,
      'netBalance': netBalance,
      'netCashIn': netCashIn,
      'netCashOut': netCashOut,
      'description': description,
      'payment_mode': paymentMode,
      'transaction_date': transactionDate,
      'transaction_time': transactionTime,
    };
  }

  // Convert a Map into a Transaction.
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      transactionType: map['transaction_type'],
      amount: map['amount'],
      netBalance: map['netBalance'],
      netCashIn: map['netCashIn'],
      netCashOut: map['netCashOut'],
      description: map['description'],
      paymentMode: map['payment_mode'],
      transactionDate: map['transaction_date'],
      transactionTime: map['transaction_time'],
    );
  }
}
