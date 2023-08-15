import 'package:flutter/material.dart';
import 'package:meals_app/pages/categories.dart';
import 'package:meals_app/pages/filters.dart';
import 'package:meals_app/pages/meals.dart';
import 'package:meals_app/riverpod/saved_provider.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../riverpod/filters_provider.dart';

class TabsPage extends ConsumerStatefulWidget {
  const TabsPage({super.key});

  @override
  ConsumerState<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends ConsumerState<TabsPage> {
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void setDrawerPage(String id) async {
    Navigator.of(context).pop();

    switch (id) {
      case 'filters':
        {
          await Navigator.of(context).push<Map<Filter, bool>>(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const FiltersPage();
              },
            ),
          );
        }
        break;
      default:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesPage(
      meals: filteredMeals,
    );

    String selectedPageTitle = 'Categories';
    switch (_selectedPageIndex) {
      case 1:
        selectedPageTitle = 'Saved';
        activePage = MealsPage(
          meals: ref.watch(savedProvider),
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
