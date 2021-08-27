import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:conveyor_stadium/configure_dependencies.dart';
import 'package:conveyor_stadium/domain/blocs/top_scores/top_scores_bloc.dart';
import 'package:conveyor_stadium/domain/models/top_scores.dart';
import 'package:conveyor_stadium/presentation/common/background.dart';
import 'package:conveyor_stadium/presentation/typography.dart';
import 'package:flutter/widgets.dart';
import 'package:conveyor_stadium/presentation/common/widget_list_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final _bloc = getIt.get<TopScoresBloc>();
  @override
  void initState() {
    _bloc.add(const TopScoresEvent.started());
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
      create: (context) => _bloc,
      child: Background(
        backgroundType: BackgroundType.onlyUpArrows,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 77.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  BlocBuilder<TopScoresBloc, TopScoresState>(
                      bloc: _bloc,
                      builder: (context, state) {
                        return state.when(initial: () {
                          return const SizedBox.shrink();
                        }, ready: (scores) {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _resultTile(place: 1, score: scores[0]),
                                _resultTile(place: 2, score: scores[1]),
                                _resultTile(place: 3, score: scores[2]),
                              ].separated(
                                separator: () => Image.asset(
                                    "assets/images/horizontal_line.png"),
                                //),
                              ));
                        });
                      }),
                  Positioned(
                    left: 70,
                    child: Container(
                      height: 160,
                      child: Image.asset("assets/images/vertical_line.png"),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 25,
              bottom: 25,
              child: GestureDetector(
                onTap: () => AutoRouter.of(context).popUntilRoot(),
                child: Container(
                  height: 60,
                  child: Image.asset("assets/images/button_back.png"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _resultTile({required int place, required int score}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10, left: 27),
      child: Row(
        children: [
          Text(
            place.toString(),
            style: TypographyUtil.baseTextStyle.highlighted(),
          ),
          const SizedBox(
            width: 64,
          ),
          FittedBox(
            child: Text(
              score.toString(),
              style: TypographyUtil.baseTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
