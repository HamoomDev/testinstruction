class UserProfileEntity {
  final String name;
  final bool isMale;
  final int age;
  final double heightCm;
  final double weightKg;
  final double targetWeightKg;
  final String activityLevel;

  const UserProfileEntity({
    required this.name,
    required this.isMale,
    required this.age,
    required this.heightCm,
    required this.weightKg,
    required this.targetWeightKg,
    required this.activityLevel,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'isMale': isMale,
        'age': age,
        'heightCm': heightCm,
        'weightKg': weightKg,
        'targetWeightKg': targetWeightKg,
        'activityLevel': activityLevel,
      };

  factory UserProfileEntity.fromJson(Map<String, dynamic> json) {
    return UserProfileEntity(
      name: json['name'] as String,
      isMale: json['isMale'] as bool,
      age: json['age'] as int,
      heightCm: (json['heightCm'] as num).toDouble(),
      weightKg: (json['weightKg'] as num).toDouble(),
      targetWeightKg: (json['targetWeightKg'] as num).toDouble(),
      activityLevel: json['activityLevel'] as String,
    );
  }
}
