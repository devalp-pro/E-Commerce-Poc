import 'package:e_commerce_poc/database/app_database.dart';
import 'package:e_commerce_poc/database/model/categories.dart';

class CategoriesWithSubCategory {
  Category categories;
  List<Category> subCategory;

  CategoriesWithSubCategory(this.categories, this.subCategory);
}
