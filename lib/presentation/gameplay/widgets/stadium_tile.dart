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
  final bool isLast;
  final bool isFirst;
  const StadiumTile({
    Key? key,
    required this.id,
    required this.stadium,
    required this.isLast,
    required this.isFirst,
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
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: [
                      if (widget.fan != null)
                        Align(
                          child: GestureDetector(
                            onTap: () {
                              _bloc.add(
                                  const StadiumTileEvent.changedDirection());
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Container(
                                    height: 53,
                                    child: state.maybeMap(
                                        directionForward: (_) => !widget.isLast
                                            ? Image.asset(
                                                "assets/images/arrow.png")
                                            : Container(),
                                        orElse: () => const SizedBox.shrink()),
                                  ),
                                ),
                                if (!widget.isLast)
                                  const SizedBox(
                                    height: 18,
                                  ),
                                Container(
                                  height: 70,
                                  child: Image.asset(widget.fan!.imgPath),
                                ),
                                const SizedBox(
                                  height: 22,
                                ),
                                if (widget.isFirst)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Container(
                                      height: 53,
                                      child: Image.asset(
                                          "assets/images/arrow.png"),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      if (widget.fan != null)
                        state.maybeMap(
                          directionLeft: (_) => Positioned(
                            left: 7.0,
                            child: Container(
                              height: 30,
                              child: Image.asset("assets/images/arrow_l.png"),
                            ),
                          ),
                          directionRight: (_) => Positioned(
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
