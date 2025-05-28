import 'dart:io';

import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:take_me_with_you/imports.dart';

class AddVehicleController extends GetxController {
  final AddVehicleRepo _addVehicleRepo = instance<AddVehicleRepo>();
  final RxBool _isShowOnly = false.obs;
  VehicleDataResponse? model;
  final formKey = GlobalKey<FormState>();
  final RxBool _loading = false.obs;
  final TextEditingController modelController = TextEditingController();
  final TextEditingController vehicleIdController = TextEditingController();
  final TextEditingController seatsNumberController = TextEditingController();
  final VehicleSelectionController controller =
      Get.find<VehicleSelectionController>();
  final RxString _vehicleGroupValue = ''.obs;
  final RxString _vehicleGroupValueTitle = ''.obs;
  final TextEditingController _colorGroupValue = TextEditingController();
  late List<DropDownModel> vehicle = [];
  final List<DropDownModel> color = [
    DropDownModel(title: "احمر", value: "احمر"),
    DropDownModel(title: "ابيض", value: "ابيض"),
    DropDownModel(title: "اصفر", value: "اصفر"),
    DropDownModel(title: "فضي", value: "فضي"),
  ];
  final ImagePicker imagePicker = ImagePicker();
  final RxList<File> vehicleImages = <File>[].obs;
  late List<String> images;

  String get vehicleGroupValue => _vehicleGroupValue.value;

  String get vehicleGroupValueTitle => _vehicleGroupValueTitle.value;

  TextEditingController get colorGroupValue => _colorGroupValue;

  bool get isShowOnly => _isShowOnly.value;

  bool get loading => _loading.value;

  set vehicleGroupValue(value) => _vehicleGroupValue.value = value;

  set vehicleGroupValueTitle(value) => _vehicleGroupValueTitle.value = value;

  set colorGroupValue(value) => _colorGroupValue.text = value;

  set isShowOnly(value) => _isShowOnly.value = value;

  set loading(value) => _loading.value = value;

  onChangedVehicleGroupValue(String? value, String titleValue) {
    vehicleGroupValue = value;
    vehicleGroupValueTitle = titleValue;
  }

  onChangedColorGroupValue(String? value) {
    colorGroupValue = value;
  }

  addVehicleImage() async {
    await Permission.storage.request();
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      vehicleImages.add(File(file.path));
      vehicleImages.refresh();
    }

    // if (true) {
    //   if (vehicleImages.length < 5) {
    //     final image = await imagePicker.pickImage(source: ImageSource.gallery);
    //     if (image != null && image.path.isNotEmpty) {
    //       vehicleImages.add(File(image.path));
    //       vehicleImages.refresh();
    //     }
    //   } else {
    //     AppMessage.showToast(AppStrings.errorVehicleImage.tr());
    //   }
    // }
  }

  deleteVehicleImage(int index) {
    vehicleImages.removeAt(index);
    vehicleImages.refresh();
  }

  getVehicleType() {
    for (var element in controller.vehicleTypeModel.vehicleTypes!) {
      vehicle.add(DropDownModel(
          title: element.type ?? '', value: element.id.toString()));
    }
  }

  addVehicle() async {
    if (formKey.currentState!.validate()) {
      if (vehicleImages.length == 5) {
        if (vehicleGroupValue.isNotEmpty) {
          if (colorGroupValue.text.isNotEmpty) {
            loading = true;
            (await _addVehicleRepo.addVehicle(
                    addVehicleRequest: AddVehicleRequest(
                        modelController.text,
                        vehicleImages[0],
                        vehicleImages[3],
                        vehicleImages[4],
                        vehicleImages[2],
                        vehicleImages[1],
                        colorGroupValue.text,
                        int.parse(seatsNumberController.text),
                        vehicleIdController.text,
                        int.parse(vehicleGroupValue))))
                .fold(
                    (l) => AppMessage.showToast(l.message),
                    (r) => Get.dialog(const CreateVehicleDialog())
                        .whenComplete(() => Get.back()));
            loading = false;
          } else {
            AppMessage.showToast(el.tr(AppStrings.addVehicleColorError));
          }
        } else {
          AppMessage.showToast(el.tr(AppStrings.addVehicleTypeError));
        }
      } else {
        AppMessage.showToast(el.tr(AppStrings.addVehicleImageError));
      }
    }
  }

  selectVehicle() {
    controller.selectedVehicle.value = model!;
    Get.back();
  }

  @override
  void onInit() {
    model = Get.arguments;
    getVehicleType();
    if (model != null) {
      isShowOnly = true;
      vehicleGroupValueTitle = model!.type!.type;
      vehicleGroupValue = model!.type!.id.toString();
      colorGroupValue = model!.color;

      modelController.text = model!.model ?? '';
      vehicleIdController.text = model!.boardNumber.toString();
      images = [
        model!.vehicleImage ?? '',
        model!.boardImage ?? '',
        model!.delegateImage ?? '',
        model!.idImage ?? '',
        model!.mechanicImage ?? ''
      ];
      seatsNumberController.text = model!.seatNumber.toString();
    }
    super.onInit();
  }
}
