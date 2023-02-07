import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FaPrivacyPoliciesAndTC extends StatefulWidget {
  const FaPrivacyPoliciesAndTC({
    this.onResult,
    this.url,
    this.showAcceptAndReject = true,
  });

  final Function(bool)? onResult;
  final String? url;
  final bool showAcceptAndReject;

  @override
  State<FaPrivacyPoliciesAndTC> createState() => _FaPrivacyPoliciesAndTCState();
}

class _FaPrivacyPoliciesAndTCState extends State<FaPrivacyPoliciesAndTC> {
  bool _pageLoaded = false;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (_) {
          setState(() {
            _pageLoaded = true;
          });
        },
      ))
      ..loadRequest(
        Uri.parse(widget.url ?? 'https://www.fieldassist.in/privacy-policy/'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WebViewWidget(
            controller: _controller,
          ),
          if (!_pageLoaded)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      bottomNavigationBar: !(_pageLoaded && widget.showAcceptAndReject)
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
