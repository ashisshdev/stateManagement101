import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider101/main.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Provider Examples"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                context.pushNamed(allRoutes[AppPaths.counter]!);
              },
              child: const Text("Counter Example")),
          TextButton(
              onPressed: () {
                context.pushNamed(allRoutes[AppPaths.weather]!);
              },
              child: const Text("Weather Example")),
          TextButton(
              onPressed: () {
                context.pushNamed(allRoutes[AppPaths.znews]!);
              },
              child: const Text("News Example")),
        ],
      ),
    );
  }
}
