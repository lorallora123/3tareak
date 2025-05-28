import 'package:dartz/dartz.dart';
import 'package:take_me_with_you/features/spin/data/models/spin_request.dart';
import 'package:take_me_with_you/imports.dart';

abstract class SpinRepo {
  Future<Either<Failure, BaseMapResponse>> spin(SpinRequest spinRequest);
}
