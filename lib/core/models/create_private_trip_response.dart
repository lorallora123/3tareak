class CreatePrivateTripResponse {
  final String? fromPlace;
  final String? toPlace;
  final String? distance;
  final String? startedAt;
  final int? seatNumber;
  final int? total;
  final int? cost;
  final int? companyProfit;
  final int? captinProfit;
  final String? updatedAt;
  final String? createdAt;
  final int? id;

  CreatePrivateTripResponse({
    this.fromPlace,
    this.toPlace,
    this.distance,
    this.startedAt,
    this.seatNumber,
    this.total,
    this.cost,
    this.companyProfit,
    this.captinProfit,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory CreatePrivateTripResponse.fromJson(Map<String, dynamic> json) {
    return CreatePrivateTripResponse(
      fromPlace: json['from_place'] as String?,
      toPlace: json['to_place'] as String?,
      distance: json['distance'] as String?,
      startedAt: json['started_at'] as String?,
      seatNumber: json['seat_number'] as int?,
      total: json['total'] as int?,
      cost: json['cost'] as int?,
      companyProfit: json['company_profit'] as int?,
      captinProfit: json['captin_profit'] as int?,
      updatedAt: json['updated_at'] as String?,
      createdAt: json['created_at'] as String?,
      id: json['id'] as int?,
    );
  }
}
