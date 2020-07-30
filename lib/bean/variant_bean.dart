import 'package:json_annotation/json_annotation.dart';

part 'variant_bean.g.dart';

@JsonSerializable(
    fieldRename: FieldRename.snake,
    anyMap: true,
    checked: true,
    disallowUnrecognizedKeys: false,
    nullable: true,
    createFactory: true)
class VariantBean {

  VariantBean();

  @JsonKey(defaultValue: 0)
  int id;

  @JsonKey(defaultValue: null)
  String color;

  @JsonKey(defaultValue: 0)
  int size;

  @JsonKey(defaultValue: 0)
  int price;

  factory VariantBean.fromJson(Map<String, dynamic> json) => _$VariantBeanFromJson(json);

  Map<String, dynamic> toJson() => _$VariantBeanToJson(this);
}