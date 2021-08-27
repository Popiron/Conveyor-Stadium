part of 'music_bloc.dart';

@freezed
class MusicEvent with _$MusicEvent {
  const factory MusicEvent.started() = _Started;
  const factory MusicEvent.changedVolume(double volume) = _ChangedVolume;
  const factory MusicEvent.changedTrack(int trackId) = _ChangedTrack;
  const factory MusicEvent.reducedOneHeart() = _ReducedOneHeart;
  const factory MusicEvent.gainedOneScore() = _GainedOneScore;
  const factory MusicEvent.changedPath() = _ChangedPath;
}
