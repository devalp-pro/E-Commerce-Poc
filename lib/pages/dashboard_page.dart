import 'package:e_commerce_poc/components/app_navigation.dart';
import 'package:e_commerce_poc/database/model/categories_with_sub_category.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  final List<Widget> child;
  final List<CategoriesWithSubCategory> homeMenu;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Widget bottomBar;

  const DashboardPage(this.child, this.homeMenu, this.scaffoldKey, this.bottomBar, {Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<CategoriesWithSubCategory> get homeMenu => widget.homeMenu;

  List<Widget> get child => widget.child;

  GlobalKey<ScaffoldState> get _scaffoldKey => widget.scaffoldKey;

  Widget get bottomBar => widget.bottomBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppNavigation(homeMenu),
      body: CustomScrollView(
        slivers: child,
      ),
      bottomNavigationBar: bottomBar,
    );
  }
}

class MyAppBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;

  MyAppBar(this._scaffoldKey);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      pinned: true,
      leading: InkWell(
        splashColor: Colors.lightBlue,
        child: Icon(
          Icons.menu,
          color: Colors.grey,
        ),
        onTap: () => _scaffoldKey.currentState.openDrawer(),
      ),
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Center(
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.only(left: 45),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search Products',
                        hintStyle: TextStyle(
                          color: Colors.blueGrey,
                          height: 1.3,
                        ),
                      ),
                      style: TextStyle(
                        height: 1.3,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: IconButton(
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.of(context).pushNamed('/cart'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
