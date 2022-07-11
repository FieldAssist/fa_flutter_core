import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FaPrivacyPoliciesAndTC extends StatefulWidget {
  const FaPrivacyPoliciesAndTC({
    this.onResult,
    this.url,
  });

  final Function(bool)? onResult;
  final String? url;

  @override
  State<FaPrivacyPoliciesAndTC> createState() => _FaPrivacyPoliciesAndTCState();
}

class _FaPrivacyPoliciesAndTCState extends State<FaPrivacyPoliciesAndTC> {
  bool _pageLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WebView(
            initialUrl:
                widget.url ?? 'https://www.fieldassist.in/privacy-policy/',
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (_) {
              setState(() {
                _pageLoaded = true;
              });
            },
          ),
          if (!_pageLoaded)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      bottomNavigationBar: !_pageLoaded
          ? null
          : Row(
              children: [
                Expanded(
                  child: MaterialButton(
                      color: Colors.red.shade300,
                      child: Text(
                        "Reject",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        widget.onResult?.call(false);
                        Navigator.pop(context);
                      }),
                ),
                Expanded(
                  child: MaterialButton(
                      color: Colors.blue.shade300,
                      child: Text(
                        "Accept",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        widget.onResult?.call(true);
                        Navigator.pop(context);
                      }),
                ),
              ],
            ),
    );
  }
}
