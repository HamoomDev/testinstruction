class FoodEntryEntity {
  final String id;
  final String foodName;
  final String foodNameTh;
  final int calories;
  final double proteinG;
  final double carbsG;
  final double fatG;
  final String servingSize;
  final DateTime loggedAt;

  const FoodEntryEntity({
    required this.id,
    required this.foodName,
    required this.foodNameTh,
    required this.calories,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
    required this.servingSize,
    required this.loggedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'foodName': foodName,
        'foodNameTh': foodNameTh,
        'calories': calories,
        'proteinG': proteinG,
        'carbsG': carbsG,
        'fatG': fatG,
        'servingSize': servingSize,
        'loggedAt': loggedAt.toIso8601String(),
      };

  factory FoodEntryEntity.fromJson(Map<String, dynamic> json) {
    return FoodEntryEntity(
      id: json['id'] as String,
      foodName: json['foodName'] as String,
      foodNameTh: json['foodNameTh'] as String? ?? json['foodName'] as String,
      calories: json['calories'] as int,
      proteinG: (json['proteinG'] as num).toDouble(),
      carbsG: (json['carbsG'] as num).toDouble(),
      fatG: (json['fatG'] as num).toDouble(),
      servingSize: json['servingSize'] as String,
      loggedAt: DateTime.parse(json['loggedAt'] as String),
    );
  }
}
