import 'package:e_commerce_poc/database/model/categories_with_sub_category.dart';
import 'package:flutter/material.dart';

class AppNavigation extends StatefulWidget {
  final List<CategoriesWithSubCategory> homeMenu;

  const AppNavigation(this.homeMenu, {Key key}) : super(key: key);

  @override
  _AppNavigationState createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  List<CategoriesWithSubCategory> get menu => widget.homeMenu;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text('devalp.pro@gmail.com'),
            accountName: Text('Deval Patel'),
            currentAccountPicture: Icon(
              Icons.account_circle,
              size: 80,
              color: Colors.amber,
            ),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
          ),
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                menu[index].isExpanded = !isExpanded;
              });
            },
            children: menu.map<ExpansionPanel>((CategoriesWithSubCategory category) {
              return ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(category.categories.name),
                    );
                  },
                  body: Column(
                    children: category.subCategory.length > 0
                        ? category.subCategory.map<ListTile>((subCat) {
                            return ListTile(
                              title: Text(subCat.categories.name),
                            );
                          }).toList()
                        : ListTile(
                            title: Text(category.categories.name),
                          ),
                  ),
                  isExpanded: category.isExpanded);
            }).toList(),
          )
        ],
      ),
    );
  }
}
