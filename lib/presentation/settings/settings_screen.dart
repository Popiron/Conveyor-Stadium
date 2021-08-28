import 'package:auto_route/auto_route.dart';
import 'package:conveyor_stadium/configure_dependencies.dart';
import 'package:conveyor_stadium/domain/interfaces/music_service.dart';
import 'package:conveyor_stadium/presentation/colors.dart';
import 'package:conveyor_stadium/presentation/common/background.dart';
import 'package:conveyor_stadium/presentation/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:conveyor_stadium/presentation/common/widget_list_utils.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _musicService = getIt.get<MusicService>();
  late double _sliderValue;
  @override
  void initState() {
    _sliderValue = _musicService.getVolume();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      backgroundType: BackgroundType.onlyUpArrows,
      child: Stack(alignment: Alignment.center, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _volumeSlider(),
            const SizedBox(
              height: 64,
            ),
            _tracks(),
          ],
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
      ]),
    );
  }

  Widget _volumeSlider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 44,
          child: Image.asset("assets/images/sound_icon.png"),
        ),
        Material(
          color: Colors.transparent,
          child: SliderTheme(
            data: SliderThemeData(
                trackHeight: 10,
                overlayColor: const Color(0xFFFFBB00).withOpacity(0.2),
                inactiveTrackColor: const Color(0xFF707477),
                activeTrackColor: ColorsUtil.highlightedColor,
                thumbColor: const Color(0xFFFFBB00),
                thumbShape:
                    const RoundSliderThumbShape(enabledThumbRadius: 15)),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.36,
              child: Slider(
                value: _sliderValue,
                onChangeStart: (value) {},
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;
                    _musicService.changeVolume(value);
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _tracks() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buttonTrack(
              trackId: 1, isSelected: _musicService.getPlayingTrackId() == 1),
          _buttonTrack(
              trackId: 2, isSelected: _musicService.getPlayingTrackId() == 2),
          _buttonTrack(
              trackId: 3, isSelected: _musicService.getPlayingTrackId() == 3),
        ].separated(
            separator: () => const SizedBox(
                  width: 24,
                )));
  }

  Widget _buttonTrack({required int trackId, required bool isSelected}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _musicService.playTrack(trackId);
        });
      },
      child: Column(
        children: [
          Container(
              height: 60,
              width: 60,
              child: Stack(alignment: Alignment.center, children: [
                Image.asset(isSelected
                    ? "assets/images/selected_track_button.png"
                    : "assets/images/track_button.png"),
                if (isSelected)
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorsUtil.highlightedColor,
                          shape: BoxShape.circle),
                    ),
                  ),
                Text(
                  trackId.toString(),
                  style: TypographyUtil.baseTextStyle.copyWith(
                      color: isSelected
                          ? const Color(0xFF373C40)
                          : ColorsUtil.textColor),
                )
              ])),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Track",
            style: isSelected
                ? TypographyUtil.smallText.highlighted()
                : TypographyUtil.smallText,
          )
        ],
      ),
    );
  }
}
