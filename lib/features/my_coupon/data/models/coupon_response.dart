class CouponResponse {
  int? id;
  String? name;
  String? notificationText;
  String? spText;
  String? icon;
  int? maximum;
  int? minimum;
  int? percentage;
  int? fixedValue;
  double chance;
  bool appear;
  bool? active;
  DateTime? createdAt;
  DateTime? updatedAt;

  CouponResponse({
    this.id,
    this.name,
    this.notificationText,
    this.spText,
    this.icon,
    this.maximum,
    this.minimum,
    this.percentage,
    this.fixedValue,
    required this.chance,
    required this.appear,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  factory CouponResponse.fromJson(Map<String, dynamic> json) {
    return CouponResponse(
      id: json['id'],
      name: json['name'],
      notificationText: json['notification_text'],
      spText: json['sp_text'],
      icon: json['icon'],
      maximum: json['maximum'],
      minimum: json['minimum'],
      percentage: json['percentage'],
      fixedValue: json['fixed_value'],
      chance: (json['chance'] as num).toDouble(),
      appear: json['appear'] == 1,
      active: json['active'] == null ? null : json['active'] == 1,
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'notification_text': notificationText,
        'sp_text': spText,
        'icon': icon,
        'maximum': maximum,
        'minimum': minimum,
        'percentage': percentage,
        'fixed_value': fixedValue,
        'chance': chance,
        'appear': appear ? 1 : 0,
        'active': active == null ? null : (active! ? 1 : 0),
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
