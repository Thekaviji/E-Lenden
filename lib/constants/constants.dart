import 'package:flutter/material.dart';

class AppConstants {
  // Font Styles
  static const TextStyle headingStyle = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    fontSize: 24.0,
    color: Colors.white,
  );

  static const TextStyle subHeadingStyle = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w600,
    fontSize: 18.0,
    color: Colors.black87,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
    fontSize: 14.0,
    color: Colors.black54,
  );

  // Colors
  static const Color primaryColor = Color(0xFF1A237E);  // Navy Blue
  static  Color secondaryColor = Colors.grey.shade50; // Light Gray
  static const Color accentGreen = Color(0xFF4CAF50);    // Green for positive actions
  static const Color accentRed = Color(0xFFE53935);      // Red for negative actions
  static const Color backgroundColor = Color(0xFFFAFAFA); // Soft White

  // Padding and Margins
  static const double defaultPadding = 16.0;
  static const double defaultMargin = 16.0;

  // Border Radius
  static const double borderRadius = 8.0;

  // Icon Sizes
  static const double iconSize = 24.0;
}
