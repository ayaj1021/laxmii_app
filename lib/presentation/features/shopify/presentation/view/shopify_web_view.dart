import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/presentation/features/dashboard/dashboard.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/presentation/widgets/import_shopify_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class ShopifyWebView extends StatefulWidget {
  const ShopifyWebView({super.key, required this.shopifyUrl});
  final String shopifyUrl;

  @override
  State<ShopifyWebView> createState() => _ShopifyWebViewState();
}

class _ShopifyWebViewState extends State<ShopifyWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // Platform initialization
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    // For Android
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            } else if (request.url.contains(
                'https://laxmii-latest.onrender.com/auth/shopify/callback?')) {
              //  'https://laxmii.onrender.com/auth/shopify/callback?')) {
              // context.pushReplacementNamed(Dashboard.routeName);

              showDialog(
                context: context,
                builder: (_) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ImportShopifyDialog(),
                ),
              ).then((_) {
                if (mounted) {
                  // context.pushReplacementNamed(Dashboard.routeName);
                  context.pushReplacementNamed(Dashboard.routeName);
                }
                // setState(() {
                //   _dislikedMessageIds.add(message.id ?? '');
                // });
              });
            } else {
              debugPrint('allowing navigation to ${request.url}');
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      //https://laxmii.onrender.com/auth/shopify/callback?
      ..loadRequest(Uri.parse(widget.shopifyUrl));

    _controller = controller;
    log(widget.shopifyUrl);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Scaffold(
      //  backgroundColor: colorScheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: colorScheme.appBarTheme.backgroundColor,
        foregroundColor: colorScheme.appBarTheme.foregroundColor,
        //  title: const Text('Flutter WebView'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () async {
              if (await _controller.canGoBack()) {
                await _controller.goBack();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () async {
              if (await _controller.canGoForward()) {
                await _controller.goForward();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _controller.reload();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: WebViewWidget(
            controller: _controller,
          ),
        ),
      ),
    );
  }
}
