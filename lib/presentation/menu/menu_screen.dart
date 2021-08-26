import 'package:auto_route/auto_route.dart';
import 'package:conveyor_stadium/presentation/app_router.gr.dart';
import 'package:conveyor_stadium/presentation/common/background.dart';
import 'package:conveyor_stadium/presentation/gameplay/gameplay_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:conveyor_stadium/presentation/common/widget_list_utils.dart';

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
                  child: Image.asset("assets/images/button_results.png"),
                ),
              ),
              GestureDetector(
                onTap: () {
                  AutoRouter.of(context).push(GamePlayRoute());
                },
                child: Container(
                  height: 58,
                  child: Image.asset("assets/images/button_play.png"),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 58,
                  child: Image.asset("assets/images/button_settings.png"),
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
              child: Image.asset("assets/images/button_privacy_policy.png"),
            ),
          ),
        ],
      ),
    );
  }
}
