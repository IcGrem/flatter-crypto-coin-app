// состояния элемнтов ui
part of 'crypto_list_bloc.dart';

abstract class CryptoListState extends Equatable {}

class CryptoListInitial extends CryptoListState {
  @override
  List<Object?> get props => [];
} // extends - наследование

class CryptoListLoading extends CryptoListState {
  @override
  List<Object?> get props => [];
}

class CryptoListLoaded extends CryptoListState {
  // взвращается, когда список крипты готов для отображения, т.е. загрузился
  CryptoListLoaded({required this.coinsList}); // конструктор
  final List<CryptoCoin> coinsList;

  @override
  List<Object?> get props => [coinsList];
}

// класс обработки ошибки загрузки
class CryptoListLoadingFailure extends CryptoListState {
  CryptoListLoadingFailure(this.exception);

  final Object?
      exception; // можно вместо Object использовать Exception, но он подходит не для всех возможных ошибок (например, ошибки Flutter)

  @override
  List<Object?> get props => [exception];
}
