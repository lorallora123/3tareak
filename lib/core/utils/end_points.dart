class EndPoints {
  static const String baseUrl = "https://3tre2k.nashwati.com";
  // "http://192.168.103.161:8000/";
  //"https://apitareqe.dr-ayman.net/";
   static const String imagesUrl = "https://apitareqe.dr-ayman.net/public";
  static const String baseImageUrl = "$imagesUrl/storage";
  static const String userRegister = "/userapi/register";
  static const String userLogin = "/userapi/login";
  static const String userLogout = "/userapi/logout";
  static const String getProfile = "/userapi/show-profile";
  static const String showCaptainVehicles = "/userapi/show-captin-vehicles";
  static const String showVehicleTypes = "/userapi/show-vehicle-types";
  static const String addVehicle = "/userapi/vehicle";
  static const String joinOrder = "/userapi/join-order/";
  static const String createPrivateOrder = "/userapi/createPrivateOrder";
  static const String createOrder = "/userapi/order";
  static const String captainOnGoingOrder = "/userapi/captin-ongoing-orders";
  static const String captainCancelOrder = "/userapi/cancel-order";
  static const String customerCancelOrder = "/userapi/customer-cancel-order";
  static const String captainPreviousOrder = "/userapi/previous-orders";
  static const String getCustomerTrips = "/userapi/customer-trips";
  static const String captainStartOrder = "/userapi/captin-start-order";
  static const String customerInOrder = "/userapi/customer-in-order";
  static const String customerOutOrder = "/userapi/customer-arrive";
  static const String captainFinishOrder = "/userapi/finish-order";
  static const String getAvailableOrders = "/userapi/show-orders";
  static const String rateCustomer = "/userapi/rates";
  static const String spinCustomer = "/userapi/spin";
  static const String rateCaptain = "/userapi/rate-captin";
  static const String getCustomerOnGoingOrder =
      "/userapi/customer-ongoing-trip";
  static const String showOrderDetails = "/userapi/show-previous-order-detail";
  static const String contactUs = "/userapi/contact-us";
  static const String paymentRequest = "/userapi/paymentRequest";
  static const String paymentConfirmation = "/userapi/paymentConfirmation";
}
