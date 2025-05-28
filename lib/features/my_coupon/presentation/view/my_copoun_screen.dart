// import 'package:flutter/material.dart';

// import '../../../core/utils/color_manger.dart';

// class MyCouponsScreen extends StatefulWidget {
//   const MyCouponsScreen({super.key});

//   @override
//   State<MyCouponsScreen> createState() => _MyCouponsScreenState();
// }

// class _MyCouponsScreenState extends State<MyCouponsScreen> {
//   final List<Map<String, dynamic>> fakeCoupons = [
//     {
//       "name": "خصم ١٥٪",
//       "percentage": 15.0,
//       "fixedValue": null,
//       "active": 1,
//     },
//     {
//       "name": "قسيمة ١٠٠٠ ل.س",
//       "percentage": null,
//       "fixedValue": 1000.0,
//       "active": 0,
//     },
//     {
//       "name": "عرض الصيف",
//       "percentage": 25.0,
//       "fixedValue": null,
//       "active": 1,
//     },
//     {
//       "name": "قسيمة قديمة",
//       "percentage": null,
//       "fixedValue": 500.0,
//       "active": 0,
//     },
//     {
//       "name": "خصم ١٥٪",
//       "percentage": 15.0,
//       "fixedValue": null,
//       "active": 1,
//     },
//     {
//       "name": "قسيمة ١٠٠٠ ل.س",
//       "percentage": null,
//       "fixedValue": 1000.0,
//       "active": 0,
//     },
//     {
//       "name": "عرض الصيف",
//       "percentage": 25.0,
//       "fixedValue": null,
//       "active": 1,
//     },
//     {
//       "name": "قسيمة قديمة",
//       "percentage": null,
//       "fixedValue": 500.0,
//       "active": 0,
//     },{
//       "name": "خصم ١٥٪",
//       "percentage": 15.0,
//       "fixedValue": null,
//       "active": 1,
//     },
//     {
//       "name": "قسيمة ١٠٠٠ ل.س",
//       "percentage": null,
//       "fixedValue": 1000.0,
//       "active": 0,
//     },
//     {
//       "name": "عرض الصيف",
//       "percentage": 25.0,
//       "fixedValue": null,
//       "active": 1,
//     },
//     {
//       "name": "قسيمة قديمة",
//       "percentage": null,
//       "fixedValue": 500.0,
//       "active": 0,
//     },
//   ];

//   int selectedTab = 1; // 1 => فعال، 0 => غير فعال

//   @override
//   Widget build(BuildContext context) {
//     final filteredCoupons =
//         fakeCoupons.where((c) => c["active"] == selectedTab).toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("كوبوناتي"),
//         centerTitle: true,
//       ),
//       backgroundColor: const Color(0xFFF9F9F9),
//       body: Column(
//         children: [
//           const SizedBox(height: 8),

//           // زرّي التصفية
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Row(
//               children: [
//                 _buildTabButton("الفعالة", 1),
//                 const SizedBox(width: 8),
//                 _buildTabButton("الغير فعالة", 0),
//               ],
//             ),
//           ),

//           const SizedBox(height: 12),

//           // عرض الكوبونات حسب الفئة
//           Expanded(
//             child: filteredCoupons.isEmpty
//                 ? const Center(child: Text("لا يوجد كوبونات"))
//                 : ListView.builder(
//                     padding: const EdgeInsets.all(12),
//                     itemCount: filteredCoupons.length,
//                     itemBuilder: (context, index) {
//                       final coupon = filteredCoupons[index];
//                       final isPercentage = coupon["percentage"] != null;
//                       final value = isPercentage
//                           ? "${coupon["percentage"]}%"
//                           : "${coupon["fixedValue"]} ل.س";
//                       final type = isPercentage ? "نسبة" : "قيمة ثابتة";

//                       return Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         elevation: 3,
//                         margin: const EdgeInsets.symmetric(vertical: 6),
//                         child: ListTile(
//                           title: Text(
//                             coupon["name"],
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                           subtitle: Row(
//                             children: [
//                               Text("القيمة: $value"),
//                               const SizedBox(width: 10),
//                               Chip(
//                                 label: Text(type,style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                             ),),
//                                 backgroundColor: ColorManger.primary.withOpacity(0.09),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTabButton(String text, int value) {
//     final isSelected = selectedTab == value;
//     return Expanded(
//       child: ElevatedButton(
//         onPressed: () {
//           setState(() {
//             selectedTab = value;
//           });
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: isSelected ?ColorManger.primary : Colors.grey[300],
//           foregroundColor: isSelected ? Colors.white : Colors.black,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//           padding: const EdgeInsets.symmetric(vertical: 12),
//         ),
//         child: Text(text),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/color_manger.dart';
import '../cubit/my_coupon_cubit.dart';
import '../cubit/my_coupon_state.dart';

class MyCouponsScreen extends StatefulWidget {
  const MyCouponsScreen({super.key});

  @override
  State<MyCouponsScreen> createState() => _MyCouponsScreenState();
}

class _MyCouponsScreenState extends State<MyCouponsScreen> {
  int selectedTab = 1;

  @override
  void initState() {
    super.initState();
    context.read<MyCopounCubit>().getMyCoupon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "كوبوناتي",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      backgroundColor: ColorManger.white,
      body: Column(
        children: [
          12.h.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                _buildTabButton("المستخدمة", 1),
                8.w.horizontalSpace,
                _buildTabButton("الغير مستخدمة", 0),
              ],
            ),
          ),
          16.h.verticalSpace,
          Expanded(
            child: BlocListener<MyCopounCubit, MyCouponState>(
              listener: (context, state) {
                if (state is MyCouponFailState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("فشل التحميل: ${state.message}"),
                      backgroundColor: ColorManger.primary,
                    ),
                  );
                }
              },
              child: BlocBuilder<MyCopounCubit, MyCouponState>(
                builder: (context, state) {
                  if (state is MyCouponLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MyCouponSuccessState) {
                    final filtered = state.coupons.where((uc) {
                      return (selectedTab == 1 && uc.usedAt != null) ||
                          (selectedTab == 0 && uc.usedAt == null);
                    }).toList();

                    if (filtered.isEmpty) {
                      return Center(
                        child: Text(
                          "لا يوجد كوبونات",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.all(12.w),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final coupon = filtered[index].coupon;
                        if (coupon == null) return const SizedBox.shrink();

                        final isPercentage = coupon.percentage != null;
                        final value = isPercentage
                            ? "${coupon.percentage!.toStringAsFixed(1)}%"
                            : "${coupon.fixedValue?.toStringAsFixed(1)} ل.س";
                        final type = isPercentage ? "نسبة" : "قيمة ثابتة";

                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          elevation: 3,
                          margin: EdgeInsets.symmetric(vertical: 6.h),
                          child: Padding(
                            padding: EdgeInsets.all(12.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  coupon.name ?? "اسم غير متوفر",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                6.h.verticalSpace,
                                Row(
                                  children: [
                                    Text(
                                      "القيمة: $value",
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                    10.w.horizontalSpace,
                                    Chip(
                                      label: Text(
                                        type,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      backgroundColor: ColorManger.primary
                                          .withOpacity(0.09),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        "ابدأ بتحميل الكوبونات",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, int value) {
    final isSelected = selectedTab == value;
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedTab = value;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isSelected ? ColorManger.primary : Colors.grey[300],
          foregroundColor: isSelected ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 12.h),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 14.sp),
        ),
      ),
    );
  }
}

