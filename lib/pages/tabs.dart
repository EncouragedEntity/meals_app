import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/pages/categories.dart';
import 'package:meals_app/pages/filters.dart';
import 'package:meals_app/pages/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

import '../models/meal.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _selectedPageIndex = 0;
  final List<Meal> savedMeals = [];
  Map<Filter, bool> filters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegan: false,
    Filter.vegeterian: false,
  };

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void toogleMealSaveStatus(Meal meal) {
    final isSaved = savedMeals.contains(meal);

    setState(() {
      if (isSaved) {
        savedMeals.remove(meal);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Meal unsaved')));
      } else {
        savedMeals.add(meal);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Meal saved')));
      }
    });
  }

  void saveMeal(Meal meal) {
    toogleMealSaveStatus(meal);
  }

  void setDrawerPage(String id) async {
    Navigator.of(context).pop();

    switch (id) {
      case 'filters':
        {
          final result = await Navigator.of(context).push<Map<Filter, bool>>(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return FiltersPage(filters: filters);
              },
            ),
          );

          setState(() {
            if (result != null) filters = result;
          });
        }
        break;
      default:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredMeals = dummyMeals.where((meal) {
      if (filters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (filters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (filters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (filters[Filter.vegeterian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesPage(
      onMealSave: toogleMealSaveStatus,
      meals: filteredMeals,
    );

    String selectedPageTitle = 'Categories';
    switch (_selectedPageIndex) {
      case 1:
        selectedPageTitle = 'Saved';
        activePage = MealsPage(
          meals: savedMeals,
          onMealSave: toogleMealSaveStatus,
        );
        break;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPageTitle),
      ),
      body: activePage,
      drawer: MainDrawer(onSelectPage: setDrawerPage),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width / 2,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
            label: 'Categories',
            icon: Icon(Icons.category),
          ),
          BottomNavigationBarItem(
            label: 'Saved',
            icon: Icon(Icons.bookmark),
          ),
        ],
      ),
    );
  }
}
