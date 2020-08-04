import 'package:e_commerce_poc/bean/category_bean.dart';
import 'package:e_commerce_poc/bean/data_bean.dart';
import 'package:e_commerce_poc/bean/product_bean.dart';
import 'package:e_commerce_poc/bean/ranking_bean.dart';
import 'package:e_commerce_poc/bean/ranking_product_bean.dart';
import 'package:e_commerce_poc/bean/variant_bean.dart';
import 'package:e_commerce_poc/database/dao/category_dao.dart';
import 'package:e_commerce_poc/database/dao/product_dao.dart';
import 'package:e_commerce_poc/database/dao/ranking_dao.dart';
import 'package:e_commerce_poc/database/dao/tax_dao.dart';
import 'package:e_commerce_poc/database/dao/variant_dao.dart';
import 'package:e_commerce_poc/database/model/categories.dart';
import 'package:e_commerce_poc/database/model/products.dart';
import 'package:e_commerce_poc/database/model/rankings.dart';
import 'package:e_commerce_poc/database/model/tax.dart';
import 'package:e_commerce_poc/database/model/variants.dart';
import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'app_database.g.dart';

@UseMoor(tables: [Categories, Products, Rankings, Variants, ProductTax], daos: [CategoryDao, ProductDao, RankingDao, VariantDao, TaxDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'app.sqlite', logStatements: true));

  @override
  int get schemaVersion => 4;

  MigrationStrategy get migration => MigrationStrategy(onCreate: (Migrator migrator) {
        return migrator.createAll();
      }, onUpgrade: (Migrator migrator, int from, int to) async {
        if (from == 1) {
          await migrator.createTable(rankings);
        } else if (from == 2) {
          await migrator.createTable(variants);
        } else if (from == 3) {
          await migrator.createTable(productTax);
        }
      });

  Future<void> insertAllData(DataBean appData) {
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
        await into(categories).insertOnConflictUpdate(categoriesCompanion);

        if (category.products.isNotEmpty) {
          for (ProductsBean productsBean in category.products) {
            ProductsCompanion productsCompanion = ProductsCompanion(
                id: Value(productsBean.id),
                name: Value(productsBean.name),
                dateAdded: Value(DateTime.parse(productsBean.dateAdded)),
                catId: Value(category.id));

            await into(products).insertOnConflictUpdate(productsCompanion);

            if (productsBean.variants != null && productsBean.variants.length > 0) {
              for (VariantBean variantBean in productsBean.variants) {
                await variantDao.insertVariant(variantBean, productsBean.id);
              }
            }

            if (productsBean.tax != null) {
              ProductTaxCompanion productTaxCompanion =
                  ProductTaxCompanion(name: Value(productsBean.tax.name), value: Value(productsBean.tax.value), productId: Value(productsBean.id));
              await into(productTax).insertOnConflictUpdate(productTaxCompanion);
            }
          }
        }
      }

      for (RankingBean rankingBean in appData.rankings) {
        if (rankingBean.products.isNotEmpty) {
          for (RankingProductBean productsBean in rankingBean.products) {
            Ranking ranking = await (select(rankings)..where((tbl) => tbl.productId.equals(productsBean.id))).getSingle();
            RankingsCompanion rankingsCompanion;
            if (ranking != null) {
              rankingsCompanion = ranking.toCompanion(false);
              if (productsBean.orderCount != null) {
                rankingsCompanion = rankingsCompanion.copyWith(orderCount: Value(productsBean.orderCount));
              } else if (productsBean.shares != null) {
                rankingsCompanion = rankingsCompanion.copyWith(sharedCount: Value(productsBean.shares));
              }
            } else {
              rankingsCompanion = RankingsCompanion(
                  viewCount: Value(productsBean.viewCount),
                  orderCount: Value(productsBean.orderCount),
                  sharedCount: Value(productsBean.shares),
                  productId: Value(productsBean.id));
            }
            await into(rankings).insertOnConflictUpdate(rankingsCompanion);
          }
        }
      }
    });
  }
}
