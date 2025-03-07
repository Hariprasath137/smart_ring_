import 'package:flutter/material.dart';
// import 'package:smart_ring/screens/heart_rate_screen/heart_rate_screen.dart';
import 'package:smart_ring/screens/navigation/app_routes.dart';
import 'package:smart_ring/screens/navigation/bottom_navbar.dart';
// import 'package:smart_ring/widgets/slider_card/heart_rate_slider_card.dart';
// import 'package:smart_ring/screens/navigation/bottom_navbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
      onGenerateRoute: AppRoutes.generateRoute, // Use centralized navigation
    );
  }
}
