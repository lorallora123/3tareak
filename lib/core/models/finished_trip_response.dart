class FinishTripResponse {
  FinishedTripDataResponse? finishedOrder;

  FinishTripResponse(this.finishedOrder);

  Map<String, dynamic> toJson() => {
        "finished_order": finishedOrder?.toJson(),
      };

  factory FinishTripResponse.fromJson(Map<String, dynamic> json) {
    return FinishTripResponse(
      FinishedTripDataResponse.fromJson(json["finished_order"]),
    );
  }
}

class FinishedTripDataResponse {
  int? id;
  int? userId;
  String? reservedSeats;
  String? distance;
  String? price;
  String? status;
  String? updatedAt;
  num? total;

  FinishedTripDataResponse({
    this.id,
    this.userId,
    this.reservedSeats,
    this.distance,
    this.price,
    this.status,
    this.updatedAt,
    this.total,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "reserved_seats": reservedSeats,
        "distance": distance,
        "price": price,
        "status": status,
        "updated_at": updatedAt,
        "total": total,
      };

  factory FinishedTripDataResponse.fromJson(Map<String, dynamic> json) {
    return FinishedTripDataResponse(
      id: json["id"] ?? 0,
      userId: json["user_id"] ?? 0,
      reservedSeats: json["reserved_seats"] ?? '',
      distance: json["distance"] ?? '',
      price: json["price"] ?? '',
      status: json["status"] ?? '',
      updatedAt: json["updated_at"] ?? '',
      total: json["total"] ?? 0.0,
    );
  }
}
