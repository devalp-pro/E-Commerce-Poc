import 'package:e_commerce_poc/database/app_database.dart';

class CategoriesWithSubCategory {
  final Category categories;
  final List<CategoriesWithSubCategory> subCategory;
  bool isExpanded = false;

  CategoriesWithSubCategory(this.categories, this.subCategory);


}
