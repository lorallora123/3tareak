import 'package:take_me_with_you/core/utils/assets_manger.dart';
import 'function.dart';

class Constants {
  static const String empty = "";
  static const int zero = 0;
  static const double scale = 1.0;
  static const double zeroDouble = 0.0;
  static const int apiTimeOut = 60;
  static const String bearer = 'Bearer ';
  static const int splashDelay = 2000;
  static const int sliderAnimation = 300;
  static const String googleMapKey = 'AIzaSyC8oiI-5JJewkecccgdLPVS0EUgHhvh4_U';

  static Map<String, String> vehicleIcon = {
    VehicleType.car.name: ImageAssets.car,
    VehicleType.bus.name: ImageAssets.bus,
    VehicleType.van.name: ImageAssets.van,
    VehicleType.motor.name: ImageAssets.motor,
  };

  static Map<String, String> imageStatus = {
    "join": ImageAssets.sendRequest,
    "accepted": ImageAssets.tripAccepted,
    "approved": ImageAssets.tripStarted,
    "end": ImageAssets.tripFinished,
    "cancel": ImageAssets.tripFinished,
  };

  static Map<String, String> descriptionStatus = {
    "join":
        "تم إرسال طلبك \n بانتظار الموافقة على الطلب \n سيتم إعلامك بالنتجة",
    "accepted": "تمت الموافقة على طلبك \n والكابتن بانتظارك",
    "approved": "لقد بدأت الرحلة",
    "end": "تم إنهاء الرحلة \n المبلغ الإجمالي للرحلة",
    "cancel": "تم إلغاء الرحلة",
  };
}
