import 'package:auto_route/auto_route.dart';
import 'package:conveyor_stadium/configure_dependencies.dart';
import 'package:conveyor_stadium/domain/blocs/music/music_bloc.dart';
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
  final _bloc = getIt.get<MusicBloc>();
  @override
  void initState() {
    _bloc.add(const MusicEvent.started());
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
            child: Slider(
              value: 30,
              max: 100.0,
              onChangeStart: (value) {},
              onChanged: (value) {},
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
          _buttonTrak(trackId: 1, isSelected: true),
          _buttonTrak(trackId: 2, isSelected: false),
          _buttonTrak(trackId: 3, isSelected: false),
        ].separated(
            separator: () => const SizedBox(
                  width: 24,
                )));
  }

  Widget _buttonTrak({required int trackId, required bool isSelected}) {
    return GestureDetector(
      onTap: () {},
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
