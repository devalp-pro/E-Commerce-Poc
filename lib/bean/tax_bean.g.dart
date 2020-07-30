// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaxBean _$TaxBeanFromJson(Map json) {
  return $checkedNew('TaxBean', json, () {
    final val = TaxBean();
    $checkedConvert(json, 'name', (v) => val.name = v as String);
    $checkedConvert(
        json, 'value', (v) => val.value = (v as num)?.toDouble() ?? 0);
    return val;
  });
}

Map<String, dynamic> _$TaxBeanToJson(TaxBean instance) => <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
    };
