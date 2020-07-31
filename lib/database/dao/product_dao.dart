import 'package:e_commerce_poc/bean/category_bean.dart';
import 'package:e_commerce_poc/bean/data_bean.dart';
import 'package:e_commerce_poc/bean/product_bean.dart';
import 'package:e_commerce_poc/database/app_database.dart';
import 'package:e_commerce_poc/database/model/products.dart';
import 'package:e_commerce_poc/database/model/rankings.dart';
import 'package:moor/moor.dart';

part 'product_dao.g.dart';

@UseDao(tables: [Products, Rankings])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  final AppDatabase appDatabase;

  ProductDao(this.appDatabase) : super(appDatabase);

  Stream<List<Product>> getProductsByCategoryId(int catId, String sortByValue) {
    if (sortByValue == 'Name')
      return (select(products)
            ..orderBy([(tbl) => OrderingTerm(expression: tbl.name, mode: OrderingMode.asc)])
            ..where((tbl) => tbl.catId.equals(catId)))
          .watch();
    else if (sortByValue == 'Most Viewed')
      return (select(products)
            ..join([innerJoin(products, products.id.equalsExp(rankings.productId))])
            ..orderBy([(tbl) => OrderingTerm(expression: tbl.name, mode: OrderingMode.asc)])
            ..where((tbl) => tbl.catId.equals(catId)))
          .watch();
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
