// import 'package:crypto_coins_list/repositories/crypto_coins/abstract_coins_repository.dart';
import 'dart:async';

import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'crypto_list_event.dart'; // использование файла в этой же папке
part 'crypto_list_state.dart'; // использование файла в этой же папке

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  CryptoListBloc(this.coinsRepository) : super(CryptoListInitial()) {
    on<LoadCryptoList>(_load);
  }

  final AbstractCoinsRepository coinsRepository;
  Future<void> _load(
    LoadCryptoList event,
    Emitter<CryptoListState> emit,
    // callback - регистрация обработчика события (event'а). event - класс события, emit - метод выдачи стэйта на экран (ui)
    // логика загрузки данных
    // debugPrint('Crypto list loadding ...');
  ) async {
    try {
      if (state is! CryptoListLoaded) {
        emit(CryptoListLoading());
      }
      final coinsList = await coinsRepository.getCoinsList();
      emit(CryptoListLoaded(coinsList: coinsList));
    } catch (e, st) {
      emit(CryptoListLoadingFailure(e));
      GetIt.I<Talker>().handle(e, st);
    } finally {
      event.completer?.complete();
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // TODO: implement onError
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
