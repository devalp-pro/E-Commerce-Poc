// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsBean _$ProductsBeanFromJson(Map json) {
  return $checkedNew('ProductsBean', json, () {
    final val = ProductsBean();
    $checkedConvert(json, 'id', (v) => val.id = v as int ?? 0);
    $checkedConvert(json, 'name', (v) => val.name = v as String);
    $checkedConvert(json, 'date_added', (v) => val.dateAdded = v as String);
    $checkedConvert(
        json,
        'variants',
        (v) => val.variants = (v as List)
            ?.map((e) => e == null
                ? null
                : VariantBean.fromJson((e as Map)?.map(
                    (k, e) => MapEntry(k as String, e),
                  )))
            ?.toList());
    $checkedConvert(
        json,
        'tax',
        (v) => val.tax = v == null
            ? null
            : TaxBean.fromJson((v as Map)?.map(
                (k, e) => MapEntry(k as String, e),
              )));
    return val;
  }, fieldKeyMap: const {'dateAdded': 'date_added'});
}

Map<String, dynamic> _$ProductsBeanToJson(ProductsBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date_added': instance.dateAdded,
      'variants': instance.variants,
      'tax': instance.tax,
    };
