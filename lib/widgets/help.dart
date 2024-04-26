import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NeedHelpButton extends StatefulWidget {
  const NeedHelpButton({Key? key}) : super(key: key);

  @override
  State<NeedHelpButton> createState() => _NeedHelpButtonState();
}

class _NeedHelpButtonState extends State<NeedHelpButton> {
  Future<void>? _launched;

  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Uri toLaunch = Uri(scheme: 'https', host: 'help.netflix.com');

    return FlatButton(
      onPressed: () => setState(() {
        _launched = _launchInWebViewOrVC(toLaunch);
      }),
      child: const Text(
        'Need help?',
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
      ),
    );
  }
}
