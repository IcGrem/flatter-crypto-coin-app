import 'package:crypto_coins_list/router/router.dart';
import 'package:crypto_coins_list/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryptoCurrenciesListApp extends StatefulWidget {
  const CryptoCurrenciesListApp({super.key});

  @override
  State<CryptoCurrenciesListApp> createState() =>
      _CryptoCurrenciesListAppState();
}

class _CryptoCurrenciesListAppState extends State<CryptoCurrenciesListApp> {
  // This widget is the root of your application.
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Crypto Currencies List',
      theme: darkTheme,
      routerConfig: _appRouter.config(
        navigatorObservers: () => [TalkerRouteObserver(GetIt.I<Talker>())],
      ),
      // routes: routes,
    );
  }
}
