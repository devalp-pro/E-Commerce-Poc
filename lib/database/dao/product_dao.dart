import 'package:e_commerce_poc/bean/category_bean.dart';
import 'package:e_commerce_poc/bean/data_bean.dart';
import 'package:e_commerce_poc/bean/product_bean.dart';
import 'package:e_commerce_poc/bean/variant_bean.dart';
import 'package:e_commerce_poc/database/app_database.dart';
import 'package:e_commerce_poc/database/model/filter_value.dart';
import 'package:e_commerce_poc/database/model/product_with_details.dart';
import 'package:e_commerce_poc/database/model/products.dart';
import 'package:e_commerce_poc/database/model/rankings.dart';
import 'package:e_commerce_poc/database/model/variants.dart';
import 'package:moor/moor.dart';

part 'product_dao.g.dart';

@UseDao(tables: [Products, Rankings, Variants])
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

  Stream<List<Product>> getProductsByCategoryIdBySortAndFilters(int catId, String sortBy, Map<String, List<FilterValue>> filters) {
    String joins = "Inner Join rankings on rankings.product_id = products.id";
    String where = "WHERE products.cat_id = $catId";
    if (filters.length > 0) {
      bool containsFilter = false;
      filters.forEach((key, value) {
        if (value.length > 0) {
          containsFilter = true;
          return;
        }
      });
      if (containsFilter) joins += " Inner Join variants on variants.product_id = products.id";
      filters.keys.forEach((key) {
        if (key == 'Colors') {
          int colorListLength = filters[key].length;
          if (colorListLength > 0) where += " and ( ";
          filters[key].asMap().forEach((key, colorValue) {
            if (key == 0 && key < colorListLength - 1)
              where += " variants.color = '${colorValue.name}' or";
            else if (key < colorListLength - 1)
              where += " variants.color = '${colorValue.name}' or";
            else if (key == colorListLength - 1) where += " variants.color = '${colorValue.name}'";
          });
          if (colorListLength > 0) where += " )";
        } else if (key == 'Size') {
          int sizeListLength = filters[key].length;
          if (sizeListLength > 0) where += " and ( ";
          filters[key].asMap().forEach((key, sizeValue) {
            if (key == 0 && key < sizeListLength - 1)
              where += " variants.size = '${sizeValue.name}' or";
            else if (key < sizeListLength - 1)
              where += " variants.size = '${sizeValue.name}' or";
            else if (key == sizeListLength - 1) where += " variants.size = '${sizeValue.name}'";
          });
          if (sizeListLength > 0) where += " )";
        }
      });
    }

    String orderBy = "ORDER BY " +
        (sortBy == "Most Viewed"
            ? "rankings.view_count DESC"
            : sortBy == "Most Ordered" ? "rankings.order_count DESC" : sortBy == "Most Shared" ? "rankings.shared_count DESC" : "products.name");

    String query = 'SELECT products.* FROM products $joins $where $orderBy';
    return customSelect(
      query,
    ).map((raws) {
      return Product.fromJson(raws.data);
    }).watch();
  }

  Future<ProductWithDetails> getProductWithDetail(int prodId) async {
    Product product = await (select(products)..where((tbl) => tbl.id.equals(prodId))).getSingle();

    List<Variant> colorVariantList = await (select(products).join([innerJoin(variants, variants.productId.equalsExp(products.id))])
          ..where(products.id.equals(prodId))
          ..groupBy([variants.color]))
        .map((rawData) => rawData.readTable(variants))
        .get();

    return ProductWithDetails(product: product, colorVariants: colorVariantList);
  }

  Stream<List<Variant>> getProductSizeVariantByColor(int prodId, String color) {
    return (select(products).join([innerJoin(variants, variants.productId.equalsExp(products.id))])
          ..where(products.id.equals(prodId))
          ..where(variants.color.equals(color))
          ..groupBy([variants.size]))
        .map((rawData) => rawData.readTable(variants))
        .watch();
  }

//  Stream<List<Product>> getProductsByCategoryIdAndMostViewed(int catId) {
//    return customSelect(
//      'SELECT * FROM products Inner Join rankings on rankings.product_id = products.id WHERE products.cat_id = $catId ORDER BY rankings.view_count DESC',
//    ).map((raws) {
//      return Product.fromJson(raws.data);
//    }).watch();
//  }
//
//  Stream<List<Product>> getProductsByCategoryIdAndMostOrdered(int catId) {
//    return customSelect(
//      'SELECT * FROM products Inner Join rankings on rankings.product_id = products.id WHERE products.cat_id = $catId ORDER BY rankings.order_count DESC',
//    ).map((raws) {
//      return Product.fromJson(raws.data);
//    }).watch();
//  }
//
//  Stream<List<Product>> getProductsByCategoryIdAndMostShared(int catId) {
//    return customSelect(
//      'SELECT * FROM products Inner Join rankings on rankings.product_id = products.id WHERE products.cat_id = $catId ORDER BY rankings.shared_count DESC',
//    ).map((raws) {
//      return Product.fromJson(raws.data);
//    }).watch();
//  }

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

            await into(products).insertOnConflictUpdate(productsCompanion);
            if (productsBean.variants != null && productsBean.variants.length > 0) {
              for (VariantBean variantBean in productsBean.variants) {
                await appDatabase.variantDao.insertVariant(variantBean, productsBean.id);
              }
            }
          }
        }
      }
    });
  }
}
