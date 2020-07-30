// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking_product_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RankingProductBean _$RankingProductBeanFromJson(Map json) {
  return $checkedNew('RankingProductBean', json, () {
    final val = RankingProductBean();
    $checkedConvert(json, 'id', (v) => val.id = v as int ?? 0);
    $checkedConvert(json, 'view_count', (v) => val.viewCount = v as int);
    $checkedConvert(json, 'order_count', (v) => val.orderCount = v as int);
    $checkedConvert(json, 'shares', (v) => val.shares = v as int);
    return val;
  }, fieldKeyMap: const {
    'viewCount': 'view_count',
    'orderCount': 'order_count'
  });
}

Map<String, dynamic> _$RankingProductBeanToJson(RankingProductBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'view_count': instance.viewCount,
      'order_count': instance.orderCount,
      'shares': instance.shares,
    };
