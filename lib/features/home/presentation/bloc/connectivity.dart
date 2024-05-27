import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ConnectivityEvent { checkConnectivity }

class ConnectivityState {
  final bool isConnected;

  ConnectivityState(this.isConnected);
}

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  late final StreamSubscription<List<ConnectivityResult>>
      _connectivitySubscription;

  ConnectivityBloc() : super(ConnectivityState(false)) {
    on<ConnectivityEvent>((event, emit) async {
      var connectivityResult = await Connectivity().checkConnectivity();
      bool isConnected = connectivityResult.first != ConnectivityResult.none;
      return emit(ConnectivityState(isConnected));
    });

    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((result) {
      add(ConnectivityEvent.checkConnectivity);
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
