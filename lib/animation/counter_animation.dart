import 'package:flutter/material.dart';

class CounterAnimation extends StatefulWidget {
  @override
  _CounterAnimationState createState() => _CounterAnimationState();
}

class _CounterAnimationState extends State<CounterAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation = new Tween(begin: 0.0,end: 1.0).animate(_controller)
    ..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        _controller.reverse(from: 5.0);
      }
    })
    ..addListener(() {
      this.setState(() {
        _counter++;
        debugPrint('here ${animation.value}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward(from: 0.0);
      },
      child: Text(
        _controller.isAnimating ? (_counter).toStringAsFixed(2) : "Let's Begin",
        style: TextStyle(fontSize: 24.0 * animation.value + 16.0),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
