import 'package:animated_text_lerp/animated_text_lerp.dart';
import 'package:elenden/constants/constants.dart';
import 'package:elenden/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_number/sliding_number.dart';
import 'package:typewritertext/typewritertext.dart';

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
            const Text(
              'Net Balance',
              style: TextStyle(fontSize: 24, color: Colors.black54),
            ),
            AnimatedNumberText(
              netBalance,
              curve: Curves.easeInSine,
              duration: const Duration(seconds: 1),
              style: TextStyle(
                fontSize: 25,
                color: netBalance >= 0 ? Colors.green : Colors.red,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTransactionSummary(
                    icon: Icons.arrow_upward,
                    color: Colors.green,
                    title: 'Cash In',
                    amount: netCashIn,
                  ),
                  _buildTransactionSummary(
                    icon: Icons.arrow_downward,
                    color: Colors.red,
                    title: 'Cash Out',
                    amount: netCashOut,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTransactionSummary({
    required IconData icon,
    required Color color,
    required String title,
    required double amount,
  }) {
    return Row(
      children: [
        Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.grey),
            color: Colors.white,
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              'Rs. $amount',
              style: AppConstants.bodyStyle,
            ),
          ],
        ),
      ],
    );
  }
}
