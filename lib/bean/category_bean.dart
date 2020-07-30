import 'package:e_commerce_poc/bean/product_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_bean.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, anyMap: true, checked: true, disallowUnrecognizedKeys: false, nullable: true, createFactory: true)
class CategoryBean {
  CategoryBean();

  @JsonKey(defaultValue: 0)
  int id;

  @JsonKey(defaultValue: null)
  String name;

  @JsonKey(defaultValue: null)
  List<ProductsBean> products;

  @JsonKey(defaultValue: null)
  List<int> childCategories;

  factory CategoryBean.fromJson(Map<String, dynamic> json) => _$CategoryBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryBeanToJson(this);
}
