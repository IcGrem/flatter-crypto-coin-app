import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
// import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin_details.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';
// import 'package:flutter/material.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  CryptoCoinsRepository({
    required this.dio,
    required this.cryptoCoinsBox,
  });

  final Dio dio;
  final Box<CryptoCoin> cryptoCoinsBox;

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    var cryptoCoinsList = <CryptoCoin>[];
    try {
      cryptoCoinsList = await _fetchCoinsListFromAPI();
      final cryptoCionsMap = {for (var e in cryptoCoinsList) e.name: e};
      cryptoCoinsBox.putAll(cryptoCionsMap);
    } catch (e, st) {
      GetIt.instance<Talker>().handle(e, st);
      return cryptoCoinsBox.values.toList();
    }
    cryptoCoinsList
        .sort((a, b) => b.details.priceInUSD.compareTo(a.details.priceInUSD));
    return cryptoCoinsList;
  }

  Future<List<CryptoCoin>> _fetchCoinsListFromAPI() async {
    final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,SOL,AID,CAG,DOV&tsyms=USD');
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries.map((e) {
      final usdData =
          (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
      final details = CryptoCoinDetail.fromJson(usdData);

      // final price = usdData['PRICE'];
      // final imageUrl = usdData['IMAGEURL'];
      return CryptoCoin(
        name: e.key,
        details: details,
      );
      // priceInUSD: price.toString(),
      // imageUrl: 'https://cryptocompare.com/$imageUrl');
    }).toList();
    // debugPrint(cryptoCoinsList.toString());

    return cryptoCoinsList;
  }

  @override
  Future<CryptoCoin> getCoinDetails(String currencyCode) async {
    try {
      final coin = await _fetchCoinDetailsFromAPI(currencyCode);
      cryptoCoinsBox.put(currencyCode, coin);
      return coin;
    } on Exception catch (e, st) {
      GetIt.instance<Talker>().handle(e, st);
      return cryptoCoinsBox.get(currencyCode)!;
    }

    // priceInUSD: price.toString(),
    // imageUrl: 'https://cryptocompare.com/$imageUrl',
    // toSymbol: toSymbol,
    // lastUpdate: DateTime.fromMillisecondsSinceEpoch(lastUpdate),
    // high24Hour: high24Hour,
    // low24Hour: low24Hour,
    // );
  }

  Future<CryptoCoin> _fetchCoinDetailsFromAPI(String currencyCode) async {
    final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currencyCode&tsyms=USD');
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinData = dataRaw[currencyCode] as Map<String, dynamic>;
    final usdData = coinData['USD'] as Map<String, dynamic>;
    final details = CryptoCoinDetail.fromJson(usdData);
    return CryptoCoin(name: currencyCode, details: details);
  }
}
