import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_me_with_you/core/utils/di.dart';
import 'package:take_me_with_you/features/service/data/models/rate_us_request.dart';
import 'package:take_me_with_you/features/service/data/repo/service_repo.dart';

import 'rate_us_state.dart';

class RateUsCubit extends Cubit<RateUsState> {
  RateUsCubit() : super(RateUsInitial());
  final ServiceRepo _serviceRepo = instance<ServiceRepo>();

  Future<void> rateUs({
    required double rate,
  }) async {
    emit(RateUsLoadingState());
    (await _serviceRepo
            .rateUs(rateUsRequests: [RateUsRequest(rate: rate, type: 'app')]))
        .fold(
      (l) {
        emit(RateUsFailState(message: l.message));
      },
      (response) async {
        emit(RateUsSuccessState(message: response.message.toString()));
      },
    );
  }
}
