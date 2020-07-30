// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataBean _$DataBeanFromJson(Map json) {
  return $checkedNew('DataBean', json, () {
    final val = DataBean();
    $checkedConvert(
        json,
        'categories',
        (v) => val.categories = (v as List)
            ?.map((e) => e == null
                ? null
                : CategoryBean.fromJson((e as Map)?.map(
                    (k, e) => MapEntry(k as String, e),
                  )))
            ?.toList());
    $checkedConvert(
        json,
        'rankings',
        (v) => val.rankings = (v as List)
            ?.map((e) => e == null
                ? null
                : RankingBean.fromJson((e as Map)?.map(
                    (k, e) => MapEntry(k as String, e),
                  )))
            ?.toList());
    return val;
  });
}

Map<String, dynamic> _$DataBeanToJson(DataBean instance) => <String, dynamic>{
      'categories': instance.categories,
      'rankings': instance.rankings,
    };
