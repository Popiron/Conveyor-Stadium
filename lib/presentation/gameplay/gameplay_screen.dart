import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:conveyor_stadium/configure_dependencies.dart';
import 'package:conveyor_stadium/domain/blocs/game_session/game_session_bloc.dart';
import 'package:conveyor_stadium/presentation/app_router.gr.dart';
import 'package:conveyor_stadium/presentation/common/background.dart';
import 'package:conveyor_stadium/presentation/gameplay/widgets/game_bar.dart';
import 'package:conveyor_stadium/presentation/gameplay/widgets/score_box.dart';
import 'package:conveyor_stadium/presentation/gameplay/widgets/stadium_tile.dart';
import 'package:conveyor_stadium/presentation/typography.dart';
import 'package:flutter/widgets.dart';
import 'package:conveyor_stadium/presentation/common/widget_list_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

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
      child: BlocBuilder<GameSessionBloc, GameSessionState>(
        builder: (context, state) {
          return Background(
            backgroundType: state.maybeMap(
                over: (_) => BackgroundType.onlyUpArrows,
                orElse: () => BackgroundType.clear),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
                child: Column(
                  children: [GameBar(), _game()].separated(
                      separator: () => const SizedBox(
                            height: 23,
                          )),
                ),
              ),
            ),
          );
        },
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
                      key: UniqueKey(),
                      id: i,
                      stadium: value.gameSession.stadiums[i],
                      fan: value.gameSession
                          .fans[value.gameSession.stadiums.length - 1 - i]);
                } else {
                  return StadiumTile(
                    id: i,
                    stadium: value.gameSession.stadiums[i],
                  );
                }
              })
            ],
          );
        }, over: (value) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScoreBox(
                score: value.score,
                size: 60,
                textStyle: TypographyUtil.baseTextStyle.highlighted(),
              ),
              const SizedBox(
                height: 32,
              ),
              GestureDetector(
                onTap: () {
                  AutoRouter.of(context).push(const ResultsRoute());
                },
                child: Container(
                  height: 58,
                  child: Image.asset('button_results_path'.tr()),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  AutoRouter.of(context).popUntilRoot();
                },
                child: Container(
                  height: 58,
                  child: Image.asset('button_menu_path'.tr()),
                ),
              ),
            ],
          );
          ;
        });
      },
    ));
  }
}
