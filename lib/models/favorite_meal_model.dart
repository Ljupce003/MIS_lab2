
class FavoriteMealModel {
  final int mealId;

  FavoriteMealModel({required this.mealId});

  Map<String, Object?> toMap() {
    return {'mealId': mealId};
  }

  static FavoriteMealModel fromMap(Map<String, Object?> map) {
    return FavoriteMealModel(mealId: map['mealId'] as int);
  }
}