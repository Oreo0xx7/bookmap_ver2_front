import 'package:flutter/material.dart';

class BookMap extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column();
  }
}

// TabBar indicator decoration
class CircleTabIndicator extends Decoration{
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}
class _CirclePainter extends BoxPainter{
  final double radius;
  late Color color;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint ..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(configuration.size!.width / 2, configuration.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}