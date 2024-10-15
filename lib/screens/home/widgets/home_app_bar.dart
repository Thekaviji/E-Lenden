import 'package:elenden/constants/constants.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {



  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Center(child: Text('E-Lenden', style: AppConstants.headingStyle)),
      backgroundColor: AppConstants.primaryColor,
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(60); // Default app bar height
}
