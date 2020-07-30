// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RankingBean _$RankingBeanFromJson(Map json) {
  return $checkedNew('RankingBean', json, () {
    final val = RankingBean();
    $checkedConvert(json, 'ranking', (v) => val.ranking = v as String);
    $checkedConvert(
        json,
        'products',
        (v) => val.products = (v as List)
            ?.map((e) => e == null
                ? null
                : RankingProductBean.fromJson((e as Map)?.map(
                    (k, e) => MapEntry(k as String, e),
                  )))
            ?.toList());
    return val;
  });
}

Map<String, dynamic> _$RankingBeanToJson(RankingBean instance) =>
    <String, dynamic>{
      'ranking': instance.ranking,
      'products': instance.products,
    };
