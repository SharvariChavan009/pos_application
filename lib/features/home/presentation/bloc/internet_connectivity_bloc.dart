import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'internet_connectivity_event.dart';
import 'internet_connectivity_state.dart';

class InternetConnectivityBloc extends Bloc<InternetConnectivityEvent,InternetConnectivityState> {

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription? _connectivitySubscription;

  InternetConnectivityBloc() : super(InternetConnectivityInitialState()) {
    on<InternetConnectivityChange>((event, emit) {
      _connectivitySubscription =
          _connectivity.onConnectivityChanged.listen((event) {
            if (event == ConnectivityResult.wifi ||
                event == ConnectivityResult.mobile) {
              add(InternetConnectivityGainedEvent());
            } else {
              add(InternetConnectivityLostEvent());
            }
          });
      var res = _connectivity.checkConnectivity();
      on<InternetConnectivityGainedEvent>((event, emit) =>
          emit(InternetConnectivityGainedState()));
      on<InternetConnectivityLostEvent>((event, emit) =>
          emit(InternetConnectivityLostState()));


    });
  }
  @override
  Future<void> close(){
    _connectivitySubscription?.cancel();

    return super.close();
  }

}

