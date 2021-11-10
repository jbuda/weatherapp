import 'package:connectivity/connectivity.dart';

abstract class Network {
  Future<bool> isConnected();
}

class NetworkImpl implements Network {
  final Connectivity connectivity;

  NetworkImpl(this.connectivity);

  @override
  Future<bool> isConnected() async {
    return await connectivity.checkConnectivity() != ConnectivityResult.none;
  }
}