import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker _internetConnectionChecker;
  NetworkInfoImpl(this._internetConnectionChecker);
  @override
  Future<bool> get isConnected => _internetConnectionChecker.hasConnection;
  // Future<bool> get isConnected async {
  //   if (await _internetConnectionChecker.hasConnection) {
  //     try {
  //       final result = await InternetAddress.lookup('google.com');
  //       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //         return true;
  //       } else {
  //         return false;
  //       }
  //     } on SocketException catch (_) {
  //       return false;
  //     }
  //   } else {
  //     return false;
  //   }
  // }
}
