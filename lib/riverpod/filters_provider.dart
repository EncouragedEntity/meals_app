import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'meals_provider.dart';

enum Filter {
  glutenFree,
  vegan,
  vegeterian,
  lactoseFree,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegan: false,
          Filter.vegeterian: false,
        });

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }

  void setFilters(Map<Filter, bool> filters) {
    state = filters;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

final filteredMealsProvider = Provider((ref) {
  return ref.watch(mealsProvider).where((meal) {
    if (ref.watch(filtersProvider)[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (ref.watch(filtersProvider)[Filter.lactoseFree]! &&
        !meal.isLactoseFree) {
      return false;
    }
    if (ref.watch(filtersProvider)[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    if (ref.watch(filtersProvider)[Filter.vegeterian]! && !meal.isVegetarian) {
      return false;
    }
    return true;
  }).toList();
});
