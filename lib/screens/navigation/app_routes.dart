import 'package:flutter/material.dart';
import 'package:smart_ring/bluetooth/bluetooth_binding.dart';
import 'package:smart_ring/screens/activity_screen/activity_screen.dart';
import 'package:smart_ring/screens/heart_rate_screen/data_details.dart';
import 'package:smart_ring/screens/heart_rate_screen/heart_rate_screen.dart';
import 'package:smart_ring/screens/sleep_screen/sleep_screen.dart';
import 'package:smart_ring/screens/sport_record_screen/sport_screen.dart';
import 'package:smart_ring/widgets/card/activity_description_card.dart';
import 'package:smart_ring/widgets/card/score_card.dart';

class AppRoutes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/activity_screen':
        return _slideTransition(ActivityScreen());
      case '/heart_rate_screen':
        return _slideTransition(HeartRateScreen());
      case '/sleep_screen':
        return _slideTransition(SleepScreen());
      case '/score_card':
        return _slideTransition(ScoreCard());
      case '/activity_description':
        return _slideTransition(ActivityDescription());
      case '/data_details':
        return _slideTransition(DataDetails());
      case '/sport_screen':
        return _slideTransition(SportRecordScreen());
      case '/bluetooth_binding':
        return _slideTransition(BluetoothScreen());
      default:
        return null; // Unknown route
    }
  }

  static PageRouteBuilder _slideTransition(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Start from right
        const end = Offset.zero; // End at the center
        const curve = Curves.easeInOut; // Smooth transition

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: Duration(milliseconds: 250), // Adjust speed
    );
  }
}
