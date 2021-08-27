import 'package:auto_route/auto_route.dart';
import 'package:conveyor_stadium/domain/constants.dart';
import 'package:conveyor_stadium/presentation/app_router.gr.dart';
import 'package:conveyor_stadium/presentation/colors.dart';
import 'package:conveyor_stadium/presentation/common/background.dart';
import 'package:conveyor_stadium/presentation/typography.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          WebView(
            initialUrl: PRIVACY_POLICY_URL,
            onWebViewCreated: (controller) {
              _webViewController = controller;
            },
          ),
          Positioned(
            left: 25,
            bottom: 20,
            child: GestureDetector(
              onTap: () {
                AutoRouter.of(context).popUntilRoot();
              },
              child: Container(
                height: 40,
                child: Image.asset('assets/images/web_button_back.png'),
              ),
            ),
          ),
          Positioned(
            left: 75,
            bottom: 20,
            child: GestureDetector(
              onTap: () async {
                await _webViewController.reload();
              },
              child: Container(
                height: 40,
                child: Image.asset('assets/images/web_button_update.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
