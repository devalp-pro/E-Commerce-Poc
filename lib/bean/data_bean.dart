import 'package:e_commerce_poc/bean/category_bean.dart';
import 'package:e_commerce_poc/bean/ranking_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_bean.g.dart';

@JsonSerializable(
    fieldRename: FieldRename.snake,
    anyMap: true,
    checked: true,
    disallowUnrecognizedKeys: false,
    nullable: true,
    createFactory: true)
class DataBean {

  DataBean();

  @JsonKey(defaultValue: null)
  List<CategoryBean> categories;

  @JsonKey(defaultValue: null)
  List<RankingBean> rankings;

  factory DataBean.fromJson(Map<String, dynamic> json) => _$DataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DataBeanToJson(this);
}
