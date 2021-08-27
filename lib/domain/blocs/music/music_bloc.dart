import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'music_event.dart';
part 'music_state.dart';
part 'music_bloc.freezed.dart';

@injectable
class MusicBloc extends Bloc<MusicEvent, MusicState> {
  MusicBloc() : super(_Initial());
  final assetsAudioPlayer = AssetsAudioPlayer();
  @override
  Stream<MusicState> mapEventToState(
    MusicEvent event,
  ) async* {
    yield* event.when(started: () async* {
      await assetsAudioPlayer.open(
        Audio("assets/sounds/track_1.mp3"),
      );
      assetsAudioPlayer.play();
    }, changedVolume: (volume) async* {
      //_audioPlayer.setVolume(volume);
    }, changedTrack: (changedTrack) async* {
      // int result = await _audioPlayer
      //     .play("assets/sounds/track_$changedTrack.mp3", isLocal: true);
      // if (result == 1) {
      //   print(result);
      // }
    }, reducedOneHeart: () async* {
      // int result = await _audioPlayer.play("assets/sounds/1_heart_left.mp3",
      //     isLocal: true);
      // if (result == 1) {
      //   print(result);
      // }
    }, gainedOneScore: () async* {
      // int result =
      //     await _audioPlayer.play("assets/sounds/1_score.mp3", isLocal: true);
      // if (result == 1) {
      //   print(result);
      // }
    }, changedPath: () async* {
      // int result = await _audioPlayer.play("assets/sounds/change_path.mp3",
      //     isLocal: true);
      // if (result == 1) {
      //   print(result);
      // }
    });
  }

  @override
  Future<void> close() async {
    //await _audioPlayer.dispose();
    return super.close();
  }
}
