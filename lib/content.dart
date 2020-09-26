import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Content extends StatefulWidget {
  @override
  _Content createState() => _Content();
}

class _Content extends State<Content> {
  @override
  void initState() {
    final random = Random();
    _timer = new Timer.periodic(
      const Duration(milliseconds: 23),
      (Timer timer) {
        setState(() {
          tick = timer.tick;
          points.add(Point(
            random.nextDouble() * width,
            random.nextDouble() * height,
          ));
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Timer _timer;
  final points = <Point>[];
  int tick;
  double width, height;

  void _onPointerMove(PointerEvent details) {
    print(details);
    setState(() {
      points.add(Point(
        details.position.dx,
        details.position.dy,
      ));
    });
  }

  void _reset() {
    print('reset');
    setState(() {
      points.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    final content = points.map((point) {
      return Positioned(
        left: point.x,
        top: point.y,
        child: Container(
          child: Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }).toList();

    content.add(Positioned(
      child: Center(
        child: Text(tick.toString()),
      ),
    ));

    content.add(Positioned(
      bottom: 50,
      left: 0,
      right: 0,
      child: Center(
        child: InkWell(
          onTap: _reset,
          highlightColor: Colors.blue,
          splashColor: Colors.blue,
          child: SizedBox(
            width: 50,
            height: 20,
            child: Container(
              child: Text('reset'),
            ),
          ),
        ),
      ),
    ));

    return Listener(
      onPointerMove: _onPointerMove,
      child: SizedBox.expand(
        child: Container(
          color: Colors.white,
          child: Stack(
            children: content,
          ),
        ),
      ),
    );
  }
}

class Point {
  final double x, y;
  Point(this.x, this.y);
}
