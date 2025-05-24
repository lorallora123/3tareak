class Prediction {
  String? description;
  String? placeId;

  Prediction({
    this.description,
    this.placeId,
  });

  Prediction.fromJson(Map<String, dynamic> json) {
    description = json['description'];

    placeId = json['place_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['place_id'] = placeId;
    return data;
  }
}
