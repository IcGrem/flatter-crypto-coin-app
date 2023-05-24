import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:crypto_coins_list/features/crypto_list/widgets/widgets.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

@RoutePage()
class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  // final String title;

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final _cryptoListBloc = CryptoListBloc(
    GetIt.I<AbstractCoinsRepository>(),
  ); // создаём экземпляр класса СryptoListBloc

  @override
  void initState() {
    _cryptoListBloc.add(
        LoadCryptoList()); // передаём через add событие загрузки данных о крипте в инстанс
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('CryptoCurrenciesList'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TalkerScreen(
                    talker: GetIt.I<Talker>(),
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.document_scanner_outlined,
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer =
              Completer(); // применяется для отслеживания завершения работы асинхронных вызовов
          _cryptoListBloc.add(LoadCryptoList(
              completer:
                  completer)); // передаём через add событие загрузки данных о крипте в инстанс
          return completer.future;
        },
        child: BlocBuilder<CryptoListBloc, CryptoListState>(
          bloc: _cryptoListBloc,
          builder: (context, state) {
            // дефолтная флаттеровская штука, что бы что-то строить
            if (state is CryptoListLoaded) {
              return ListView.separated(
                padding: const EdgeInsets.only(top: 16),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.coinsList.length,
                itemBuilder: (context, i) {
                  final coin = state.coinsList[i];
                  return CryptoCoinTile(coin: coin);
                },
              );
            }
            if (state is CryptoListLoadingFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Something went wrong',
                      style: theme.textTheme.headlineMedium,
                    ),
                    Text(
                      'Please try againg later',
                      style: theme.textTheme.labelSmall?.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                    TextButton(
                      onPressed: () {
                        _cryptoListBloc.add(LoadCryptoList());
                      },
                      child: const Text('Try againg'),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),

      // (_cryptoCoinsList == null)
      //     ? const Center(child: CircularProgressIndicator())
      //     : ListView.separated(
      //         padding: const EdgeInsets.only(top: 16),
      //         separatorBuilder: (context, index) => const Divider(),
      //         itemCount: _cryptoCoinsList!.length, // ! - список точно не пуст
      //         itemBuilder: (context, i) {
      //           final coin = _cryptoCoinsList![i];
      //           return CryptoCoinTile(coin: coin);
      //         },
      //       ),
    );
  }
}
