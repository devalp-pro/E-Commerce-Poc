import 'package:json_annotation/json_annotation.dart';

part 'tax_bean.g.dart';

@JsonSerializable(
    fieldRename: FieldRename.snake,
    anyMap: true,
    checked: true,
    disallowUnrecognizedKeys: false,
    nullable: true,
    createFactory: true)
class TaxBean {

  TaxBean();

  @JsonKey(defaultValue: null)
  String name;

  @JsonKey(defaultValue: 0)
  double value;

  factory TaxBean.fromJson(Map<String, dynamic> json) => _$TaxBeanFromJson(json);

  Map<String, dynamic> toJson() => _$TaxBeanToJson(this);
}