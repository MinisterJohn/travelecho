import 'package:flutter/widgets.dart';

import 'auth_routes.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> allRoutes = {
    ...AuthRoutes.routes,
  };
}
