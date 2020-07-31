import 'package:e_commerce_poc/bean/category_bean.dart';
import 'package:e_commerce_poc/bean/data_bean.dart';
import 'package:e_commerce_poc/bean/product_bean.dart';
import 'package:e_commerce_poc/database/app_database.dart';
import 'package:e_commerce_poc/database/model/products.dart';
import 'package:e_commerce_poc/database/model/rankings.dart';
import 'package:flutter/cupertino.dart';
import 'package:moor/moor.dart';

part 'product_dao.g.dart';

@UseDao(tables: [Products, Rankings])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  final AppDatabase appDatabase;

  ProductDao(this.appDatabase) : super(appDatabase);

  Stream<List<Product>> getProductsByCategoryId(int catId) {
    return (select(products)..where((tbl) => tbl.catId.equals(catId))).watch();
  }

  Stream<List<Product>> getProductsByCategoryIdAndName(int catId) {
    return (select(products)
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.name, mode: OrderingMode.asc)])
          ..where((tbl) => tbl.catId.equals(catId)))
        .watch();
  }

  Stream<List<Product>> getProductsByCategoryIdAndMostViewed(int catId) {
    return customSelect(
      'SELECT * FROM products Inner Join rankings on rankings.product_id = products.id WHERE products.cat_id = $catId ORDER BY rankings.view_count DESC',
    ).map((raws) {
      return Product.fromJson(raws.data);
    }).watch();
  }

  Stream<List<Product>> getProductsByCategoryIdAndMostOrdered(int catId) {
    return customSelect(
      'SELECT * FROM products Inner Join rankings on rankings.product_id = products.id WHERE products.cat_id = $catId ORDER BY rankings.order_count DESC',
    ).map((raws) {
      return Product.fromJson(raws.data);
    }).watch();
  }

  Stream<List<Product>> getProductsByCategoryIdAndMostShared(int catId) {
    return customSelect(
      'SELECT * FROM products Inner Join rankings on rankings.product_id = products.id WHERE products.cat_id = $catId ORDER BY rankings.shared_count DESC',
    ).map((raws) {
      return Product.fromJson(raws.data);
    }).watch();
  }

  Future<void> insertAllProducts(DataBean appData) {
    return transaction(() async {
      for (CategoryBean categoryBean in appData.categories) {
        if (categoryBean.products.isNotEmpty) {
          for (ProductsBean productsBean in categoryBean.products) {

            ProductsCompanion productsCompanion = ProductsCompanion(
                id: Value(productsBean.id),
                name: Value(productsBean.name),
                dateAdded: Value(DateTime.parse(productsBean.dateAdded)),
                catId: Value(categoryBean.id));
            try {
              await into(products).insertOnConflictUpdate(productsCompanion);
            } catch (ex) {
              update(products).replace(productsCompanion);
            }
          }
        }
      }
    });
  }
}
