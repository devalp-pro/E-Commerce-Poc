import 'package:e_commerce_poc/database/app_database.dart';

class ProductWithDetails {
  final Product product;
  final List<Variant> colorVariants;
  final List<Variant> sizeVariants;

  ProductWithDetails({this.product, this.colorVariants, this.sizeVariants});
}
