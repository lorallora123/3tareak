import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:take_me_with_you/core/models/drop_down_model.dart';
import 'package:take_me_with_you/core/utils/color_manger.dart';
import 'package:take_me_with_you/core/widgets/custom_text.dart';

// ignore: must_be_immutable
class ExpandWidget extends StatefulWidget {
  final List<DropDownModel> items;
  String groupValue;
  String groupValueTitle;
  void Function(String?, String)? onChanged;

  ExpandWidget(
      {required this.items,
      required this.groupValue,
      required this.groupValueTitle,
      this.onChanged,
      super.key});

  @override
  State<ExpandWidget> createState() => _ExpandWidgetState();
}

class _ExpandWidgetState extends State<ExpandWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => RadioListTile(
              title: CustomText(
                  text: widget.items[index].title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 15.sp)),
              fillColor: WidgetStateProperty.all(
                  widget.groupValue == widget.items[index].value
                      ? ColorManager.primary
                      : ColorManager.blackText),
              value: widget.items[index].value,
              groupValue: widget.groupValue,
              onChanged: (value) {
                setState(() {
                  widget.groupValue = value!;
                  widget.groupValueTitle = widget.items[index].title;
                });
                widget.onChanged!(value, widget.items[index].title);
              },
            ),
        separatorBuilder: (context, index) => 15.verticalSpace,
        itemCount: widget.items.length);
  }
}
