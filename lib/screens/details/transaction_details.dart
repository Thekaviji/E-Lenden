import 'package:elenden/model/transaction_model.dart';
import 'package:elenden/screens/Edit%20transaction/edit_transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  // Import Provider
import '../../constants/constants.dart';
import '../../provider/transaction_provider.dart'; // Import TransactionProvider

class TransactionDetails extends StatefulWidget {
  final TransactionModel transaction;

  const TransactionDetails({super.key, required this.transaction});

  @override
  _TransactionDetailsState createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  late TransactionModel _transaction;

  @override
  void initState() {
    super.initState();
    _transaction = widget.transaction;
  }

  @override
  Widget build(BuildContext context) {
    // Access the TransactionProvider
    final provider = Provider.of<TransactionProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Transaction Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppConstants.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _transaction.transactionType,
                  style: const TextStyle(color: Colors.grey),
                ),
                IconButton(
                  onPressed: () async {
                    final updatedTransaction = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditTransaction(transaction: _transaction),
                      ),
                    );

                    if (updatedTransaction != null) {
                      setState(() {
                        _transaction = updatedTransaction; // Update the transaction details
                      });
                    }
                  },
                  icon: const Icon(Icons.mode_edit_outline_outlined),
                ),
              ],
            ),
            Text(
              'Rs. ${_transaction.amount}',
              style: TextStyle(
                fontSize: 20,
                color: _transaction.transactionType == 'Cash In'
                    ? Colors.green
                    : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _transaction.description,
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: _transaction.transactionType == 'Cash In'
                        ? Colors.green.shade100
                        : Colors.red.shade100,
                  ),
                  child: Center(
                    child: Text(
                      _transaction.paymentMode,
                      style: TextStyle(
                        color: _transaction.transactionType == 'Cash In'
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Center(child: const Text('Delete Transaction', style: TextStyle(color: Colors.red),)),
                          content: const Text('Are you sure you want to delete this transaction?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Call the deleteTransaction method from the provider
                                provider.deleteTransaction(_transaction.id as int);
                                Navigator.of(context).pop(); // Close the dialog
                                Navigator.of(context).pop(); // Pop the transaction details screen
                              },
                              child: const Text('Delete', style: TextStyle(color: Colors.red),),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:  Colors.red.shade100,
                    ),
                    child: const Center(
                      child: Text(
                       'Delete',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height:25),
            Container(height: 1, color: Colors.black12),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _transaction.transactionDate,
                  style: const TextStyle(color: Colors.black26, fontSize: 10),
                ),
                Text(
                  _transaction.transactionTime,
                  style: const TextStyle(color: Colors.black26, fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
