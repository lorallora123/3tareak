import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:take_me_with_you/core/services/socket_service.dart';
import 'package:take_me_with_you/features/profile/data/repo/update_profile_repo.dart';
import 'package:take_me_with_you/features/profile/data/repo/update_profile_repo_impl.dart';
import 'package:take_me_with_you/features/spin/data/repo/spin_repo.dart';
import 'package:take_me_with_you/features/spin/data/repo/spin_repo_impl.dart';
import 'package:take_me_with_you/features/trip_details/data/repo/trip_details_repo.dart';
import 'package:take_me_with_you/features/trip_details/data/repo/trip_details_repo_impl.dart';
import 'package:take_me_with_you/imports.dart';

import '../../features/my_coupon/data/repo/my_coupon_rep.dart';
import '../../features/my_coupon/data/repo/my_coupon_rep_impl.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final dio = Dio();
  dio.interceptors.add(
      PrettyDioLogger(requestBody: true, error: true, requestHeader: true));
  instance.registerSingleton<Dio>(dio);
  instance.registerSingleton<SocketService>(SocketService());
  final sharedPrefs = await SharedPreferences.getInstance();
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(sharedPrefs));
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker.createInstance()));
  instance.registerSingleton<DataService>(DataService(instance()));
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  instance.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(instance()));
  instance
      .registerLazySingleton<ServiceRepo>(() => ServiceRepoImpl(instance()));
  instance
      .registerLazySingleton<LiveTripRepo>(() => LiveTripRepoImpl(instance()));
  instance.registerLazySingleton<CancleOrderRepo>(
      () => CancleOrderRepoImpl(instance()));
  instance.registerLazySingleton<MyOldTripsRepo>(
      () => MyOldTripsRepoImpl(instance()));
  instance.registerLazySingleton<MyOnGoingTripsRepo>(
      () => MyOnGoingTripsRepoImpl(instance()));
  instance.registerLazySingleton<CustomerOldOrdersRepo>(
      () => CustomerOldOrdersRepoImpl(instance()));
  instance.registerLazySingleton<OnGoingTripRepo>(
      () => OnGoingTripRepoImpl(instance()));
  instance.registerLazySingleton<VehicleSelectionRepo>(
      () => VehicleSelectionRepoImpl(instance()));
  instance.registerLazySingleton<AddVehicleRepo>(
      () => AddVehicleRepoImpl(instance()));
  instance.registerLazySingleton<MapRepo>(() => MapRepoImpl(instance()));
  instance.registerLazySingleton<CreateTripRepo>(
      () => CreateTripRepoImpl(instance()));
  instance.registerLazySingleton<AvailableTripsRepo>(
      () => AvailableTripsRepoImpl(instance()));

  instance.registerLazySingleton<TripDetailsRepo>(
      () => TripDetailsRepoImpl(instance()));

  instance.registerLazySingleton<SpinRepo>(() => SpinRepoImpl(instance()));

  instance.registerLazySingleton<RateUsCubit>(() => RateUsCubit());
  instance.registerLazySingleton<ContactUsCubit>(() => ContactUsCubit());
  instance
      .registerLazySingleton<MyCouponRep>(() => MyCouponRepImpl(instance()));
  instance.registerLazySingleton<UpdateProfileRepo>(
      () => UpdateProfileRepoImpl(instance()));

//   instance.registerLazySingleton<OrderRepository>(
//       () => OrderRepositoryImpl(instance(), instance(), instance()));

//   instance.registerLazySingleton<TripRepository>(
//       () => TripRepositoryImpl(instance(), instance(), instance()));

//   instance.registerLazySingleton<RateRepository>(
//       () => RateRepositoryImpl(instance(), instance(), instance()));

//   instance.registerLazySingleton<SpinRepository>(
//       () => SpinRepositoryImpl(instance(), instance(), instance()));
//   instance.registerLazySingleton<ContactUsRepository>(
//       () => ContactUsRepositoryImpl(instance(), instance(), instance()));

//   /// REPOSITORY CLASSES

//   /// USE CASE CLASSES
//   instance.registerLazySingleton<RegisterUserUseCase>(
//       () => RegisterUserUseCase(instance()));

//   instance.registerLazySingleton<LoginUserUseCase>(
//       () => LoginUserUseCase(instance()));

// // <<<<<<< HEAD
//   instance.registerLazySingleton<LogoutUserUseCase>(
//       () => LogoutUserUseCase(instance()));

// // =======
// // >>>>>>> origin/yazan
//   instance.registerLazySingleton<GetProfileUseCase>(
//       () => GetProfileUseCase(instance()));

//   instance.registerLazySingleton<GetVehicleTypesUseCase>(
//       () => GetVehicleTypesUseCase(instance()));

//   instance.registerLazySingleton<GetCaptainVehiclesUseCase>(
//       () => GetCaptainVehiclesUseCase(instance()));

//   instance.registerLazySingleton<AddVehicleUseCase>(
//       () => AddVehicleUseCase(instance()));

//   instance.registerLazySingleton<JoinOrderUseCase>(
//       () => JoinOrderUseCase(instance()));

//   instance.registerLazySingleton<CreateOrderUseCase>(
//       () => CreateOrderUseCase(instance()));

//   instance.registerLazySingleton<GetCaptainOnGoingTripUseCase>(
//       () => GetCaptainOnGoingTripUseCase(instance()));

//   instance.registerLazySingleton<CancelOrderUseCase>(
//       () => CancelOrderUseCase(instance()));

//   instance.registerLazySingleton<GetCaptainPreviousTripUseCase>(
//       () => GetCaptainPreviousTripUseCase(instance()));

//   instance.registerLazySingleton<CaptainStartTripUseCase>(
//       () => CaptainStartTripUseCase(instance()));

//   instance.registerLazySingleton<CustomerInOrderUseCase>(
//       () => CustomerInOrderUseCase(instance()));

//   instance.registerLazySingleton<CustomerOutOrderUseCase>(
//       () => CustomerOutOrderUseCase(instance()));

//   instance.registerLazySingleton<CaptainFinishOrderUseCase>(
//       () => CaptainFinishOrderUseCase(instance()));
//   instance.registerLazySingleton<CustomerOldOrderUseCase>(
//       () => CustomerOldOrderUseCase(instance()));

//   instance.registerLazySingleton<AvailableOrderUseCase>(
//       () => AvailableOrderUseCase(instance()));

//   instance.registerLazySingleton<CreatePrivateTripUseCase>(
//       () => CreatePrivateTripUseCase(instance()));

//   instance.registerLazySingleton<RateCustomerUseCase>(
//       () => RateCustomerUseCase(instance()));

//   instance.registerLazySingleton<RateCaptainUseCase>(
//       () => RateCaptainUseCase(instance()));

//   instance.registerLazySingleton<CustomerOnGoingOrderUseCase>(
//       () => CustomerOnGoingOrderUseCase(instance()));

//   instance.registerLazySingleton<CancelCustomerOrderUseCase>(
//       () => CancelCustomerOrderUseCase(instance()));

//   instance.registerLazySingleton<GetOrderByIdUseCase>(
//       () => GetOrderByIdUseCase(instance()));

//   instance.registerLazySingleton<ContactUsCubit>(
//       () => ContactUsCubit(instance(), instance()));
//   instance.registerLazySingleton<ContactUsUseCase>(
//       () => ContactUsUseCase(instance()));
//   instance.registerLazySingleton<SpinCubit>(
//       () => SpinCubit(instance(), instance()));
//   instance
//       .registerLazySingleton<RateUsUseCase>(() => RateUsUseCase(instance()));
//   instance.registerLazySingleton<SpinUseCase>(() => SpinUseCase(instance()));

  /// USE CASE CLASSES
}
