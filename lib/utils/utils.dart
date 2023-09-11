import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
List<String> getLyrics() {
  return ['Hope stopped the heart',
  'Lost beaten lie',
  'Cold walk the earth',
  'Love faded white',
  'Gave up the war',
  'I\'ve realized',
  'All will become',
  'All will arise',
  'Stay with me',
  'I hear them call the tide',
  'Take me in',
  'I see the last divide',
  'Hopelessy',
  'I leave this all behind',
  'And I am paralyzed',
  'When the broken fall alive',
  'Let the light take me too',
  'When the waters turn to fire',
  'Heaven, please let me through',
  'Far away, far away',
  'Sorrow has left me here',
  'Far away, far away',
  'Let the light take me in',
  'Fight back the flood',
  'One breath of life',
  'God, take the earth',
  'Forever blind',
  'And now the sun will fade',
  'And all we are is all we made',
  'Stay with me',
  'I hear them call the tide',
  'Take me in',
  'I see the last divide',
  'Hopelessy',
  'I leave this all behind',
  'And I am paralyzed',
  'When the broken fall alive',
  'Let the light take me too',
  'When the waters…'];
  }




class InnerShadow extends SingleChildRenderObjectWidget {
  const InnerShadow({
    Key? key,
    this.blur = 10,
    this.color = Colors.black38,
    this.offset = const Offset(10, 10),
    Widget? child,
  }) : super(key: key, child: child);

  final double blur;
  final Color color;
  final Offset offset;

  @override
  RenderObject createRenderObject(BuildContext context) {
    final _RenderInnerShadow renderObject = _RenderInnerShadow();
    updateRenderObject(context, renderObject);
    return renderObject;
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderInnerShadow renderObject) {
    renderObject
      ..color = color
      ..blur = blur
      ..dx = offset.dx
      ..dy = offset.dy;
  }
}

class _RenderInnerShadow extends RenderProxyBox {
  double? blur;
  Color? color;
  double? dx;
  double? dy;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) return;

    final Rect rectOuter = offset & size;
    final Rect rectInner = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      size.width - dx!,
      size.height - dy!,
    );
    final Canvas canvas = context.canvas..saveLayer(rectOuter, Paint());
    context.paintChild(child!, offset);
    final Paint shadowPaint = Paint()
      ..blendMode = BlendMode.srcATop
      ..imageFilter = ImageFilter.blur(sigmaX: blur!, sigmaY: blur!)
      ..colorFilter = ColorFilter.mode(color!, BlendMode.srcOut);

    canvas
      ..saveLayer(rectOuter, shadowPaint)
      ..saveLayer(rectInner, Paint())
      ..translate(dx!, dy!);
    context.paintChild(child!, offset);
    context.canvas..restore()..restore()..restore();
  }
}