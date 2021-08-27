import 'package:conveyor_stadium/presentation/typography.dart';
import 'package:flutter/widgets.dart';

class ScoreBox extends StatelessWidget {
  final int score;
  final int size;
  final TextStyle textStyle;
  const ScoreBox(
      {Key? key,
      required this.score,
      required this.size,
      required this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.toDouble(),
      width: size.toDouble(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/images/score_border.png",
            fit: BoxFit.contain,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                score.toString(),
                style: textStyle,
              ),
            ),
          )
        ],
      ),
    );
  }
}
