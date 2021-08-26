import 'dart:async';

import 'package:conveyor_stadium/configure_dependencies.dart';
import 'package:conveyor_stadium/domain/blocs/game_session/game_session_bloc.dart';
import 'package:conveyor_stadium/presentation/common/background.dart';
import 'package:conveyor_stadium/presentation/gameplay/widgets/game_bar.dart';
import 'package:conveyor_stadium/presentation/gameplay/widgets/stadium_tile.dart';
import 'package:conveyor_stadium/presentation/typography.dart';
import 'package:flutter/widgets.dart';
import 'package:conveyor_stadium/presentation/common/widget_list_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamePlayScreen extends StatefulWidget {
  const GamePlayScreen({Key? key}) : super(key: key);

  @override
  _GamePlayScreenState createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen> {
  final _bloc = getIt.get<GameSessionBloc>();

  @override
  void initState() {
    _bloc.add(const GameSessionEvent.started());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _bloc,
      child: Background(
        backgroundType: BackgroundType.clear,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
            child: Column(
              children: [GameBar(), _game()].separated(
                  separator: () => const SizedBox(
                        height: 23,
                      )),
            ),
          ),
        ),
      ),
    );
  }

  Widget _game() {
    return Expanded(
        child: BlocBuilder<GameSessionBloc, GameSessionState>(
      bloc: _bloc,
      builder: (context, state) {
        return state.map(initial: (value) {
          return Container();
        }, nextTick: (value) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List<StadiumTile>.generate(value.gameSession.stadiums.length,
                  (i) {
                if (value.gameSession.fans
                    .asMap()
                    .containsKey(value.gameSession.stadiums.length - 1 - i)) {
                  return StadiumTile(
                      id: i,
                      stadium: value.gameSession.stadiums[i],
                      fan: value.gameSession
                          .fans[value.gameSession.stadiums.length - 1 - i]);
                } else
                  return StadiumTile(
                    id: i,
                    stadium: value.gameSession.stadiums[i],
                  );
              })
            ],
          );
        }, finished: (value) {
          return Container();
        });
      },
    ));
  }
}
