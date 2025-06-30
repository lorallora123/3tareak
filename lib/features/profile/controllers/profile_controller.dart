import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:take_me_with_you/core/utils/app_pref.dart';
import 'package:take_me_with_you/core/utils/di.dart';
import 'package:take_me_with_you/core/utils/end_points.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var fullname = ''.obs;
  var phoneNumber = ''.obs;
  var imageUrl = ''.obs;

  @override
  void onInit() {
    fetchProfile();
    super.onInit();
  }

  Future<void> fetchProfile() async {
    isLoading.value = true;
    final appPreferences = instance<AppPreferences>();
    final String? token = appPreferences.getUserToken();

    final response = await http.get(
      Uri.parse(EndPoints.baseUrl + EndPoints.showProfile),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    print('Body: ${response.body}');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final user = data['data']['user'];
      fullname.value = user['fullname'] ?? '';
      phoneNumber.value = user['phone_number'] ?? '';
      imageUrl.value = user['image'] ?? '';
    }
    isLoading.value = false;
  }
}
