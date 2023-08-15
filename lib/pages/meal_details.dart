import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/saved_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetailsPage extends ConsumerWidget {
  const MealDetailsPage(
    this.meal, {
    super.key,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedMeals = ref.watch(savedProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
          overflow: TextOverflow.visible,
          softWrap: true,
        ),
        actions: [
          IconButton(
            onPressed: () {
              var result =
                  ref.read(savedProvider.notifier).toggleMealSavedStatus(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(result ? 'Saved' : 'Unsaved'),
                ),
              );
            },
            icon: savedMeals.contains(meal)
                ? const Icon(Icons.bookmark)
                : const Icon(Icons.bookmark_border),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Ingridients',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white),
            ),
            const SizedBox(
              height: 14,
            ),
            Text(meal.ingredients.join(', ')),
            Text(
              'Steps',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white),
            ),
            const SizedBox(
              height: 14,
            ),
            ...meal.steps.map(
              (step) => Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${meal.steps.indexOf(step) + 1}. $step',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
