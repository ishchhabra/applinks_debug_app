import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';

final _appLinks = AppLinks();

typedef OnAppLinkCallback = Function(Uri uri);

bool _initialUriHandled = false;

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
    _handleInitialUri();
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

  Future<void> _handleInitialUri() async {
    if (_initialUriHandled) {
      return;
    }

    if (!mounted) {
      return;
    }

    _initialUriHandled = true;
    final uri = await _appLinks.getInitialAppLink();
    if (uri != null) {
      widget.onAppLink(uri);
    }
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
