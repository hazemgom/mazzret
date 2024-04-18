import 'package:connectivity/connectivity.dart';

class ConnectivityChecker {
  Stream<ConnectivityResult> connectivityStream =
      Connectivity().onConnectivityChanged;

  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }
}