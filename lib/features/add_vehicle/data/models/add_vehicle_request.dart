import 'dart:io';

import 'package:dio/dio.dart';

class AddVehicleRequest {
  int vehicleTypeId;
  String model;
  String color;
  String boardNumber;
  int seatNumber;
  File vehicleImage;
  File boardImage;
  File idImage;
  File mechanicImage;
  File delegateImage;

  AddVehicleRequest(
      this.model,
      this.mechanicImage,
      this.idImage,
      this.delegateImage,
      this.boardImage,
      this.vehicleImage,
      this.color,
      this.seatNumber,
      this.boardNumber,
      this.vehicleTypeId);

  Future<Map<String, dynamic>> toJson() async {
    return <String, dynamic>{
    "vehicle_type_id": vehicleTypeId,
    "model": model,
    "color": color,
    "seat_number": seatNumber,
    "board_number": boardNumber,
    "vehicle_image": await MultipartFile.fromFile(vehicleImage.path, filename: "vehicle_image.jpg"),
    "board_image": await MultipartFile.fromFile(boardImage.path, filename: "board_image.jpg"),
    "id_image": await MultipartFile.fromFile(idImage.path, filename: "id_image.jpg"),
    "mechanic_image": await MultipartFile.fromFile(mechanicImage.path, filename: "mechanic_image.jpg"),
    "delegate_image": await MultipartFile.fromFile(delegateImage.path, filename: "delegate_image.jpg"),
  };
  }
}
