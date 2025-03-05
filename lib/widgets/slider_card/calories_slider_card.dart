import 'package:flutter/material.dart';
import 'package:smart_ring/widgets/slider_card/steps_slider_card.dart';

class CaloriesSliderCard extends StatefulWidget {
  const CaloriesSliderCard({super.key});

  @override
  State<CaloriesSliderCard> createState() => _CaloriesSliderCardState();
}

class _CaloriesSliderCardState extends State<CaloriesSliderCard>
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
              "Calories",
              style: TextStyle(
                color: Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
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
                        "Kcal",
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
                    _sliderValue = (details.localPosition.dx /
                            context.size!.width)
                        .clamp(0.0, 1.0);
                  });
                },
                onTapDown: (details) {
                  setState(() {
                    _sliderValue = (details.localPosition.dx /
                            context.size!.width)
                        .clamp(0.0, 1.0);
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
                  double graphWidth = MediaQuery.of(context).size.width - 32;
                  setState(() {
                    _sliderValue =
                        value *
                        (graphWidth /
                            context.size!.width); // Normalize movement
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
