import 'package:e_commerce_poc/bean/variant_bean.dart';
import 'package:e_commerce_poc/database/app_database.dart';
import 'package:e_commerce_poc/database/model/filter_type.dart';
import 'package:e_commerce_poc/database/model/filter_value.dart';
import 'package:e_commerce_poc/database/model/variants.dart';
import 'package:moor/moor.dart';

part 'variant_dao.g.dart';

@UseDao(tables: [Variants])
class VariantDao extends DatabaseAccessor<AppDatabase> with _$VariantDaoMixin {
  final AppDatabase appDatabase;

  VariantDao(this.appDatabase) : super(appDatabase);

  Future<void> insertVariant(VariantBean variantBean, int productId) {
    return into(variants).insertOnConflictUpdate(
        Variant(id: variantBean.id, color: variantBean.color, size: variantBean.size, price: variantBean.price, productId: productId));
  }

  Future<Map<FilterType, List<FilterValue>>> getFiltersByCategory(int catId) async {
    Map<FilterType, List<FilterValue>> mapFilter = Map();
    List<FilterValue> colorFilter = await customSelect(
            'SELECT variants.color, count(variants.id) as count FROM variants Inner Join products on products.id = variants.product_id INNER Join categories on categories.id = products.cat_id WHERE categories.id = $catId GROUP By variants.color')
        .map((raw) => FilterValue(raw.data['color'], raw.data['count']))
        .get();
    mapFilter[FilterType('Colors')] = colorFilter;
    List<FilterValue> sizeFilter = await customSelect(
            'SELECT variants.size, count(variants.id) as count FROM variants Inner Join products on products.id = variants.product_id INNER Join categories on categories.id = products.cat_id WHERE categories.id = $catId GROUP By variants.size')
        .map((raw) => FilterValue(raw.data['size'].toString(), raw.data['count']))
        .get();
    mapFilter[FilterType('Size')] = sizeFilter;
    return mapFilter;
  }
}
