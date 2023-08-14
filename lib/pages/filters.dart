import 'package:flutter/material.dart';

class FiltersPage extends StatefulWidget {
  const FiltersPage({super.key, this.filters});
  final Map<Filter, bool>? filters;

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

enum Filter {
  glutenFree,
  vegan,
  vegeterian,
  lactoseFree,
}

class _FiltersPageState extends State<FiltersPage> {
  bool _glutenFree = false;
  bool _vegan = false;
  bool _vegeterian = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.filters?[Filter.glutenFree] ?? false;
    _vegan = widget.filters?[Filter.vegan] ?? false;
    _vegeterian = widget.filters?[Filter.vegeterian] ?? false;
    _lactoseFree = widget.filters?[Filter.lactoseFree] ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFree,
            Filter.lactoseFree: _lactoseFree,
            Filter.vegan: _vegan,
            Filter.vegeterian: _vegeterian
          });
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenFree,
              onChanged: (value) {
                setState(() {
                  _glutenFree = value;
                });
              },
              title: Text(
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Include only gluten-free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _vegan,
              onChanged: (value) {
                setState(() {
                  _vegan = value;
                });
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Include only vegan meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _vegeterian,
              onChanged: (value) {
                setState(() {
                  _vegeterian = value;
                });
              },
              title: Text(
                'Vegeterian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Include only vegeterian meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _lactoseFree,
              onChanged: (value) {
                setState(() {
                  _lactoseFree = value;
                });
              },
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Include only lactose-free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
