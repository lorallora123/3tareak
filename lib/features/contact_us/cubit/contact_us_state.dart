abstract class ContactUsState {}

class ContactUsInitial extends ContactUsState {}

class ContactUsLoadingState extends ContactUsState {}

class ContactUsSuccessState extends ContactUsState {
  final String message;

  ContactUsSuccessState({required this.message});
}

class ContactUsFailState extends ContactUsState {
  final String message;

  ContactUsFailState({required this.message});
}
