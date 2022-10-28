import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:provider101/dependency_injection.dart';
import 'package:provider101/homepage.dart';
import 'package:provider101/samples/counter/counter_app.dart';
import 'package:provider101/samples/counter/counter_provider.dart';
import 'package:provider101/samples/weather/presentation/controllers/weather_provider.dart';
import 'package:provider101/samples/weather/presentation/ui/weather_app.dart';

void main() async {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => locator<CounterProvider>()),
          ChangeNotifierProvider(create: (_) => locator<WeatherProvider>()),
        ],
        child: MaterialApp.router(
          routeInformationParser: goRouter.routeInformationParser,
          routerDelegate: goRouter.routerDelegate,
          routeInformationProvider: goRouter.routeInformationProvider,
        ));
  }
}

//
//
/// ***
/// Routing
/// ***
//
//

enum AppPaths { home, counter, weather, error404 }

final Map<AppPaths, String> allRoutes = {
  AppPaths.home: 'home',
  AppPaths.counter: 'counter',
  AppPaths.weather: 'weather',
  AppPaths.error404: 'error404'
};

final goRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/${allRoutes[AppPaths.home]}',
  errorBuilder: (context, state) => const ErrorPage(),
  routes: [
    GoRoute(
        name: allRoutes[AppPaths.home],
        path: '/${allRoutes[AppPaths.home]}',
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            name: allRoutes[AppPaths.weather],
            path: '${allRoutes[AppPaths.weather]}',
            builder: (context, state) => WeatherApp(),
          ),
          GoRoute(
            name: allRoutes[AppPaths.counter],
            path: '${allRoutes[AppPaths.counter]}',
            builder: (context, state) => const CounterApp(),
          ),
        ]),
    GoRoute(
      name: allRoutes[AppPaths.error404],
      path: '/${allRoutes[AppPaths.error404]}',
      builder: (context, state) => const ErrorPage(),
    ),
  ],

  /// official docs of go_router also describes a redirect parameter
  // https://gorouter.dev/redirection
  // to use provider and redirect user based on authState and its actually good
  // but we are using shared_prefs and its working well
  // so no need to create an extra provider and increase complexity
  // we just need to take care of the fact that we need to
  // empty shared_prefs on userLogout and use context.push(/login)
  // and that will do the job just fine
);

/// I keep forgetting that
/// go -> removes entire stack and push a new page
/// push -> stacks new page above current page (use pushNamed for named routes)
/// replace -> replace current page with new page on current stack

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error 404"),
      ),
      body: Center(
          child: TextButton(
        onPressed: () {
          context.pushNamed(allRoutes[AppPaths.home]!);
        },
        child: const Text("Lmao go to home? "),
      )),
    );
  }
}
