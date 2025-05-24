import 'package:get/get.dart';
import 'package:take_me_with_you/features/spin/presentation/getx/spin_binding.dart';
import 'package:take_me_with_you/features/spin/presentation/view/spin_screen.dart';
import 'package:take_me_with_you/features/trip_map/presentation/getx/trip_map_binding.dart';
import 'package:take_me_with_you/features/trip_map/presentation/view/trip_map_view.dart';
import 'package:take_me_with_you/imports.dart';

class AppRoutes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onBoardingRoute';
  static const String loginRoute = '/loginRoute';
  static const String registerRoute = '/registerRoute';
  // static const String otpRoute = '/otpRoute';
  static const String serviceRoute = '/serviceRoute';
  static const String vehicleSelectionRoute = '/vehicleSelectionRoute';
  static const String addVehicleRoute = '/addVehicleRoute';
  static const String createTripRoute = '/createTripRoute';
  static const String mapRoute = '/mapRoute';
  static const String myOnGoingTripsRoute = '/myOnGoingTripsRoute';
  static const String onGoingTripsRoute = '/onGoingTripsRoute';
  static const String availableTripsRoute = '/availableTripsRoute';
  static const String tripDetailsRoute = '/tripDetailsRoute';
  static const String profitRoute = '/profitRoute';
  static const String myOldTripsRoute = '/myOldTripsRoute';
  static const String myOldOrdersRoute = '/myOldOrdersRoute';
  static const String oldTripRoute = '/oldTripRoute';
  static const String oldOrderRoute = '/oldOrderRoute';
  static const String liveTripRoute = '/liveTripRoute';
  static const String selectAddressMapRoute = '/selectAddressMapRoute';
  static const String tripMapView = '/tripMapView';
  static const String contactUs = '/contact-us';
  static const String verificationCodeRoute = '/verification-code';
  static const String spinScreenRoute = '/spinScreen';
}

List<GetPage> pages = [
  GetPage(
      name: AppRoutes.splashRoute,
      page: () => const SplashView(),
      binding: SplashBinding()),
  GetPage(
      name: AppRoutes.onBoardingRoute,
      page: () => const OnBoardingView(),
      binding: OnBoardingBinding()),
  GetPage(
      name: AppRoutes.loginRoute,
      page: () => const LoginView(),
      binding: LoginBinding()),
  GetPage(
      name: AppRoutes.registerRoute,
      page: () => const RegisterView(),
      binding: RegisterBinding()),
//   // GetPage(name: AppRoutes.otpRoute, page: () => const OtpView(), binding: OtpBinding()),
  GetPage(
      name: AppRoutes.serviceRoute,
      page: () => const ServiceView(),
      binding: ServiceBinding()),
//   // GetPage(name: AppRoutes.verificationCodeRoute, page: () => const VerificationCodeView(),),
  GetPage(
      name: AppRoutes.vehicleSelectionRoute,
      page: () => const VehicleSelectionView(),
      binding: VehicleSelectionBinding()),
  GetPage(
      name: AppRoutes.addVehicleRoute,
      page: () => const AddVehicleView(),
      binding: AddVehicleBinding()),
  GetPage(
      name: AppRoutes.createTripRoute,
      page: () => CreateTripView(isPrivate: Get.arguments['isPrivate']),
      binding: CreateTripBinding()),
  GetPage(
      name: AppRoutes.myOnGoingTripsRoute,
      page: () => const MyOnGoingTripsView(),
      binding: MyOnGoingTripsBinding()),
  GetPage(
      name: AppRoutes.onGoingTripsRoute,
      page: () => const OnGoingTripView(),
      binding: OnGoingTripBinding()),
  GetPage(
      name: AppRoutes.availableTripsRoute,
      page: () => AvailableTripsView(),
      binding: AvailableTripsBinding()),
  GetPage(
      name: AppRoutes.tripDetailsRoute,
      page: () => const DetailsView(),
      binding: TripDetailsBinding()),
//   GetPage(
//       name: AppRoutes.profitRoute,
//       page: () => const ProfitView(),
//       binding: ProfitBinding()),
  GetPage(
      name: AppRoutes.myOldTripsRoute,
      page: () => const MyOldTripsView(),
      binding: MyOldTripsBonding()),
  // GetPage(
  //     name: AppRoutes.oldTripRoute,
  //     page: () => const OldTripView(),
  //     binding: OldTripBinding()),
  // GetPage(
  //     name: AppRoutes.oldOrderRoute,
  //     page: () => const OldOrderView(),
  //     binding: OldOrderBinding()),
  GetPage(
      name: AppRoutes.liveTripRoute,
      page: () => const LiveTripView(),
      binding: LiveTripBinding()),
  GetPage(
      name: AppRoutes.myOldOrdersRoute,
      page: () => const MyOldOrdersView(),
      binding: MyOldOrdersBonding()),
  GetPage(
    name: AppRoutes.selectAddressMapRoute,
    page: () => SelectAddressMapView(isOrigin: Get.arguments['isOrigin']),
  ),
  GetPage(
    name: AppRoutes.tripMapView,
    page: () => const TripMapView(),
    binding: TripMapBinding(),
  ),
  GetPage(
    name: AppRoutes.spinScreenRoute,
    page: () => const SpinScreen(),
    binding: SpinBinding(),
  ),
];
