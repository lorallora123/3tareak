class SearchResultModel {
  int? id;
  String? placeId;
  String? name;
  String? type;
  String? img;
  String? fullAddress;
  double? lat;
  double? long;

  SearchResultModel({this.placeId, this.id, this.img, this.fullAddress, this.name, this.type, this.lat, this.long});
}
