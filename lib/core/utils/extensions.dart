import 'package:intl/intl.dart';

import 'constants.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return Constants.empty;
    } else {
      return this!;
    }
  }
}

extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return Constants.zero;
    } else {
      return this!;
    }
  }
}

extension NonNullDouble on double? {
  double orZero() {
    if (this == null) {
      return Constants.zeroDouble;
    } else {
      return this!;
    }
  }
}

extension FormatDate on String {
  String dateFormat() {
    final DateTime time =
        DateTime.tryParse(this)?.toLocal() ?? DateTime.now().toUtc();
    final dayFormatArabic = DateFormat("EEEE", "ar");
    final dateDay = dayFormatArabic.format(time);
    final dayFormatEnglish = DateFormat('dd', "en");
    final dateDayNum = dayFormatEnglish.format(time);
    final monthFormat = DateFormat("MMMM", 'ar');
    final dateMonth = monthFormat.format(time);
    final yearFormat = DateFormat("yyyy", 'en');
    final dateYear = yearFormat.format(time);
    final timeFormat = DateFormat("h:mm", "en");
    final dateTime = timeFormat.format(time);
    final timeUnit = DateFormat("a", "ar");
    final dateUnit = timeUnit.format(time);

    return "$dateDay $dateDayNum $dateMonth $dateYear  $dateTime $dateUnit";
  }
}

// extension DistanceFormat on String {
//   String distanceFormat() {
//     if (isEmpty) return "0";
//     final distance = double.parse(this) / 1000;
//     return distance.toStringAsFixed(2);
//   }
// }
