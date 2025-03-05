import 'package:flutter/material.dart';

class SliderCard extends StatefulWidget {
  const SliderCard({super.key});

  @override
  State<SliderCard> createState() => _SliderCardState();
}

class _SliderCardState extends State<SliderCard>
    with SingleTickerProviderStateMixin {
  double _sliderValue = 0.0;

  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: -5.0,
      upperBound: 5.0,
    );
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  String getFormattedTime() {
    int totalMinutes = (_sliderValue * 1439).toInt();
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Use min to prevent expansion
          children: [
            // "Steps" text in blue at top-left
            const Text(
              "Steps",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "0",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      const Text(
                        "Steps",
                        style: TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  // Updated moving time under "0 Steps"
                  Text(
                    getFormattedTime(),
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Graph representation
            SizedBox(
              width: double.infinity,
              height: 100, // Reduced height
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    _sliderValue = (details.localPosition.dx / 300).clamp(
                      0.0,
                      1.0,
                    );
                  });
                },
                onTapDown: (details) {
                  setState(() {
                    _sliderValue = (details.localPosition.dx / 300).clamp(
                      0.0,
                      1.0,
                    );
                  });
                },
                child: CustomPaint(painter: StepGraphPainter(_sliderValue)),
              ),
            ),
            const SizedBox(height: 20),
            // Time labels under the third dotted line
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "00:00",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                Text(
                  "06:00",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                Text(
                  "12:00",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                Text(
                  "18:00",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                Text(
                  "23:59",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 5),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 2,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 15),
                activeTrackColor: Colors.transparent,
                inactiveTrackColor: Colors.transparent,
                thumbColor: Colors.white,
              ),
              child: Slider(
                value: _sliderValue,
                min: 0.0,
                max: 1.0,
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;
                    _waveController.forward().then(
                      (_) => _waveController.reverse(),
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StepGraphPainter extends CustomPainter {
  final double sliderValue;

  StepGraphPainter(this.sliderValue);

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint =
        Paint()
          ..color = Colors.grey
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke;

    Paint verticalLinePaint =
        Paint()
          ..color = Colors.blue
          ..strokeWidth = 1;

    // Adjusted Y positions to fit in smaller space
    double topY = 10;
    double middleY = 60;
    double bottomY = 110;

    double leftPadding = 30;

    drawDashedLine(canvas, size, topY, dashedPaint, leftPadding);
    drawDashedLine(canvas, size, middleY, dashedPaint, leftPadding);
    drawDashedLine(canvas, size, bottomY, dashedPaint, leftPadding);

    double verticalX = sliderValue * (size.width - leftPadding);
    canvas.drawLine(
      Offset(verticalX, -10),
      Offset(verticalX, bottomY + 1),
      verticalLinePaint,
    );

    double textX = size.width - 16;
    drawText(canvas, "0.7K", textX, topY);
    drawText(canvas, "0.3K", textX, middleY);
    drawText(canvas, "0", textX, bottomY);
  }

  void drawDashedLine(
    Canvas canvas,
    Size size,
    double y,
    Paint paint,
    double leftPadding,
  ) {
    double dashWidth = 3, dashSpace = 3, startX = 0;
    while (startX < size.width - 30) {
      canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), paint);
      startX += dashWidth + dashSpace;
    }
  }

  void drawText(Canvas canvas, String text, double x, double y) {
    final textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 12,
    ); // Smaller font
    final textSpan = TextSpan(text: text, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(x, y - 7));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
