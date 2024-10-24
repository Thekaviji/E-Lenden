import 'package:elenden/screens/Add%20Cash%20In/add_cash_in.dart';
import 'package:elenden/screens/Add%20Cash%20Out/add_cash_out.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            //cash In
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AddCashIn();
                }));
              },
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width / 2.15,
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppConstants.accentGreen),
                  color: Colors.green[100],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Cash In',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            const Spacer(),

            //cash out

            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AddCashOut();
                }));
              },
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width / 2.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppConstants.accentRed),
                  color: Colors.red[100],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.remove,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Cash Out',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
