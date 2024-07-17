import 'package:coffee_shop/model/coffee_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/intro_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CoffeeItem(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IntroScreen(),
      ),
    );
  }
}
