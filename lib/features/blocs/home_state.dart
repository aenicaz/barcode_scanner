part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeErrorState extends HomeState {}

class HomeLoadSuccessState extends HomeState {
  final List<String> data;
  HomeLoadSuccessState({required this.data});
}

class HomeShareErrorState extends HomeActionState {}
