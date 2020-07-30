import 'package:e_commerce_poc/bean/category_bean.dart';
import 'package:e_commerce_poc/bean/data_bean.dart';
import 'package:e_commerce_poc/bean/product_bean.dart';
import 'package:e_commerce_poc/database/app_database.dart';
import 'package:e_commerce_poc/database/model/products.dart';
import 'package:moor/moor.dart';

part 'product_dao.g.dart';

@UseDao(tables: [Products])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  final AppDatabase appDatabase;

  ProductDao(this.appDatabase) : super(appDatabase);

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
              await into(products).insert(productsCompanion);
            } catch (ex) {
              update(products).replace(productsCompanion);
            }
          }
        }
      }
    });
  }
}
