import 'package:auto_route/auto_route.dart';
import 'package:conveyor_stadium/presentation/app_router.gr.dart';
import 'package:conveyor_stadium/presentation/common/background.dart';
import 'package:conveyor_stadium/presentation/gameplay/gameplay_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:conveyor_stadium/presentation/common/widget_list_utils.dart';
import 'package:easy_localization/easy_localization.dart';

import '../typography.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      backgroundType: BackgroundType.basic,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 58,
                  child: Image.asset('button_results_path'.tr()),
                ),
              ),
              GestureDetector(
                onTap: () {
                  AutoRouter.of(context).push(GamePlayRoute());
                },
                child: Container(
                  height: 58,
                  child: Image.asset('button_play_path'.tr()),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 58,
                  child: Image.asset('button_settings_path'.tr()),
                ),
              ),
            ].separated(
                separator: () => const SizedBox(
                      height: 24.22,
                    )),
          ),
          const SizedBox(
            height: 60.92,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 58,
              child: Image.asset('button_privacy_policy_path'.tr()),
            ),
          ),
        ],
      ),
    );
  }
}
