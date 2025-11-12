import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  const BaseState();
}

class InitialState extends BaseState {
  @override
  List<Object> get props => [];
}

class LoadingState extends BaseState {
  @override
  List<Object> get props => [];
}

class LoadedState<T> extends BaseState {
  final T data;

  const LoadedState(this.data);

  @override
  List<Object> get props => [data as Object];
}

class ErrorState extends BaseState {
  final String message;

  const ErrorState(this.message);

  @override
  List<Object> get props => [message];
}
