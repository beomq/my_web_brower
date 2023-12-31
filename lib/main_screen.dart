import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('나만의 웹브라우저'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
          PopupMenuButton<String>(
              onSelected: (value) {
                _webViewController.loadUrl(value);
              },
              itemBuilder: (context) => [
                    const PopupMenuItem<String>(
                      value: 'https://www.google.com',
                      child: Text('google'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'https://www.naver.com',
                      child: Text('naver'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'https://www.kakao.com',
                      child: Text('kakao'),
                    ),
                  ]),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (await _webViewController.canGoBack()) {
            await _webViewController.goBack();
            return false;
          }
          return true;
        },
        child: WebView(
          initialUrl: 'https://flutter.dev',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            _webViewController = controller;
          },
        ),
      ),
    );
  }
}
