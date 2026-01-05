// ignore_for_file: prefer_asserts_with_message, document_ignores

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:ask_gemini_button/gemini_icon.dart';
import 'package:flutter/material.dart';
import 'package:material_shapes/material_shapes.dart' hide Cubic;

class AskGeminiButton extends StatefulWidget {
  const AskGeminiButton({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  @override
  State<AskGeminiButton> createState() => _AskGeminiButtonState();
}

class _AskGeminiButtonState extends State<AskGeminiButton>
    with TickerProviderStateMixin {
  static final RoundedPolygon _hexagon = RoundedPolygon.fromVerticesNum(
    6,
    rounding: const CornerRounding(radius: 0.4),
  ).normalized();

  static const _morphCurve = Cubic(0.19, 1, 0.22, 1);

  final _focusNode = FocusNode();

  late final Map<Type, Action<Intent>> _actions = <Type, Action<Intent>>{
    ActivateIntent: CallbackAction<ActivateIntent>(
      onInvoke: (_) => widget.onTap(),
    ),
    ButtonActivateIntent: CallbackAction<ButtonActivateIntent>(
      onInvoke: (_) => widget.onTap(),
    ),
  };

  late final _iconEffectsController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  );

  late final _iconEffectsAnimation = CurvedAnimation(
    parent: _iconEffectsController,
    curve: Curves.ease,
    reverseCurve: Curves.ease.flipped,
  );

  late final Animation<double> _iconAngle = Tween<double>(
    begin: 0,
    end: math.pi,
  ).animate(_iconEffectsAnimation);

  late final Animation<Color?> _iconColor = ColorTween(
    begin: const Color(0xFF606368),
    end: const Color(0xFFFFFFFF),
  ).animate(_iconEffectsAnimation);

  late final _scaleController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  late final _scale = CurvedAnimation(
    parent: _scaleController,
    curve: const Cubic(0, 0, 0, 1),
    reverseCurve: const Cubic(0, 0, 0, 1).flipped,
  );

  late final _angleController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 7000),
  );

  late final Animation<double> _angle = Tween<double>(
    begin: 0,
    end: math.pi * 2,
  ).animate(_angleController);

  late final _shimmerController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2100),
  );

  late final _morphController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 5000),
  );

  late final Animation<Morph> _morph;

  late final Animation<double> _morphProgress;

  @override
  void initState() {
    super.initState();

    final shapes = [
      MaterialShapes.circle,
      MaterialShapes.cookie9Sided,
      MaterialShapes.pill,
      _hexagon,
    ];
    assert(shapes.length == 4);

    TweenSequenceItem<Morph> getMorphSequenceItem({
      required int index,
      required double weight,
    }) {
      return TweenSequenceItem(
        tween: ConstantTween(
          Morph(
            shapes[index % shapes.length],
            shapes[(index + 1) % shapes.length],
          ),
        ),
        weight: weight,
      );
    }

    _morph = TweenSequence<Morph>([
      getMorphSequenceItem(index: 0, weight: 40),
      getMorphSequenceItem(index: 1, weight: 20),
      getMorphSequenceItem(index: 2, weight: 20),
      getMorphSequenceItem(index: 3, weight: 20),
    ]).animate(_morphController);

    TweenSequenceItem<double> getMorphProgressSequenceItem({
      required double holdWeight,
      required double totalWeight,
    }) {
      return TweenSequenceItem(
        tween: TweenSequence<double>([
          TweenSequenceItem(tween: ConstantTween(0), weight: holdWeight),
          TweenSequenceItem(
            tween: Tween<double>(begin: 0, end: 1).chain(
              CurveTween(curve: _morphCurve),
            ),
            weight: totalWeight - holdWeight,
          ),
        ]),
        weight: totalWeight,
      );
    }

    _morphProgress = TweenSequence<double>([
      getMorphProgressSequenceItem(holdWeight: 30, totalWeight: 40),
      getMorphProgressSequenceItem(holdWeight: 15, totalWeight: 20),
      getMorphProgressSequenceItem(holdWeight: 15, totalWeight: 20),
      getMorphProgressSequenceItem(holdWeight: 15, totalWeight: 20),
    ]).animate(_morphController);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _iconEffectsController.dispose();
    _iconEffectsAnimation.dispose();
    _scaleController.dispose();
    _scale.dispose();
    _angleController.dispose();
    _shimmerController.dispose();
    _morphController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Semantics(
        container: true,
        button: true,
        enabled: true,
        onTap: widget.onTap,
        label: 'Ask Gemini',
        child: Tooltip(
          message: 'Ask Gemini',
          textStyle: const TextStyle(
            fontFamily: 'GoogleSansFlex',
            fontSize: 12,
            height: 16 / 12,
            letterSpacing: 0.1,
            fontVariations: [FontVariation.weight(400)],
            color: Color(0xFFF2F2F2),
          ),
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: const BoxDecoration(
            color: Color(0xFF303030),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          preferBelow: true,
          waitDuration: const Duration(milliseconds: 1000),
          child: FocusableActionDetector(
            actions: _actions,
            focusNode: _focusNode,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) {
                _iconEffectsController.forward();
                _scaleController.forward();
                _angleController.repeat();
                _shimmerController.repeat();
                _morphController.repeat();
              },
              onExit: (_) {
                _iconEffectsController.reverse();
                _scaleController.reverse();
                _shimmerController.stop();
                _angleController.stop();
                _morphController.stop();
              },
              child: GestureDetector(
                onTap: widget.onTap,
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size.square(48)),
                  child: CustomPaint(
                    painter: _FocusBorderPainter(focusNode: _focusNode),
                    child: Center(
                      widthFactor: 1,
                      heightFactor: 1,
                      child: ConstrainedBox(
                        constraints: BoxConstraints.tight(
                          const Size.square(40),
                        ),
                        child: CustomPaint(
                          painter: _BackgroundPainter(
                            morph: _morph,
                            morphProgress: _morphProgress,
                            scale: _scale,
                            angle: _angle,
                            shimmer: _shimmerController,
                          ),
                          child: Center(
                            widthFactor: 1,
                            heightFactor: 1,
                            child: AnimatedBuilder(
                              animation: _iconEffectsAnimation,
                              builder: (context, _) {
                                return Transform.rotate(
                                  angle: _iconAngle.value,
                                  child: GeminiIcon(color: _iconColor.value!),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FocusBorderPainter extends CustomPainter {
  _FocusBorderPainter({
    required this.focusNode,
  }) : super(repaint: focusNode);

  final FocusNode focusNode;

  @override
  void paint(Canvas canvas, Size size) {
    if (!focusNode.hasFocus) {
      return;
    }

    final rect = Offset.zero & size;
    final center = rect.center;

    canvas.drawCircle(
      center,
      rect.width / 2 - 0.5,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..color = const Color(0xFF296297),
    );
  }

  @override
  bool shouldRepaint(_FocusBorderPainter oldDelegate) {
    return oldDelegate.focusNode != focusNode;
  }
}

class _BackgroundPainter extends CustomPainter {
  _BackgroundPainter({
    required this.scale,
    required this.angle,
    required this.shimmer,
    required this.morph,
    required this.morphProgress,
  }) : super(
         repaint: Listenable.merge([
           scale,
           angle,
           shimmer,
           morph,
           morphProgress,
         ]),
       );

  final Animation<double> scale;

  final Animation<double> angle;

  final Animation<double> shimmer;

  final Animation<Morph> morph;

  final Animation<double> morphProgress;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = this.scale.value;

    if (scale == 0) {
      return;
    }

    final rect = Offset.zero & size;
    final center = rect.center;

    final path = morph.value.toPath(progress: morphProgress.value);

    final shimmerProgress = shimmer.value;
    const shimmerScale = 6;
    final shimmerPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(
          shimmerScale - (shimmerProgress * shimmerScale),
          shimmerScale - (shimmerProgress * shimmerScale),
        ),
        Offset(
          0 - (shimmerProgress * shimmerScale),
          0 - (shimmerProgress * shimmerScale),
        ),
        [
          const Color(0xFF217BFE),
          const Color(0xFFAC87EB),
          const Color(0xFF078EFB),
          const Color(0xFF217BFE),
        ],
        [0, 1 / 3, 2 / 3, 1],
        TileMode.repeated,
      );

    canvas
      ..save()
      ..translate(center.dx, center.dy)
      ..rotate(angle.value)
      ..scale(scale)
      ..translate(-center.dx, -center.dy)
      ..scale(size.width)
      ..drawPath(path, shimmerPaint)
      ..restore();
  }

  @override
  bool shouldRepaint(_BackgroundPainter oldDelegate) {
    return oldDelegate.angle != angle ||
        oldDelegate.scale != scale ||
        oldDelegate.shimmer != shimmer ||
        oldDelegate.morph != morph ||
        oldDelegate.morphProgress != morphProgress;
  }
}
