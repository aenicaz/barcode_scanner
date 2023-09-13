import 'dart:async';

import 'package:barcode_scanner/data/models/scanned_data.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:meta/meta.dart';
import 'package:share/share.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeBarcodeScannerPressedEvent>(homeBarcodeScannerPressedEvent);
    on<HomeSharePressedEvent>(homeShareFilePressedEvent);
    on<HomeListUnitEditPressedEvent>(homeListUnitEditPressedEvent);
    on<HomeListUnitRemovePressedEvent>(homeListUnitRemovePressedEvent);
  }

  FutureOr<void> homeBarcodeScannerPressedEvent(
      HomeBarcodeScannerPressedEvent event, Emitter<HomeState> emit) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    ScannedData.data.add(barcodeScanRes);
    emit(HomeLoadSuccessState(data: ScannedData.data));
  }

  FutureOr<void> homeShareFilePressedEvent(
      HomeSharePressedEvent event, Emitter<HomeState> emit) async {
    if (ScannedData.data.isEmpty) {
      emit(HomeShareErrorState());
    } else {
      await Share.share(ScannedData.data.join('\n'));
    }
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadSuccessState(data: ScannedData.data));
  }

  FutureOr<void> homeListUnitEditPressedEvent(
      HomeListUnitEditPressedEvent event, Emitter<HomeState> emit) {}

  FutureOr<void> homeListUnitRemovePressedEvent(
      HomeListUnitRemovePressedEvent event, Emitter<HomeState> emit) {
    ScannedData.data.remove(event.scannedString);
    emit(HomeLoadSuccessState(data: ScannedData.data));
  }
}
