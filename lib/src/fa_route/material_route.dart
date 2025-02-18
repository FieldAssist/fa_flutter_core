import 'package:flutter/material.dart';

class AppMaterialPageRoute<T> extends MaterialPageRoute<T> {
  AppMaterialPageRoute({
    required WidgetBuilder appBuilder,
    RouteSettings? routeSettings,
  }) : super(
          builder: appBuilder,
          settings: routeSettings ??
              RouteSettings(name: appBuilder.runtimeType.toString()),
        );
}
