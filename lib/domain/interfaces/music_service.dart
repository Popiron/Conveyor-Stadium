import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:conveyor_stadium/data/services/music_service_impl.dart';
import 'package:injectable/injectable.dart';

@preResolve
@Singleton()
abstract class MusicService {
  Future<void> playTrack(int id);
  Future<void> changeVolume(double volume);
  Future<void> reducedOneHeartSound();
  Future<void> gainedOneScoreSound();
  Future<void> changedPathSound();
  int getPlayingTrackId();
  double getVolume();

  @factoryMethod
  static Future<MusicService> music() async {
    final musicPlayer = AssetsAudioPlayer();
    final soundsPlayer = AssetsAudioPlayer();
    return MusicServiceImpl(musicPlayer, soundsPlayer)..playTrack(1);
  }
}
