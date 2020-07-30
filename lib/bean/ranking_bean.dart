import 'package:e_commerce_poc/bean/product_bean.dart';
import 'package:e_commerce_poc/bean/ranking_product_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ranking_bean.g.dart';

@JsonSerializable(
    fieldRename: FieldRename.snake,
    anyMap: true,
    checked: true,
    disallowUnrecognizedKeys: false,
    nullable: true,
    createFactory: true)
class RankingBean {

  RankingBean();

  @JsonKey(defaultValue: null)
  String ranking;

  @JsonKey(defaultValue: null)
  List<RankingProductBean> products;

  factory RankingBean.fromJson(Map<String, dynamic> json) => _$RankingBeanFromJson(json);

  Map<String, dynamic> toJson() => _$RankingBeanToJson(this);
}