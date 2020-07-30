import 'package:e_commerce_poc/bean/category_bean.dart';
import 'package:e_commerce_poc/bean/data_bean.dart';
import 'package:e_commerce_poc/database/app_database.dart';
import 'package:e_commerce_poc/database/model/categories.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'category_dao.g.dart';

@UseDao(tables: [Categories])
class CategoryDao extends DatabaseAccessor<AppDatabase> with _$CategoryDaoMixin {
  final AppDatabase appDatabase;

  CategoryDao(this.appDatabase) : super(appDatabase);

  Future<List<Category>> getParentCategory() => (select(categories)..where((tbl) => isNull(tbl.parentId))).get();

  Future<List<Category>> getCategoryWithSubCategory() {
    final subCategory = alias(categories, 'subCategory');
    return (select(categories)
          ..join([innerJoin(subCategory, subCategory.parentId.equalsExp(categories.id))])
          ..where((tbl) => isNull(tbl.parentId)))
        .get();
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
          await into(categories).insert(categoriesCompanion);
        } catch (ex) {
          update(categories).replace(categoriesCompanion);
        }
      }
    });
  }
}
