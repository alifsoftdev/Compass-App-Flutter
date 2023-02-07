import 'dart:math';
import 'package:compass_app/const/AppColor.dart';
import 'package:flutter/material.dart';

class CompassViewPrinter extends CustomPainter {
  final Color color;
  final int majorTickerCount;
  final int minorTickerCount;
  final CardinalityMap cardinalityMap;

  CompassViewPrinter(
      {required this.color,
      this.majorTickerCount = 18,
      this.minorTickerCount = 90,
      this.cardinalityMap = const {0: 'N', 90: 'E', 180: 'S', 270: 'W'}});

  late final majorScalePaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = color
    ..strokeWidth = 2.0;

  late final minorScalePaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = color
    ..strokeWidth = 1.0;

  late final majorScaleStyle = TextStyle(color: color, fontSize: 12);

  late final cardinalityStyle = const TextStyle(
      color: AppColor.black, fontSize: 20, fontWeight: FontWeight.bold);

  late final _majorTicks = _layoutScal(majorTickerCount);
  late final _minorTicks = _layoutScal(minorTickerCount);
  late final _angleDegree = _layoutAngleScal(_majorTicks);

  @override
  void paint(Canvas canvas, Size size) {
    const origin = Offset.zero;
    final center = size.center(origin);
    final radius = size.width / 2;

    final majorTickLength = size.width * 0.08;
    final minorTickLength = size.width * 0.055;
    canvas.save();
    //paint major scale
    for (final angle in _majorTicks) {
      final tickStart = Offset.fromDirection(
        _currectAngle(angle).toRadians(),
        radius,
      );
      final tickEnd = Offset.fromDirection(
        _currectAngle(angle).toRadians(),
        radius - majorTickLength,
      );
      canvas.drawLine(center + tickStart, center + tickEnd, majorScalePaint);
    }
    //paint minor scale
    for (final angle in _minorTicks) {

      final tickStart = Offset.fromDirection(
        _currectAngle(angle).toRadians(),
        radius,
      );
      final tickEnd = Offset.fromDirection(
        _currectAngle(angle).toRadians(),
        radius - minorTickLength,
      );
      canvas.drawLine(center + tickStart, center + tickEnd, minorScalePaint);
    }
    //paint Angle Degree
    for (final angle in _angleDegree) {
      final textpadding=majorTickLength-size.width*0.02;
      final textPainter =
          TextSpan(
              text: angle.toStringAsFixed(0),
              style: majorScaleStyle)
              .toPainter()
            ..layout();
      final layoutOffset = Offset.fromDirection(
        _currectAngle(angle).toRadians(),
        radius-textpadding,
      );
      final offset= center+layoutOffset;
      canvas.restore();
      canvas.save();
      canvas.translate(offset.dx, offset.dy);
      canvas.rotate(angle.toRadians());
      canvas.translate(-offset.dx, -offset.dy);
      textPainter.paint(canvas, Offset(offset.dx-(textPainter.width/2),offset.dy));
    }

    //paint Cardinality Text
    for (final cardinality in cardinalityMap.entries) {
      final textpadding=majorTickLength+size.width*0.01;
      final angle= cardinality.key.toDouble();
      final text=cardinality.value;
      final textPainter =
      TextSpan(
          text: text,
          style: cardinalityStyle.copyWith(color: text=="N" ? AppColor.red:null))
          .toPainter()
        ..layout();
      final layoutOffset = Offset.fromDirection(
        _currectAngle(angle).toRadians(),
        radius-textpadding,
      );
      final offset= center+layoutOffset;
      canvas.restore();
      canvas.save();
      canvas.translate(offset.dx, offset.dy);
      canvas.rotate(angle.toRadians());
      canvas.translate(-offset.dx, -offset.dy);
      textPainter.paint(canvas, Offset(offset.dx-(textPainter.width/2),offset.dy));
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  List<double> _layoutScal(int ticks) {
    final scale = 360 / ticks;
    return List.generate(ticks, (index) => index * scale);
  }

  List<double> _layoutAngleScal(List<double> ticks) {
    List<double> angle = [];
    for (var i = 0; i < ticks.length; i++) {
      if (i == ticks.length - 1) {
        double degreeVal = (ticks[i] + 360) / 2;
        angle.add(degreeVal);
      } else {
        double degreeVal = (ticks[i] + ticks[i + 1]) / 2;
        angle.add(degreeVal);
      }
    }
    return angle;
  }

  double _currectAngle(double angle) => angle - 90;
}

typedef CardinalityMap = Map<num, String>;

extension on TextSpan {
  TextPainter toPainter({TextDirection textDirection = TextDirection.ltr}) =>
      TextPainter(text: this, textDirection: textDirection);
}

extension on num {
  double toRadians() => this * pi / 180;
}
