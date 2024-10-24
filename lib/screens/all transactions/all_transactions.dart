import 'package:elenden/provider/transaction_provider.dart';
import 'package:elenden/screens/details/transaction_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';

class AllTransactions extends StatefulWidget {
  const AllTransactions({super.key});

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'All Transactions',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppConstants.primaryColor, // Set background color from constants
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer<TransactionProvider>(
          builder: (context, provider, child) {
            final transactions = provider.transactions.reversed.toList();
            double netBalance = 0;
            double netCashIn = 0;
            double netCashOut = 0;

            for (var transaction in transactions) {
              if (transaction.transactionType == 'Cash In') {
                netCashIn += transaction.amount;
              } else if (transaction.transactionType == 'Cash Out') {
                netCashOut += transaction.amount;
              }
              netBalance = netCashIn - netCashOut; // Update net balance
            }

            // Check if there are no transactions
            if (transactions.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage('assets/images/notFound.png')),
                  Text(
                    'No transactions found.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              );
            }

            // Show transactions if available
            return ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to TransactionDetails and pass the transaction object
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return TransactionDetails(transaction: transaction);  // Pass the TransactionModel
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 105, // Increase height for better visibility
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 65,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: transaction.transactionType == 'Cash In'
                                        ? Colors.green.shade100
                                        : Colors.red.shade100,
                                  ),
                                  child: Center(
                                    child: Text(
                                      transaction.paymentMode,
                                      style: TextStyle(
                                        color: transaction.transactionType == 'Cash In'
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Rs. ${transaction.amount}',
                                  style: TextStyle(
                                    color: transaction.transactionType == 'Cash In'
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(transaction.description, style: const TextStyle(color: Colors.black54),),
                                Text('Balance: Rs. ${provider.netBalance}', style: const TextStyle( color: Colors.grey),),
                              ],
                            ),

                            const SizedBox(height: 18),
                            Container(height: 1, color: Colors.black12),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  transaction.transactionDate,
                                  style: const TextStyle(color: Colors.black26, fontSize: 10),
                                ),
                                Text(
                                  transaction.transactionTime,
                                  style: const TextStyle(color: Colors.black26, fontSize: 10),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
