import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:take_me_with_you/imports.dart';

class SearchMapInput extends StatelessWidget {
  final TextEditingController _typeAheadController = TextEditingController();
  final List<RealEstateOnMap>? realEstatesOnMap;
  final Function(SearchResultModel selectedItem)? onSelect;
  final double? searchHeight;
  final double? suggestionBoxHeight;

  SearchMapInput(
      {super.key,
      this.realEstatesOnMap,
      this.onSelect,
      this.searchHeight,
      this.suggestionBoxHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      // color: Colors.red,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      height: searchHeight,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: TypeAheadField<SearchResultModel>(
          controller: _typeAheadController,
          builder: (context, controller, focusNode) {
            return TextField(
              focusNode: focusNode,
              controller: controller,
              // _typeAheadController,
              decoration: InputDecoration(
                prefixIcon: GestureDetector(
                  onTap: () {},
                  child: const Padding(
                      padding: EdgeInsets.all(12.0), child: Icon(Icons.search)),
                ),
                filled: true,
                isDense: true,
                fillColor: ColorManager.lightWhite,
                hintText: el.tr(AppStrings.search),
                hintStyle:
                    const TextStyle(color: ColorManager.primary, fontSize: 16),
                labelStyle:
                    const TextStyle(color: ColorManager.primary, fontSize: 16),
                helperStyle:
                    const TextStyle(color: ColorManager.primary, fontSize: 16),
                floatingLabelStyle:
                    const TextStyle(color: ColorManager.primary, fontSize: 16),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: ColorManager.primary),
                  borderRadius: BorderRadius.circular(14),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: ColorManager.primary),
                  borderRadius: BorderRadius.circular(14),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: ColorManager.primary),
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              style: const TextStyle(color: ColorManager.primary, fontSize: 16),
            );
          },
          suggestionsCallback: (pattern) async {
            if (pattern.isNotEmpty) {
              var controller = Get.find<SelectAddressMapController>();
              controller.getAddressPredictions(pattern);
              return controller.searchResult;
            }
            return [];
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
                dense: true,
                horizontalTitleGap: 10,
                minLeadingWidth: 15,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                title: Text(suggestion.name!),
                leading: const Icon(Icons.location_on));
          },
          onSelected: (SearchResultModel suggestion) {
            _typeAheadController.text = suggestion.name.toString();
            onSelect!(suggestion);
          },
        ),
      ),
    );
  }
}
