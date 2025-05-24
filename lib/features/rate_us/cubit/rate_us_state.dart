sealed class RateUsState {}

final class RateUsInitial extends RateUsState {}

class RateUsLoadingState extends RateUsState {}

class RateUsSuccessState extends RateUsState {
  final String message;

  RateUsSuccessState({required this.message});
}

class RateUsFailState extends RateUsState {
  final String message;

  RateUsFailState({required this.message});
}
