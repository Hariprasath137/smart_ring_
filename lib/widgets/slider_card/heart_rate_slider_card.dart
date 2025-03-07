import 'package:flutter/material.dart';

class HeartRateSliderCard extends StatefulWidget {
  const HeartRateSliderCard({super.key});

  @override
  State<HeartRateSliderCard> createState() => _HeartRateSliderCardState();
}

class _HeartRateSliderCardState extends State<HeartRateSliderCard>
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
    double graphPadding = 30; // Adjusted padding for alignment

    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Scheduled heart rate data",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  Text(
                    getFormattedTime(),
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 100,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    _sliderValue = ((details.localPosition.dx - graphPadding) /
                            (300 - graphPadding * 2))
                        .clamp(0.0, 1.0);
                  });
                },
                onTapDown: (details) {
                  setState(() {
                    _sliderValue = ((details.localPosition.dx - graphPadding) /
                            (300 - graphPadding * 2))
                        .clamp(0.0, 1.0);
                  });
                },
                child: CustomPaint(
                  painter: StepGraphPainter(_sliderValue, graphPadding),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: graphPadding),
              child: Row(
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
            ),
            const SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: graphPadding),
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 2,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 12,
                  ),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 15,
                  ),
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
            ),
          ],
        ),
      ),
    );
  }
}

class StepGraphPainter extends CustomPainter {
  final double sliderValue;
  final double graphPadding;

  StepGraphPainter(this.sliderValue, this.graphPadding);

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint =
        Paint()
          ..color = Colors.grey
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke;

    // Paint verticalLinePaint =
    //     Paint()
    //       ..color = Colors.red
    //       ..strokeWidth = 1.5;

    double topY = 10;
    double middleTopY = 40;
    double middleY = 70;
    double bottomY = 100;

    drawDashedLine(canvas, size, topY, dashedPaint);
    drawDashedLine(canvas, size, middleTopY, dashedPaint);
    drawDashedLine(canvas, size, middleY, dashedPaint);
    drawDashedLine(canvas, size, bottomY, dashedPaint);

    double verticalX =
        graphPadding + (sliderValue * (size.width - graphPadding * 2));

    /// Gradient Paint for Vertical Line
    Paint verticalLinePaint =
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.red.withOpacity(0.1), // Sharp at the top
              Colors.red, // Faded in the middle
              Colors.red.withOpacity(0.1), // Sharp at the bottom
            ],
          ).createShader(
            Rect.fromPoints(
              Offset(verticalX, 1),
              Offset(verticalX, bottomY + 10),
            ),
          )
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(verticalX, 1),
      Offset(verticalX, bottomY + 10),
      verticalLinePaint,
    );

    double textX = 5;
    drawText(canvas, "175", textX, topY);
    drawText(canvas, "150", textX, middleTopY);
    drawText(canvas, "130", textX, middleY);
    drawText(canvas, "  85", textX, bottomY);
  }

  void drawDashedLine(Canvas canvas, Size size, double y, Paint paint) {
    double dashWidth = 3, dashSpace = 3, startX = graphPadding;
    while (startX < size.width - graphPadding) {
      canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), paint);
      startX += dashWidth + dashSpace;
    }
  }

  void drawText(Canvas canvas, String text, double x, double y) {
    final textStyle = const TextStyle(color: Colors.white, fontSize: 12);
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
