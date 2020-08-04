import 'package:e_commerce_poc/database/app_database.dart';

class ProductWithDetails {
  final Product product;
  final List<Variant> colorVariants;
  final Tax tax;

  ProductWithDetails({this.product, this.colorVariants, this.tax});
}
