import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';

final _appLinks = AppLinks();

typedef OnAppLinkCallback = Function(Uri uri);

class AppLinkHandler extends StatefulWidget {
  final Widget child;
  final OnAppLinkCallback onAppLink;

  const AppLinkHandler({
    super.key,
    required this.child,
    required this.onAppLink,
  });

  @override
  State<AppLinkHandler> createState() => _AppLinkHandlerState();
}

class _AppLinkHandlerState extends State<AppLinkHandler> {
  late final StreamSubscription _uriLinkStreamSubscription;

  @override
  void initState() {
    super.initState();
    _registerIncomingLinks();
  }

  @override
  void dispose() {
    _uriLinkStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _registerIncomingLinks() {
    _uriLinkStreamSubscription = _appLinks.uriLinkStream.listen((uri) {
      if (!mounted) {
        return;
      }

      widget.onAppLink(uri);
    });
  }
}
