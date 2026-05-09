class FoodAnalysisEntity {
  final String foodName;
  final String foodNameTh;
  final int estimatedCalories;
  final double proteinG;
  final double carbsG;
  final double fatG;
  final String servingSize;
  final String confidence;

  const FoodAnalysisEntity({
    required this.foodName,
    required this.foodNameTh,
    required this.estimatedCalories,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
    required this.servingSize,
    required this.confidence,
  });

  factory FoodAnalysisEntity.fromJson(Map<String, dynamic> json) {
    return FoodAnalysisEntity(
      foodName: json['foodName'] as String? ?? 'Unknown Food',
      foodNameTh: json['foodNameTh'] as String? ?? 'อาหารไม่ทราบชนิด',
      estimatedCalories: (json['estimatedCalories'] as num?)?.toInt() ?? 0,
      proteinG: (json['protein_g'] as num?)?.toDouble() ?? 0.0,
      carbsG: (json['carbs_g'] as num?)?.toDouble() ?? 0.0,
      fatG: (json['fat_g'] as num?)?.toDouble() ?? 0.0,
      servingSize: json['servingSize'] as String? ?? '1 serving',
      confidence: json['confidence'] as String? ?? 'medium',
    );
  }

  Map<String, dynamic> toJson() => {
        'foodName': foodName,
        'foodNameTh': foodNameTh,
        'estimatedCalories': estimatedCalories,
        'protein_g': proteinG,
        'carbs_g': carbsG,
        'fat_g': fatG,
        'servingSize': servingSize,
        'confidence': confidence,
      };
}
