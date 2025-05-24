import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_me_with_you/core/utils/di.dart';
import 'package:take_me_with_you/features/service/data/models/contact_us_request.dart';
import 'package:take_me_with_you/features/service/data/repo/service_repo.dart';
import 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(ContactUsInitial());

  final ServiceRepo _serviceRepo = instance<ServiceRepo>();

  Future<void> contactUs({required String title, required String desc}) async {
    emit(ContactUsLoadingState());
    (await _serviceRepo.contactUs(
            contactUsRequest:
                ContactUsRequest(title: title, description: desc)))
        .fold(
      (l) {
        emit(ContactUsFailState(message: l.message));
      },
      (response) async {
        emit(ContactUsSuccessState(message: response.message.toString()));
      },
    );
  }
}
