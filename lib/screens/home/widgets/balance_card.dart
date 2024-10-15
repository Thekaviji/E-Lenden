import 'package:elenden/constants/constants.dart';
import 'package:elenden/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BalanceCard extends StatefulWidget {
  const BalanceCard({super.key});

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(builder: (context, provider, child) {
      final transactions = provider.transactions;

      // Calculate netBalance, netCashIn, and netCashOut
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

      return Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppConstants.accentGreen),
          color: AppConstants.secondaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Net Balance: Rs. $netBalance',
              style: const TextStyle(fontSize: 24, color: Colors.black54),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Cash In
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.grey),
                              color: Colors.white,
                            ),
                            child: const Icon(Icons.arrow_upward, color: Colors.green),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Cash In',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Rs. $netCashIn',
                            style: AppConstants.bodyStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Cash Out
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.grey),
                              color: Colors.white,
                            ),
                            child: const Icon(Icons.arrow_downward, color: Colors.red),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Cash Out',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Rs. $netCashOut',
                            style: AppConstants.bodyStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
