import 'package:json_annotation/json_annotation.dart';

part 'ranking_product_bean.g.dart';

@JsonSerializable(
    fieldRename: FieldRename.snake,
    anyMap: true,
    checked: true,
    disallowUnrecognizedKeys: false,
    nullable: true,
    createFactory: true)
class RankingProductBean {

  RankingProductBean();

  @JsonKey(defaultValue: 0)
  int id;

  @JsonKey(defaultValue: null)
  int viewCount;

  @JsonKey(defaultValue: null)
  int orderCount;

  @JsonKey(defaultValue: null)
  int shares;

  factory RankingProductBean.fromJson(Map<String, dynamic> json) => _$RankingProductBeanFromJson(json);

  Map<String, dynamic> toJson() => _$RankingProductBeanToJson(this);
}