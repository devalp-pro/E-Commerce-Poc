// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryBean _$CategoryBeanFromJson(Map json) {
  return $checkedNew('CategoryBean', json, () {
    final val = CategoryBean();
    $checkedConvert(json, 'id', (v) => val.id = v as int ?? 0);
    $checkedConvert(json, 'name', (v) => val.name = v as String);
    $checkedConvert(
        json,
        'products',
        (v) => val.products = (v as List)
            ?.map((e) => e == null
                ? null
                : ProductsBean.fromJson((e as Map)?.map(
                    (k, e) => MapEntry(k as String, e),
                  )))
            ?.toList());
    $checkedConvert(
        json,
        'child_categories',
        (v) =>
            val.childCategories = (v as List)?.map((e) => e as int)?.toList());
    return val;
  }, fieldKeyMap: const {'childCategories': 'child_categories'});
}

Map<String, dynamic> _$CategoryBeanToJson(CategoryBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'products': instance.products,
      'child_categories': instance.childCategories,
    };
