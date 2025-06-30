import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/foundation.dart';
import 'package:take_me_with_you/core/models/customer_trips_response.dart';
import 'package:take_me_with_you/core/services/internet_checker.dart';
import 'package:take_me_with_you/core/utils/app_pref.dart';
import 'package:take_me_with_you/core/utils/di.dart';
import 'package:take_me_with_you/core/utils/string_manger.dart';

enum PaginationTypes {
  oldCustomerOrder,
  oldCaptainOrder,
}

enum AppLanguage {
  ar,
  en,
}

enum VehicleType {
  car,
  bus,
  van,
  motor,
}

enum DrawerType { normal, customer, captain }

enum SwipeButtonStatus { normal, loading, success, failure }

String? valid(String? value) {
  if (value!.isEmpty) return el.tr(AppStrings.validFiled);
  return null;
}

String? validPhoneNumber(String? value) {
  if (value!.isEmpty) return el.tr(AppStrings.validFiled);
  if (value.length != 10 || !value.startsWith('09')) {
    return el.tr(AppStrings.validPhoneNumber);
  }
  return null;
}

String? validPassword(String? value) {
  if (value!.isEmpty) return el.tr(AppStrings.validFiled);
  if (value.length < 8) return el.tr(AppStrings.validPassword);
  return null;
}

String? validMinChars(String? value) {
  if (value!.length < 3) return el.tr(AppStrings.validMinChars);
  return null;
}

String formatDistance(int? distanceInMeters) {
  if (distanceInMeters == null) {
    return "0";
  } else if (distanceInMeters >= 1000) {
// Convert to kilometers
    double distanceInKilometers = distanceInMeters / 1000;
    return '${distanceInKilometers.toStringAsFixed(1)} كم ';
  } else {
// Display in meters
    return '${distanceInMeters.round()} متر ';
  }
}

String extractNumbers(String input) {
  RegExp regExp = RegExp(r'[0-9\.]+');
  Iterable<RegExpMatch> matches = regExp.allMatches(input);
  List<String> numbers = [];
  for (var match in matches) {
    numbers.add(match.group(0)!);
  }
  return numbers.join('');
}

String convertFrom24To12HourTypes({required String currentTime}) {
  if (currentTime.isNotEmpty && currentTime != "الآن") {
    List<String> time = currentTime.split(":");
    int hour = int.parse(time[0]);
    int minute = int.parse(time[1]);

    String period = 'AM';
    if (hour >= 12) {
      period = 'PM';
      hour = hour == 12 ? 12 : hour - 12;
    }
    if (hour == 0) {
      hour = 12;
    }

    String hourStr = hour.toString().padLeft(2, '0');
    String minuteStr = minute.toString().padLeft(2, '0');

    String time12hr = "$hourStr:$minuteStr $period";

    return time12hr;
  } else {
    return "";
  }
}

String convertFrom12To24HourTypes({required String currentTime}) {
  log(currentTime.toString(), name: 'Current Time');
  if (currentTime.isNotEmpty) {
    List<String> parts = currentTime.split(" ");
    log(parts.toString(), name: 'Parts');
    List<String> time = parts[0].split(":");
    log(time.toString(), name: 'Time');
    String hourStr = time[0];
    log(hourStr.toString(), name: 'Hour Str');
    String minuteStr = time[1];
    log(minuteStr.toString(), name: 'Minute Str');
    String amPm = parts[1];
    log(amPm.toString(), name: 'Am Pm');
    int hour = int.parse(hourStr);

    if (amPm == "AM" && hour == 12) {
      hour = 0;
    } else if (amPm == "PM" && hour != 12) {
      hour += 12;
    }

    hourStr = hour.toString().padLeft(2, '0');
    minuteStr = minuteStr.padLeft(2, '0');

    String time24hr = "$hourStr:$minuteStr";

    return time24hr;
  } else {
    return "";
  }
}

enum RequestState {
  none,
  loading,
  success,
  empty,
  error,
  paginationLoading,
  paginationError
}

logPrint(message) {
  if (!kReleaseMode) {
    debugPrint(message.toString(), wrapWidth: 1000000000000);
    // log(message.toString());
  }
}

Future<bool> noInternetConnection() async =>
    await instance<NetworkInfo>().isConnected == false;

Options options() {
  return Options(
    headers: {
      // "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer ${instance<AppPreferences>().getUserToken()}",
    },
  );
}

List<dynamic> getEntityList(
    PaginationTypes paginationType, List<dynamic> data) {
  List<dynamic> allData = [];
  switch (paginationType) {
    case PaginationTypes.oldCustomerOrder:
      {
        for (var element in data) {
          allData.add((element as CustomerTripDataResponse));
        }
        return allData;
      }

    default:
      return allData;
  }
}
