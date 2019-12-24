import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatefulWidget {
  final String url;

  WebView(this.url);

  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebView> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(),
      url: widget.url,
    );
  }
}
