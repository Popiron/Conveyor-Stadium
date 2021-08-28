import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:conveyor_stadium/domain/interfaces/music_service.dart';

class MusicServiceImpl implements MusicService {
  final AssetsAudioPlayer _musicPlayer;
  final AssetsAudioPlayer _soundsPlayer;

  MusicServiceImpl(this._musicPlayer, this._soundsPlayer);

  late int _playingTrackId;

  @override
  Future<void> changeVolume(double volume) async {
    await _musicPlayer.setVolume(volume);
    await _soundsPlayer.setVolume(volume);
  }

  @override
  Future<void> changedPathSound() async {
    await _soundsPlayer.open(Audio("assets/sounds/change_path.mp3"));
    _soundsPlayer.play();
  }

  @override
  Future<void> gainedOneScoreSound() async {
    await _soundsPlayer.open(Audio("assets/sounds/1_score.mp3"));
    _soundsPlayer.play();
  }

  @override
  Future<void> playTrack(int id) async {
    _playingTrackId = id;
    await _musicPlayer.open(Audio("assets/sounds/track_$id.mp3"));
    _musicPlayer.setLoopMode(LoopMode.single);
    _musicPlayer.play();
  }

  @override
  Future<void> reducedOneHeartSound() async {
    await _soundsPlayer.open(Audio("assets/sounds/1_heart_left.mp3"));
    _soundsPlayer.play();
  }

  @override
  int getPlayingTrackId() {
    return _playingTrackId;
  }

  @override
  double getVolume() {
    return _musicPlayer.volume.value;
  }
}
