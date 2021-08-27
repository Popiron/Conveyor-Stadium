import 'package:conveyor_stadium/domain/blocs/game_session/game_session_bloc.dart';
import 'package:conveyor_stadium/presentation/gameplay/widgets/score_box.dart';
import 'package:flutter/widgets.dart';
import 'package:conveyor_stadium/presentation/common/widget_list_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../typography.dart';

class GameBar extends StatefulWidget {
  GameBar({Key? key}) : super(key: key);

  @override
  _GameBarState createState() => _GameBarState();
}

class _GameBarState extends State<GameBar> {
  GameSessionBloc get _bloc => BlocProvider.of<GameSessionBloc>(context);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameSessionBloc, GameSessionState>(
      bloc: _bloc,
      builder: (context, state) {
        return state.map(initial: (value) {
          return Container();
        }, nextTick: (value) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ScoreBox(
                score: value.gameSession.score,
                size: 50,
                textStyle: TypographyUtil.smallText.highlighted(),
              ),
              _heartsBox(countHearts: value.gameSession.hearts),
            ],
          );
        }, over: (value) {
          return Container();
        });
      },
    );
  }
}

Widget _heartsBox({required int countHearts}) {
  List<Widget> hearts = List.filled(
    countHearts,
    Container(
      height: 32,
      child: Image.asset("assets/images/heart.png"),
    ),
  );
  return Container(
    height: 32,
    child: Row(
      children: [...hearts].separated(
          separator: () => const SizedBox(
                width: 4,
              )),
    ),
  );
}
