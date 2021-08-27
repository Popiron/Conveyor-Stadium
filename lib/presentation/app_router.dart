import 'package:auto_route/auto_route.dart';
import 'package:conveyor_stadium/presentation/gameplay/gameplay_screen.dart';

import 'menu/menu_screen.dart';
import 'privacy_policy/privacy_police_screen.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AdaptiveRoute>[
    AdaptiveRoute(
      page: MenuScreen,
      initial: true,
    ),
    AdaptiveRoute(
      page: PrivacyPolicyScreen,
    ),
    AdaptiveRoute(
      page: GamePlayScreen,
    ),
  ],
)
class $AppRouter {}
