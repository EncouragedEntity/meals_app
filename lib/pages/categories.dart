import 'package:flutter/material.dart';
import 'package:meals_app/pages/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

import '../data/dummy_data.dart';
import '../models/category.dart';
import '../models/meal.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({
    super.key,
    required this.meals,
  });
  final List<Meal> meals;

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      lowerBound: 0, //* Default
      upperBound: 1, //* Default
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final categorizedMeals = widget.meals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MealsPage(
            title: category.title,
            meals: categorizedMeals,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animController,
      child: GridView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onCategoryTap: () {
                _selectCategory(context, category);
              },
            ),
        ],
      ),
      builder: (context, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 0.5),
            end: const Offset(0, 0),
          ).animate(
            CurvedAnimation(
              parent: _animController,
              curve: Curves.easeInOut,
            ),
          ),
          child: child,
        );
      },
    );
  }
}
