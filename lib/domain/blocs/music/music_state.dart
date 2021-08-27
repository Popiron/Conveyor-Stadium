part of 'music_bloc.dart';

@freezed
class MusicState with _$MusicState {
  const factory MusicState.initial() = _Initial;
  const factory MusicState.playingTrack(int trackId) = _PlayingTrack;
  const factory MusicState.changingVolumeLevel(double level) =
      _ChangingVolumeLevel;
}
