part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeBarcodeScannerPressedEvent extends HomeEvent {}

class HomeSharePressedEvent extends HomeEvent {}

class HomeListUnitEditPressedEvent extends HomeEvent {}

class HomeListUnitRemovePressedEvent extends HomeEvent {
  final String scannedString;
  HomeListUnitRemovePressedEvent({required this.scannedString});
}
