import 'dart:collection';

import 'package:conveyor_stadium/configure_dependencies.dart';
import 'package:conveyor_stadium/domain/blocs/game_session/game_session_bloc.dart';
import 'package:conveyor_stadium/domain/blocs/stadium_tile/stadium_tile_bloc.dart';
import 'package:conveyor_stadium/domain/models/direction.dart';
import 'package:conveyor_stadium/domain/models/fan.dart';
import 'package:conveyor_stadium/domain/models/fan_type.dart';
import 'package:conveyor_stadium/domain/models/stadium.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StadiumTile extends StatefulWidget {
  final int id;
  final Stadium stadium;
  final Fan? fan;
  const StadiumTile({
    Key? key,
    required this.id,
    required this.stadium,
    this.fan,
  }) : super(key: key);

  @override
  _StadiumTileState createState() => _StadiumTileState();
}

class _StadiumTileState extends State<StadiumTile> {
  final _bloc = getIt.get<StadiumTileBloc>();
  GameSessionBloc get _gameSessionBloc =>
      BlocProvider.of<GameSessionBloc>(context);

  @override
  void initState() {
    _bloc.add(const StadiumTileEvent.started());
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
      child: Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 79,
              child: Image.asset(widget.stadium.imgPath),
            ),
            Expanded(
              child: BlocConsumer<StadiumTileBloc, StadiumTileState>(
                listener: (context, state) {
                  if (widget.fan != null) {
                    state.when(directionLeft: () {
                      _gameSessionBloc.add(GameSessionEvent.changedDirection(
                          widget.id, Direction.left));
                    }, directionRight: () {
                      _gameSessionBloc.add(GameSessionEvent.changedDirection(
                          widget.id, Direction.right));
                    }, directionForward: () {
                      _gameSessionBloc.add(GameSessionEvent.changedDirection(
                          widget.id, Direction.forward));
                    });
                  }
                },
                builder: (context, state) {
                  return Stack(
                    alignment: Alignment.topCenter,
                    fit: StackFit.expand,
                    children: [
                      if (widget.fan != null)
                        Positioned(
                          top: 0.0,
                          child: GestureDetector(
                            onTap: () {
                              _bloc.add(
                                  const StadiumTileEvent.changedDirection());
                            },
                            child: Container(
                              height: 70,
                              child: Image.asset(widget.fan!.imgPath),
                            ),
                          ),
                        ),
                      Positioned(
                        bottom: 20.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Container(
                            height: 53,
                            child: Image.asset("assets/images/arrow.png"),
                          ),
                        ),
                      ),
                      state.maybeMap(
                        directionLeft: (_) => Positioned(
                          top: 20,
                          left: 7.0,
                          child: Container(
                            height: 30,
                            child: Image.asset("assets/images/arrow_l.png"),
                          ),
                        ),
                        orElse: () => const SizedBox.shrink(),
                      ),
                      state.maybeMap(
                        directionRight: (_) => Positioned(
                          top: 20,
                          right: 7.0,
                          child: Container(
                            height: 30,
                            child: Image.asset("assets/images/arrow_r.png"),
                          ),
                        ),
                        orElse: () => const SizedBox.shrink(),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
