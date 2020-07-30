// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariantBean _$VariantBeanFromJson(Map json) {
  return $checkedNew('VariantBean', json, () {
    final val = VariantBean();
    $checkedConvert(json, 'id', (v) => val.id = v as int ?? 0);
    $checkedConvert(json, 'color', (v) => val.color = v as String);
    $checkedConvert(json, 'size', (v) => val.size = v as int ?? 0);
    $checkedConvert(json, 'price', (v) => val.price = v as int ?? 0);
    return val;
  });
}

Map<String, dynamic> _$VariantBeanToJson(VariantBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'color': instance.color,
      'size': instance.size,
      'price': instance.price,
    };
