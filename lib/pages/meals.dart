import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/pages/meal_details.dart';

import '../widgets/meal_item.dart';

class MealsPage extends StatelessWidget {
  const MealsPage({
    super.key,
    this.title,
    required this.meals,
    required this.onMealSave,
  });

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onMealSave;

  void _showMealDeteails(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) {
        return MealDetailsPage(
          meal,
          onMealSave: onMealSave,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = meals.isEmpty
        ? Center(
            child: Text(
              'No meals here',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          )
        : ListView.builder(
            itemCount: meals.length,
            itemBuilder: ((context, index) => MealItem(
                  meal: meals[index],
                  onSelectMeal: (meal) {
                    _showMealDeteails(context, meal);
                  },
                )),
          );

    if (title != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: content,
      );
    } else {
      return content;
    }
  }
}
