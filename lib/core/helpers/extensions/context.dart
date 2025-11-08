import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  Object? get arguments {
    return ModalRoute.of(this)?.settings.arguments;
  }

  /// Navigation.push() shortcut.
  to(Widget view, {Object? arguments, Function? callback}) async {
    Navigator.push<String>(
      this,
      MaterialPageRoute(
          builder: (context) => view,
          settings: RouteSettings(arguments: arguments)),
    ).then((_) {
      callback?.call();
    });
  }

  Future<void> back<T>([T? result]) async {
    Navigator.of(this).pop<T>(result);
  }

  /// Navigation.pushNamed() shortcut.
  toNamed(
    String route, {
    Object? arguments,
    Function(Object?)? callback,
  }) async {
    Navigator.pushNamed(
      this,
      route,
      arguments: arguments,
    ).then((onValue) {
      callback?.call(onValue);
    });
  }

  /// Navigation.pushNamedAndRemoveUntil() shortcut.
  offAllNamed(String route, {Object? arguments, Function? callback}) async {
    Navigator.pushNamedAndRemoveUntil(
      this,
      route,
      (_) => false,
      arguments: arguments,
    ).then((_) {
      callback?.call();
    });
  }

  ///
  pushNamedAndRemoveUntil(String newRoute, String route,
      {Object? arguments}) async {
    Navigator.pushNamedAndRemoveUntil(
      this,
      newRoute,
      ModalRoute.withName(route),
    );
  }

  /// replace current route with new route
  pushReplacement(String route, {Object? arguments}) async {
    Navigator.pushReplacementNamed(
      this,
      route,
      arguments: arguments,
    );
  }

  popUntilNamed(String route, {Object? arguments}) {
    Navigator.popUntil(this, ModalRoute.withName(route));
  }
}

extension SizeExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}

extension ThemeExtension on BuildContext {
  bool get isDarkMode =>
      MediaQuery.of(this).platformBrightness == Brightness.dark;
}
