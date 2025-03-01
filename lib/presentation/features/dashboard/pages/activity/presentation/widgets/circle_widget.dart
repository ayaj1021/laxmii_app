import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircleSegment {
  final Color color;
  final double value;

  CircleSegment({
    required this.color,
    required this.value,
  });
}

class SegmentedCircle extends StatelessWidget {
  final double size;
  final List<CircleSegment> segments;
  final double strokeWidth;
  final double gapAngle;

  const SegmentedCircle({
    super.key,
    this.size = 200,
    required this.segments,
    this.strokeWidth = 30,
    this.gapAngle = 0.4,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: SegmentedCirclePainter(
              segments: segments,
              strokeWidth: strokeWidth,
              gapAngle: gapAngle,
            ),
          ),
        ),
      ],
    );
  }
}

class SegmentedCirclePainter extends CustomPainter {
  final List<CircleSegment> segments;
  final double strokeWidth;
  final double gapAngle;

  SegmentedCirclePainter({
    required this.segments,
    required this.strokeWidth,
    required this.gapAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (segments.isEmpty) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Calculate total value for proportions
    final totalValue =
        segments.fold<double>(0, (sum, segment) => sum + segment.value);

    // Total available angle after subtracting gaps
    final totalAvailableAngle = 2 * math.pi - (gapAngle * segments.length);

    double currentAngle = 0;

    for (var i = 0; i < segments.length; i++) {
      final segment = segments[i];
      // Calculate segment angle proportional to its value
      final segmentAngle = (segment.value / totalValue) * totalAvailableAngle;

      final paint = Paint()
        ..color = segment.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        currentAngle,
        segmentAngle,
        false,
        paint,
      );

      // Update current angle for next segment, including gap
      currentAngle += segmentAngle + gapAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
