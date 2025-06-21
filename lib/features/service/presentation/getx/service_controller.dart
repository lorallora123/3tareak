import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:take_me_with_you/core/services/socket_service.dart';
import 'package:take_me_with_you/core/utils/socket_events.dart';
import 'package:http/http.dart' as http;
import '../../../../imports.dart';

class ServiceController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final RxBool loading = false.obs;
  final RxBool loadingLogOut = false.obs;
  UserResponse userDataModel = UserResponse();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final ServiceRepo _serviceRepo = instance<ServiceRepo>();

  Future<void> deleteAccount() async {
    loadingLogOut(true);

    try {
      final token = _appPreferences.getUserToken();

      final response = await http.delete(
        Uri.parse('https://3tre2k.nashwati.com/userapi/delete-profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        AppMessage.appSnackBar('تم الحذف', 'تم حذف الحساب بنجاح');
        _appPreferences.removeUserToken();
        Get.offNamedUntil(AppRoutes.loginRoute, (route) => false);
      } else {
        logPrint('Delete failed with status {response.statusCode}');
        AppMessage.appSnackBar('خطأ', 'فشل حذف الحساب');
      }
    } catch (e) {
      logPrint('Delete error: $e');
    } finally {
      loadingLogOut(false);
    }
  }

  Future<void> getProfile() async {
    loading.value = true;
    loading.update((val) {});
    (await _serviceRepo.getProfile()).fold((l) => null, (r) {
      userDataModel = r;
      loading.value = false;
      loading.update((val) {});
    });
  }

  logout() async {
    loadingLogOut(true);
    (await _serviceRepo.logout()).fold(
      (l) {
        logPrint(l.message);
        AppMessage.appSnackBar('خطأ', 'فشل تسجيل الخروج');
        if (l.code == 401) {
          _appPreferences.removeUserToken();
          Get.offNamedUntil(AppRoutes.loginRoute, (route) => false);
        }
      },
      (r) {
        AppMessage.appSnackBar('تم تسجيل الخروج', 'تم تسجيل الخروج بنجاح');
        _appPreferences.removeUserToken();
        Get.offNamedUntil(AppRoutes.loginRoute, (route) => false);
      },
    );
    loadingLogOut(false);
  }

  Future<void> createOrder(int orderId) async {
    await instance<SocketService>().send(SocketEvents.createOrder, orderId);
  }

  Future<void> joinRequest(
      int orderId, String userType, LatLng location) async {
    Map<String, dynamic> data = {
      'id': instance<AppPreferences>().getUserId()!,
      'order_id': orderId,
      'user_type': userType,
      'location': <String, dynamic>{
        'lat': location.latitude,
        'long': location.longitude,
      },
    };
    await instance<SocketService>().send(SocketEvents.joinRequest, data);
  }

  Future<void> cancelJoinRequest() async {
    Map<String, dynamic> data = {
      'id': instance<SocketService>().getId(),
    };
    await instance<SocketService>().send(SocketEvents.cancelJoinRequest, data);
  }

  Future<void> approveJoinRequest(int orderId, int userId) async {
    Map<String, dynamic> data = {
      'user_id': userId,
      'order_id': orderId,
      'socket_id': instance<SocketService>().getId(),
    };
    await instance<SocketService>().send(SocketEvents.approveJoinRequest, data);
  }

  Future<void> startOrder(int orderId) async {
    await instance<SocketService>().send(SocketEvents.startOrder, orderId);
  }

  Future<void> orderLocation(int orderId, LatLng location) async {
    Map<String, dynamic> data = {
      'order_id': orderId,
      'location': <String, dynamic>{
        'lat': location.latitude,
        'long': location.longitude,
      },
    };
    await instance<SocketService>().send(SocketEvents.orderLocation, data);
  }

  Future<void> completeOrder(int orderId) async {
    await instance<SocketService>().send(SocketEvents.completeOrder, orderId);
  }

  void orderCreated() {
    instance<SocketService>().listen('order_created', (data) {
      logPrint('Socket Listen data order_created $data');
    });
  }

  void requestJoined() {
    instance<SocketService>().listen('join_request', (data) {
      logPrint('Socket Listen data join_request $data');
      Get.dialog(AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                16.horizontalSpace,
                CustomText(
                  text: "لديك طلب جديد",
                  textAlign: TextAlign.center,
                  style: Get.textTheme.displayMedium!.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () => Get.back(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.clear,
                      color: Colors.black,
                      size: 12.h,
                    ),
                  ),
                ),
              ],
            ),
            24.verticalSpace,
            CustomText(
              text: "اضفط لمعرفة باقي التفاصيل",
              textAlign: TextAlign.center,
              style: Get.textTheme.displayMedium!
                  .copyWith(fontSize: 16.sp, color: ColorManager.iconGreyColor),
            ),
            24.verticalSpace,
            InkWell(
              overlayColor: WidgetStateColor.transparent,
              onTap: () {
                Get.toNamed(AppRoutes.onGoingTripsRoute, arguments: {
                  'orderId': data['order_id'],
                  'userId': data['user_id'],
                });
              },
              child: Container(
                width: double.infinity,
                height: 45.h,
                decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: BorderRadius.circular(25.r)),
                child: Center(
                  child: CustomText(
                    text: "الذهاب",
                    textAlign: TextAlign.center,
                    style: Get.textTheme.displayMedium!
                        .copyWith(fontSize: 16.sp, color: ColorManager.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ));
    });
  }

  void joinApproved() {
    instance<SocketService>().listen('join_approved', (data) {
      logPrint('Socket Listen data join_approved $data');
    });
  }

  void joinCanceled() {
    instance<SocketService>().listen('join_canceled', (data) {
      logPrint('Socket Listen data join_canceled $data');
    });
  }

  void orderStarted() {
    instance<SocketService>().listen('order_started', (data) {
      logPrint('Socket Listen data order_started $data');
    });
  }

  void listenOrderLocation() {
    instance<SocketService>().listen('order_location', (data) {
      logPrint('Socket Listen data order_location $data');
    });
  }

  @override
  void onInit() async {
    instance<SocketService>().connect();
    listenOrderLocation();
    orderStarted();
    joinCanceled();
    joinApproved();
    requestJoined();
    orderCreated();
    await getProfile();
    super.onInit();
  }

  @override
  void onClose() {
    instance<SocketService>().disconnect();
    super.dispose();
  }
}
