import 'package:elenden/screens/all%20transactions/all_transactions.dart';
import 'package:elenden/screens/home/widgets/balance_card.dart';
import 'package:elenden/screens/home/widgets/home_app_bar.dart';
import 'package:elenden/screens/home/widgets/home_bottom_nav_bar.dart';
import 'package:elenden/screens/home/widgets/transaction_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BalanceCard(),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Transactions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const AllTransactions();
                    }));
                  },
                  child: const Text(
                    'See all',
                    style: TextStyle(color: Colors.grey,fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Expanded(
              child: TransactionCard(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const HomeBottomNavBar(),
    );
  }
}
