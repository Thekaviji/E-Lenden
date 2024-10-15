import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../../provider/transaction_provider.dart';
import '../../details/transaction_details.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, provider, child) {
        final transactions = provider.transactions;

        return ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal:5 ),
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
                  height: 100, // Increase height for better visibility
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppConstants.secondaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // Shadow position
                      ),
                    ],
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
                            Text(transaction.description,style: const TextStyle(color: Colors.black54),),
                            Text('Balance: Rs. ${provider.netBalance}',style: const TextStyle(color: Colors.grey),),
                          ],
                        ),
                        const SizedBox(height:18 ),
                        Container(height: 1, color: Colors.black12),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${transaction.transactionDate}',
                              style: const TextStyle(color: Colors.black26, fontSize: 10),
                            ),
                            Text(
                              '${transaction.transactionTime}',
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
    );
  }
}
