import 'package:e_commerce_poc/bean/tax_bean.dart';
import 'package:e_commerce_poc/bean/variant_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_bean.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, anyMap: true, checked: true, disallowUnrecognizedKeys: false, nullable: true, createFactory: true)
class ProductsBean {
  ProductsBean();

  @JsonKey(defaultValue: 0)
  int id;

  @JsonKey(defaultValue: null)
  String name;

  @JsonKey(defaultValue: null)
  String dateAdded;

  @JsonKey(defaultValue: null)
  List<VariantBean> variants;

  @JsonKey(defaultValue: null)
  TaxBean tax;

  factory ProductsBean.fromJson(Map<String, dynamic> json) => _$ProductsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsBeanToJson(this);
}
