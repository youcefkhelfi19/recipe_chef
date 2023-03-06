import 'package:flutter/material.dart';

import 'utils/app_routes.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const RecipeChef());
}

class RecipeChef extends StatelessWidget {
  const RecipeChef({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: generateRoutes,
      initialRoute: '/',
      theme: englishTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}

