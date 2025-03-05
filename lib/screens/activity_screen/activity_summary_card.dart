// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:math';

class ActivitySummaryCard extends StatelessWidget {
  const ActivitySummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 140, // Increased height for bigger arcs
              child: CustomPaint(
                painter: RainbowArcPainter(),
                size: const Size(double.infinity, 140), // Adjusted canvas size
              ),
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ActivityData(
                  title: "Total Steps",
                  value: "0",
                  goal: "/10000 Steps",
                  color: Colors.blue, // Bright Blue Text
                ),
                ActivityData(
                  title: "Total Mileage",
                  value: "0.00",
                  goal: "/5 Km",
                  color: Colors.green, // Bright Green Text
                ),
                ActivityData(
                  title: "Total Calories",
                  value: "0",
                  goal: "/200 Kcal",
                  color: Colors.red, // Bright Red Text
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityData extends StatelessWidget {
  final String title;
  final String value;
  final String goal;
  final Color color;

  const ActivityData({
    required this.title,
    required this.value,
    required this.goal,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ), // Bright Text
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white, // Keeping White for Main Numbers
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(goal, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}

class RainbowArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY =
        size.height + 10; // Adjusted position for bigger arcs

    // **Increased Arc Sizes for a Bigger Look**
    final double radius1 = size.width * 0.40; // Top arc (was 0.35)
    final double radius2 = size.width * 0.35; // Middle arc (was 0.30)
    final double radius3 = size.width * 0.30; // Bottom arc (was 0.25)

    final double arcSpacing = 8; // Slightly increased spacing

    void drawArc(Paint paint, double radius, double yOffset) {
      final Rect rect = Rect.fromCircle(
        center: Offset(centerX, centerY + yOffset),
        radius: radius,
      );
      const double startAngle = pi;
      const double sweepAngle = pi;
      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
    }

    // **Dimmed Color Effect (Same as Before)**
    final Paint redPaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 15
          ..strokeCap = StrokeCap.round
          ..color = const Color(0xFF804040).withOpacity(0.6); // Dimmed Red

    final Paint greenPaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 15
          ..strokeCap = StrokeCap.round
          ..color = const Color(0xFF408060).withOpacity(0.6); // Dimmed Green

    final Paint bluePaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 15
          ..strokeCap = StrokeCap.round
          ..color = const Color(0xFF406080).withOpacity(0.6); // Dimmed Blue

    // **Drawing Bigger Arcs**
    drawArc(redPaint, radius1, arcSpacing * 2);
    drawArc(greenPaint, radius2, arcSpacing * 2);
    drawArc(bluePaint, radius3, arcSpacing * 2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
