import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/utils/styles_manger.dart';

class AboutAppDialog extends StatelessWidget {
  const AboutAppDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Container(
        width: 0.99.sw,
        height: 0.8.sh,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorManager.primary.withValues(alpha: 0.02),
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: ColorManager.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.white,
                    size: 35.w,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'عن التطبيق',
                    style: getBoldStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main description
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        'يهدف تطبيق عطريقك إلى تقديم تجربة تنقّل آمنة، مرنة وسهلة الاستخدام ضمن بيئة تقنية موثوقة. يوفّر التطبيق مجموعة متكاملة من الخدمات التي تلبي احتياجات المستخدمين اليومية، مع الالتزام بأعلى معايير الخصوصية والجودة.',
                        style: getRegularStyle(
                          color: ColorManager.blackText,
                          fontSize: 14.4.sp,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Features list
                    _buildFeatureItem(
                      icon: Icons.route,
                      title: '1. إدارة الرحلات',
                      description:
                          'يتيح التطبيق إمكانية حجز الرحلات بشكل مسبق أو فوري، مع خيارات مخصصة للوقت والموقع، لتوفير أقصى درجات الراحة والمرونة في التنقل.',
                    ),

                    _buildFeatureItem(
                      icon: Icons.security,
                      title: '2. الخصوصية والأمان',
                      description:
                          'يحرص التطبيق على حماية خصوصية المستخدمين، حيث تبقى معلومات السائق مرئية فقط له ولإدارة النظام بعد تسجيل الدخول. كما تُدار البيانات وفق أعلى معايير الأمان.',
                    ),

                    _buildFeatureItem(
                      icon: Icons.star_rate,
                      title: '3. نظام التقييم والملاحظات',
                      description:
                          'بعد انتهاء كل رحلة، يمكن للمستخدم والسائق تقييم التجربة. يُستخدم نظام التقييم لتحسين جودة الخدمة بشكل دائم، مع إمكانية تقديم الملاحظات والشكاوى مباشرة من التطبيق.',
                    ),

                    _buildFeatureItem(
                      icon: Icons.payment,
                      title: '4. خيارات الدفع المتنوعة',
                      description:
                          'يدعم التطبيق الدفع النقدي والدفع الإلكتروني (عبر سيريتل وMTN)، كما يتيح استخدام كوبونات الخصم في حال توفرها، مع إدارة تلقائية للمبالغ والخصومات ضمن محفظة المستخدم.',
                    ),

                    _buildFeatureItem(
                      icon: Icons.location_on,
                      title: '5. خدمات الموقع والتتبع',
                      description:
                          'يمكن للمستخدم تتبع موقع السائق والرحلة لحظة بلحظة باستخدام خرائط دقيقة، بما يضمن الوضوح والاطمئنان خلال كامل مدة الرحلة.',
                    ),

                    _buildFeatureItem(
                      icon: Icons.casino,
                      title: '6. مزايا ترويجية وتحفيزية',
                      description:
                          'يقدّم التطبيق ميزة "دولاب الحظ"، والتي تتيح للمستخدمين فرصة الحصول على خصومات يومية، تُستخدم لمرة واحدة خلال 24 ساعة، بما يشجع على التفاعل الدائم مع التطبيق.',
                    ),

                    _buildFeatureItem(
                      icon: Icons.support_agent,
                      title: '7. خدمة العملاء',
                      description:
                          'يُوفر التطبيق دعماً مباشراً عبر قسم خاص لخدمة العملاء، يتيح للمستخدم تقديم الشكاوى والمقترحات التي يتم التعامل معها باحترافية من قبل الفريق المختص.',
                    ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),

            // Go back button
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 3,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back, size: 20.w),
                    SizedBox(width: 8.w),
                    Text(
                      'رجوع',
                      style: getBoldStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: ColorManager.primary.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: ColorManager.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: ColorManager.primary,
              size: 20.w,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: getBoldStyle(
                    color: ColorManager.primary,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: getRegularStyle(
                    color: ColorManager.blackText,
                    fontSize: 12.sp,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
