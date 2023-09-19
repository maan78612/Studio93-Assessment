class FoodItems {
  String? id;
  String? name;
  double? calories;

  FoodItems({
    required this.id,
    required this.name,
    required this.calories,
  });

  FoodItems.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    calories = json["calories"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["calories"] = calories;

    return map;
  }
}
