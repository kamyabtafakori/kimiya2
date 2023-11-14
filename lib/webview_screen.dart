
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  InAppWebViewController? webViewController;
  PullToRefreshController? refreshController;
  late var url;
  double progress = 0;
  var urlController = TextEditingController();
  var initialUrl = "https://anzalikimiya.com/";
  var isLoading = false;

  Future<bool> _goBack(BuildContext context) async {
    if (await webViewController!.canGoBack()) {
      webViewController!.goBack();
      return Future.value(false);
    } else {
      SystemNavigator.pop();
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => _goBack(context),
        child: Column(
          children: [
            Expanded(
                child: Stack(
                  alignment: Alignment.center,
              children: [
                InAppWebView(
                  onLoadStart: (controller, url){
                    setState(() {
                      isLoading = true;
                    });
                  },
                  onLoadStop: (controller, url) {
                    setState(() {
                      isLoading = false;
                    });
                  },
                  onWebViewCreated: (controller) =>
                      webViewController = controller,
                  initialUrlRequest: URLRequest(url: Uri.parse(initialUrl)),
                ),
                Visibility(
                    visible:isLoading,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.black87),
                    )),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
