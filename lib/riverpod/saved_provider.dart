import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class SavedMealsNotifier extends StateNotifier<List<Meal>> {
  SavedMealsNotifier() : super([]);
  bool toggleMealSavedStatus(Meal meal) {
    final isSaved = state.contains(meal);

    if (isSaved) {
      state = state.where((mealItem) => mealItem.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final savedProvider = StateNotifierProvider<SavedMealsNotifier, List<Meal>>(
    (ref) => SavedMealsNotifier());
