import 'package:e_commerce_poc/bean/category_bean.dart';
import 'package:e_commerce_poc/bean/data_bean.dart';
import 'package:e_commerce_poc/database/app_database.dart';
import 'package:e_commerce_poc/database/model/categories.dart';
import 'package:e_commerce_poc/database/model/categories_with_sub_category.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'category_dao.g.dart';

@UseDao(tables: [Categories])
class CategoryDao extends DatabaseAccessor<AppDatabase> with _$CategoryDaoMixin {
  final AppDatabase appDatabase;

  CategoryDao(this.appDatabase) : super(appDatabase);

  Future<List<Category>> getParentCategory() => (select(categories)..where((tbl) => isNull(tbl.parentId))).get();

  Future<List<CategoriesWithSubCategory>> getCategoryWithSubCategory() async {
    final parentCatList = await (select(categories)..where((tbl) => isNull(tbl.parentId))).get();

    final List<CategoriesWithSubCategory> categoryWithSubCatList = List();
    for (Category category in parentCatList) {
      categoryWithSubCatList.add(await _getSubCategory(category));
    }
    return categoryWithSubCatList;
  }

  Future<List<CategoriesWithSubCategory>> getCategoryById(int id) async {
    final parentCatList = await (select(categories)..where((tbl) => tbl.id.equals(id))).get();

    final List<CategoriesWithSubCategory> categoryWithSubCatList = List();
    for (Category category in parentCatList) {
      categoryWithSubCatList.add(await _getSubCategory(category));
    }
    return categoryWithSubCatList;
  }

  Future<CategoriesWithSubCategory> _getSubCategory(Category category) async {
    final subCategory = await (select(categories)..where((tbl) => tbl.parentId.equals(category.id))).get();
    final List<CategoriesWithSubCategory> categoryWithSubCatList = List();
    for (Category subCat in subCategory) {
      if (subCat.parentId != null) {
        categoryWithSubCatList.add(await _getSubCategory(subCat));
      } else {
        return CategoriesWithSubCategory(subCat, categoryWithSubCatList);
      }
    }
    return CategoriesWithSubCategory(category, categoryWithSubCatList);
  }

  Future<void> insertAllCategory(DataBean appData) {
    return transaction(() async {
      for (CategoryBean category in appData.categories) {
        CategoriesCompanion categoriesCompanion;
        CategoryBean categoryBean = appData.categories
            .singleWhere((cat) => cat.childCategories.singleWhere((childId) => childId == category.id, orElse: () => -1) != -1, orElse: () => null);
        if (categoryBean != null) {
          categoriesCompanion = CategoriesCompanion(id: Value(category.id), name: Value(category.name), parentId: Value(categoryBean.id));
        } else {
          categoriesCompanion = CategoriesCompanion(id: Value(category.id), name: Value(category.name));
        }
        try {
          await into(categories).insertOnConflictUpdate(categoriesCompanion);
        } catch (ex) {
          update(categories).replace(categoriesCompanion);
        }
      }
    });
  }
}
