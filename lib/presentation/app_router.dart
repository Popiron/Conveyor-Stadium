import 'package:auto_route/auto_route.dart';

import 'menu/menu_screen.dart';
import 'privacy_policy/privacy_police_screen.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AdaptiveRoute>[
    AdaptiveRoute(
      page: PrivacyPolicyScreen,
    ),
    AdaptiveRoute(
      page: MenuScreen,
      initial: true,
    ),
  ],
)
class $AppRouter {}
