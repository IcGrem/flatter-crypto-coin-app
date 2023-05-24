part of 'crypto_list_bloc.dart'; // использование файла в этой же папке

abstract class CryptoListEvent extends Equatable {}

class LoadCryptoList extends CryptoListEvent {
  LoadCryptoList({this.completer});

  final Completer? completer; // ? - значит может быть nullable

  @override
  List<Object?> get props => [completer];
}
