import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';

class Connection {
  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  StreamSubscription<ConnectivityResult> _subscription;
  StreamController<ConnectivityResult> _networkStatusController;

  StreamSubscription<ConnectivityResult> get subscription => _subscription;
  StreamController<ConnectivityResult> get networkStatusController => _networkStatusController;

  Connection(){
    _networkStatusController = StreamController<ConnectivityResult>();
    _invokeNetworkStatusListen();
  }

  void _invokeNetworkStatusListen() async{
    _networkStatusController.sink.add(await Connectivity().checkConnectivity());
    _subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _networkStatusController.sink.add(result);
    });
  }

  void disposeStreams(){
    _subscription.cancel();
    _networkStatusController.close();
  }
}