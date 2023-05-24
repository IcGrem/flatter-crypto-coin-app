import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:crypto_coins_list/router/router.dart';
import 'package:flutter/material.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({
    super.key,
    required this.coin,
  });

  final CryptoCoin coin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // const String assetName = 'assets/svg/bitcoin_logo.svg';
    final coinDetail = coin.details;
    return ListTile(
      leading: Image.network(coinDetail.fullImageUrl),
      // trailing: ,
      title: Text(coin.name, style: theme.textTheme.bodyMedium),
      subtitle: Text(
        '${coinDetail.priceInUSD} \$',
        style: theme.textTheme.labelSmall,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        AutoRouter.of(context).push(CryptoCoinRoute(coin: coin));
        // Navigator.of(context).pushNamed('/coin', arguments: coin);
      },
    );
  }
}
