import 'package:flutter/material.dart';
import 'package:positioned_tap_detector/positioned_tap_detector.dart';

void main() => runApp(Poss());

class Poss extends StatefulWidget {
  @override
  String text;

  Poss({Key key, @required this.text}) : super(key: key);
  PossState createState() => new PossState();

}

class PossState extends State<Poss> {
  TapPosition _position = TapPosition(Offset.zero, Offset.zero);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PositionedTapDetector(
                onTap: _onTap,
                child: Container(
                  width: 500.0,
                  height: 500.0,
                child:  Image.network(widget.text,
                      width: 500,
                      height: 500,
                      fit: BoxFit.fill),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                    "Position XY: ${x(_position.relative)}, ${y(_position.relative)}"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTap(TapPosition position) => _updateState('single tap', position);

  void _updateState(String gesture, TapPosition position) {
    setState(() {
      _position = position;
    });
  }

  String x(Offset offset) =>
      "${offset.dx.toStringAsFixed(1)}";

  String y(Offset offset) =>
      "${offset.dy.toStringAsFixed(1)}";
}