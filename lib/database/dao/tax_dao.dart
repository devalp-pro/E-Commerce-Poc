import 'package:e_commerce_poc/database/app_database.dart';
import 'package:e_commerce_poc/database/model/products.dart';
import 'package:e_commerce_poc/database/model/tax.dart';
import 'package:moor/moor.dart';

part 'tax_dao.g.dart';

@UseDao(tables: [ProductTax, Products])
class TaxDao extends DatabaseAccessor<AppDatabase> with _$TaxDaoMixin {
  final AppDatabase appDatabase;

  TaxDao(this.appDatabase) : super(appDatabase);

  Future<Tax> getProductTax(int productId) {
    return (select(productTax).join([innerJoin(products, products.id.equalsExp(productTax.productId))])
          ..where(products.id.equals(productId))
          ..limit(1))
        .map((rawData) => rawData.readTable(productTax))
        .getSingle();
  }
}
