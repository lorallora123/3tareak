class RealEstateOnMap {
  int? id;
  int? userId;
  String? description;
  String? name;
  int? price;
  String? mainPicture;
  bool? isApproved;
  String? purpose;
  bool? isAvailable;
  Address? address;

  RealEstateOnMap(
      {this.id,
      this.userId,
      this.description,
      this.name,
      this.price,
      this.mainPicture,
      this.isApproved,
      this.purpose,
      this.isAvailable,
      this.address});

  RealEstateOnMap.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    description = json['description'];
    name = json['name'];
    price = json['price'];
    mainPicture = json['main_picture'];
    isApproved = json['is_approved'];
    purpose = json['purpose'];
    isAvailable = json['is_available'];
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['description'] = description;
    data['name'] = name;
    data['price'] = price;
    data['main_picture'] = mainPicture;
    data['is_approved'] = isApproved;
    data['purpose'] = purpose;
    data['is_available'] = isAvailable;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    return data;
  }
}

class Address {
  int? id;
  String? addressName;
  int? countryId;
  int? stateId;
  int? userId;
  int? realEstateId;
  String? city;
  String? street;
  double? lat;
  double? long;
  String? type;
  String? createdAt;
  String? updatedAt;

  Address(
      {this.id,
      this.addressName,
      this.countryId,
      this.stateId,
      this.userId,
      this.realEstateId,
      this.city,
      this.street,
      this.lat,
      this.long,
      this.type,
      this.createdAt,
      this.updatedAt});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressName = json['address_name'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    userId = json['user_id'];
    realEstateId = json['real_estate_id'];
    city = json['city'];
    street = json['street'];
    lat = json['lat'];
    long = json['long'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address_name'] = addressName;
    data['country_id'] = countryId;
    data['state_id'] = stateId;
    data['user_id'] = userId;
    data['real_estate_id'] = realEstateId;
    data['city'] = city;
    data['street'] = street;
    data['lat'] = lat;
    data['long'] = long;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
