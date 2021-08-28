import 'package:conveyor_stadium/configure_dependencies.dart';
import 'package:conveyor_stadium/domain/blocs/game_session/game_session_bloc.dart';
import 'package:conveyor_stadium/domain/blocs/stadium_tile/stadium_tile_bloc.dart';
import 'package:conveyor_stadium/domain/models/direction.dart';
import 'package:conveyor_stadium/domain/models/fan.dart';
import 'package:conveyor_stadium/domain/models/stadium.dart';
import 'package:flutter/material.dart';
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
      child: Column(children: [
        if (!widget.isLast)
          BlocBuilder<StadiumTileBloc, StadiumTileState>(
              bloc: _bloc,
              builder: (context, state) {
                return _forwardArrow(
                    isVisible: state.maybeMap(
                        directionForward: (_) => true, orElse: () => false));
              }),
        _mainTile(),
        if (widget.isFirst) _forwardArrow(isVisible: true)
      ]),
    );
  }

  Widget _forwardArrow({required bool isVisible}) {
    return Row(children: [
      Container(
        height: 79,
        child: Image.asset(
          widget.stadium.imgPath,
          color: Colors.transparent,
        ),
      ),
      Flexible(
          child: Align(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Container(
            height: 53,
            child: isVisible
                ? Image.asset("assets/images/arrow.png")
                : const SizedBox.shrink(),
          ),
        ),
      )),
    ]);
  }

  Widget _mainTile() {
    return Row(
      children: [
        Container(
          height: 79,
          child: Image.asset(widget.stadium.imgPath),
        ),
        Flexible(
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
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 30,
                    child: state.maybeMap(
                        directionLeft: (_) =>
                            Image.asset("assets/images/arrow_l.png"),
                        orElse: () => Image.asset("assets/images/arrow_l.png",
                            color: Colors.transparent)),
                  ),
                  if (widget.fan != null)
                    Align(
                      child: GestureDetector(
                        onTap: () {
                          _bloc.add(const StadiumTileEvent.changedDirection());
                        },
                        child: Container(
                          height: 70,
                          child: Image.asset(widget.fan!.imgPath),
                        ),
                      ),
                    ),
                  Container(
                    height: 30,
                    child: state.maybeMap(
                        directionRight: (_) =>
                            Image.asset("assets/images/arrow_r.png"),
                        orElse: () => Image.asset("assets/images/arrow_l.png",
                            color: Colors.transparent)),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
