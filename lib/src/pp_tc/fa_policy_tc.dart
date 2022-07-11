import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FaPrivacyPoliciesAndTC extends StatelessWidget {
  const FaPrivacyPoliciesAndTC({
    this.onResult,
    this.url,
  });

  final Function(bool)? onResult;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: url ?? 'https://www.fieldassist.in/privacy-policy/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: MaterialButton(
                color: Colors.red.shade300,
                child: Text(
                  "Reject",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  onResult?.call(false);
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
                  onResult?.call(true);
                  Navigator.pop(context);
                }),
          ),
        ],
      ),
    );
  }
}
