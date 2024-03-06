import 'package:flutter/material.dart';

class TweenSequenceDemo extends StatefulWidget {
  const TweenSequenceDemo({key});
  static const String routeName = '/basics/chaining_tweens';

  @override
  State<TweenSequenceDemo> createState() => _TweenSequenceDemoState();
}

class _TweenSequenceDemoState extends State<TweenSequenceDemo>
    with SingleTickerProviderStateMixin {
  static const Duration duration = Duration(seconds: 3);
    AnimationController? controller;
    Animation<Color>? animation;

  static final colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  @override
  void initState() {
    super.initState();

    final sequenceItems = <TweenSequenceItem<Color>>[];

    for (var i = 0; i < colors.length; i++) {
      final beginColor = colors[i];
      final endColor = colors[(i + 1) % colors.length];
      final weight = 1 / colors.length;

      sequenceItems.add(
        TweenSequenceItem<Color>(
          tween: Tween(begin: beginColor, end: endColor).chain(CurveTween(curve: Curves.easeIn)),
          weight: weight,
        ),
      );
    }

    controller = AnimationController(duration: duration, vsync: this);
    animation = TweenSequence<Color>(sequenceItems).animate(controller!);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tween Sequences'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: animation!,
          builder: (context, child) {
            return MaterialButton(
              color: animation!.value,
              onPressed: () async {
                await controller!.forward();
                controller!.reset();
              },
              child: child,
            );
          },
          child: const Text('Animate', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}