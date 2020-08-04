// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String name;
  final int parentId;
  Category({@required this.id, @required this.name, this.parentId});
  factory Category.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Category(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      parentId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}parent_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
    }
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      parentId: serializer.fromJson<int>(json['parentId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'parentId': serializer.toJson<int>(parentId),
    };
  }

  Category copyWith({int id, String name, int parentId}) => Category(
        id: id ?? this.id,
        name: name ?? this.name,
        parentId: parentId ?? this.parentId,
      );
  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('parentId: $parentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(name.hashCode, parentId.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.parentId == this.parentId);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> parentId;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.parentId = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    this.parentId = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Category> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<int> parentId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (parentId != null) 'parent_id': parentId,
    });
  }

  CategoriesCompanion copyWith(
      {Value<int> id, Value<String> name, Value<int> parentId}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<int>(parentId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('parentId: $parentId')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  final GeneratedDatabase _db;
  final String _alias;
  $CategoriesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _parentIdMeta = const VerificationMeta('parentId');
  GeneratedIntColumn _parentId;
  @override
  GeneratedIntColumn get parentId => _parentId ??= _constructParentId();
  GeneratedIntColumn _constructParentId() {
    return GeneratedIntColumn('parent_id', $tableName, true,
        $customConstraints: 'NULLABLE REFERENCES Category(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, parentId];
  @override
  $CategoriesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'categories';
  @override
  final String actualTableName = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<Category> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id'], _parentIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Category.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(_db, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final int id;
  final String name;
  final DateTime dateAdded;
  final int catId;
  Product(
      {@required this.id,
      @required this.name,
      @required this.dateAdded,
      this.catId});
  factory Product.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Product(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      dateAdded: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}date_added']),
      catId: intType.mapFromDatabaseResponse(data['${effectivePrefix}cat_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || dateAdded != null) {
      map['date_added'] = Variable<DateTime>(dateAdded);
    }
    if (!nullToAbsent || catId != null) {
      map['cat_id'] = Variable<int>(catId);
    }
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      dateAdded: dateAdded == null && nullToAbsent
          ? const Value.absent()
          : Value(dateAdded),
      catId:
          catId == null && nullToAbsent ? const Value.absent() : Value(catId),
    );
  }

  factory Product.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      dateAdded: serializer.fromJson<DateTime>(json['dateAdded']),
      catId: serializer.fromJson<int>(json['catId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'dateAdded': serializer.toJson<DateTime>(dateAdded),
      'catId': serializer.toJson<int>(catId),
    };
  }

  Product copyWith({int id, String name, DateTime dateAdded, int catId}) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        dateAdded: dateAdded ?? this.dateAdded,
        catId: catId ?? this.catId,
      );
  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('dateAdded: $dateAdded, ')
          ..write('catId: $catId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(name.hashCode, $mrjc(dateAdded.hashCode, catId.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.name == this.name &&
          other.dateAdded == this.dateAdded &&
          other.catId == this.catId);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> dateAdded;
  final Value<int> catId;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.dateAdded = const Value.absent(),
    this.catId = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    this.dateAdded = const Value.absent(),
    this.catId = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Product> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<DateTime> dateAdded,
    Expression<int> catId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (dateAdded != null) 'date_added': dateAdded,
      if (catId != null) 'cat_id': catId,
    });
  }

  ProductsCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<DateTime> dateAdded,
      Value<int> catId}) {
    return ProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      dateAdded: dateAdded ?? this.dateAdded,
      catId: catId ?? this.catId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (dateAdded.present) {
      map['date_added'] = Variable<DateTime>(dateAdded.value);
    }
    if (catId.present) {
      map['cat_id'] = Variable<int>(catId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('dateAdded: $dateAdded, ')
          ..write('catId: $catId')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProductsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _dateAddedMeta = const VerificationMeta('dateAdded');
  GeneratedDateTimeColumn _dateAdded;
  @override
  GeneratedDateTimeColumn get dateAdded => _dateAdded ??= _constructDateAdded();
  GeneratedDateTimeColumn _constructDateAdded() {
    return GeneratedDateTimeColumn('date_added', $tableName, false,
        defaultValue: currentDateAndTime);
  }

  final VerificationMeta _catIdMeta = const VerificationMeta('catId');
  GeneratedIntColumn _catId;
  @override
  GeneratedIntColumn get catId => _catId ??= _constructCatId();
  GeneratedIntColumn _constructCatId() {
    return GeneratedIntColumn('cat_id', $tableName, true,
        $customConstraints: 'NULLABLE REFERENCES Category(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, dateAdded, catId];
  @override
  $ProductsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'products';
  @override
  final String actualTableName = 'products';
  @override
  VerificationContext validateIntegrity(Insertable<Product> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('date_added')) {
      context.handle(_dateAddedMeta,
          dateAdded.isAcceptableOrUnknown(data['date_added'], _dateAddedMeta));
    }
    if (data.containsKey('cat_id')) {
      context.handle(
          _catIdMeta, catId.isAcceptableOrUnknown(data['cat_id'], _catIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Product.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(_db, alias);
  }
}

class Ranking extends DataClass implements Insertable<Ranking> {
  final int id;
  final int productId;
  final int viewCount;
  final int orderCount;
  final int sharedCount;
  Ranking(
      {@required this.id,
      @required this.productId,
      this.viewCount,
      this.orderCount,
      this.sharedCount});
  factory Ranking.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return Ranking(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      productId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}product_id']),
      viewCount:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}view_count']),
      orderCount: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}order_count']),
      sharedCount: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}shared_count']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<int>(productId);
    }
    if (!nullToAbsent || viewCount != null) {
      map['view_count'] = Variable<int>(viewCount);
    }
    if (!nullToAbsent || orderCount != null) {
      map['order_count'] = Variable<int>(orderCount);
    }
    if (!nullToAbsent || sharedCount != null) {
      map['shared_count'] = Variable<int>(sharedCount);
    }
    return map;
  }

  RankingsCompanion toCompanion(bool nullToAbsent) {
    return RankingsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      viewCount: viewCount == null && nullToAbsent
          ? const Value.absent()
          : Value(viewCount),
      orderCount: orderCount == null && nullToAbsent
          ? const Value.absent()
          : Value(orderCount),
      sharedCount: sharedCount == null && nullToAbsent
          ? const Value.absent()
          : Value(sharedCount),
    );
  }

  factory Ranking.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Ranking(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      viewCount: serializer.fromJson<int>(json['viewCount']),
      orderCount: serializer.fromJson<int>(json['orderCount']),
      sharedCount: serializer.fromJson<int>(json['sharedCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'viewCount': serializer.toJson<int>(viewCount),
      'orderCount': serializer.toJson<int>(orderCount),
      'sharedCount': serializer.toJson<int>(sharedCount),
    };
  }

  Ranking copyWith(
          {int id,
          int productId,
          int viewCount,
          int orderCount,
          int sharedCount}) =>
      Ranking(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        viewCount: viewCount ?? this.viewCount,
        orderCount: orderCount ?? this.orderCount,
        sharedCount: sharedCount ?? this.sharedCount,
      );
  @override
  String toString() {
    return (StringBuffer('Ranking(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('viewCount: $viewCount, ')
          ..write('orderCount: $orderCount, ')
          ..write('sharedCount: $sharedCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          productId.hashCode,
          $mrjc(viewCount.hashCode,
              $mrjc(orderCount.hashCode, sharedCount.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Ranking &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.viewCount == this.viewCount &&
          other.orderCount == this.orderCount &&
          other.sharedCount == this.sharedCount);
}

class RankingsCompanion extends UpdateCompanion<Ranking> {
  final Value<int> id;
  final Value<int> productId;
  final Value<int> viewCount;
  final Value<int> orderCount;
  final Value<int> sharedCount;
  const RankingsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.viewCount = const Value.absent(),
    this.orderCount = const Value.absent(),
    this.sharedCount = const Value.absent(),
  });
  RankingsCompanion.insert({
    this.id = const Value.absent(),
    @required int productId,
    this.viewCount = const Value.absent(),
    this.orderCount = const Value.absent(),
    this.sharedCount = const Value.absent(),
  }) : productId = Value(productId);
  static Insertable<Ranking> custom({
    Expression<int> id,
    Expression<int> productId,
    Expression<int> viewCount,
    Expression<int> orderCount,
    Expression<int> sharedCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (viewCount != null) 'view_count': viewCount,
      if (orderCount != null) 'order_count': orderCount,
      if (sharedCount != null) 'shared_count': sharedCount,
    });
  }

  RankingsCompanion copyWith(
      {Value<int> id,
      Value<int> productId,
      Value<int> viewCount,
      Value<int> orderCount,
      Value<int> sharedCount}) {
    return RankingsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      viewCount: viewCount ?? this.viewCount,
      orderCount: orderCount ?? this.orderCount,
      sharedCount: sharedCount ?? this.sharedCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (viewCount.present) {
      map['view_count'] = Variable<int>(viewCount.value);
    }
    if (orderCount.present) {
      map['order_count'] = Variable<int>(orderCount.value);
    }
    if (sharedCount.present) {
      map['shared_count'] = Variable<int>(sharedCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RankingsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('viewCount: $viewCount, ')
          ..write('orderCount: $orderCount, ')
          ..write('sharedCount: $sharedCount')
          ..write(')'))
        .toString();
  }
}

class $RankingsTable extends Rankings with TableInfo<$RankingsTable, Ranking> {
  final GeneratedDatabase _db;
  final String _alias;
  $RankingsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  GeneratedIntColumn _productId;
  @override
  GeneratedIntColumn get productId => _productId ??= _constructProductId();
  GeneratedIntColumn _constructProductId() {
    return GeneratedIntColumn('product_id', $tableName, false,
        $customConstraints: 'REFERENCES Product(id)');
  }

  final VerificationMeta _viewCountMeta = const VerificationMeta('viewCount');
  GeneratedIntColumn _viewCount;
  @override
  GeneratedIntColumn get viewCount => _viewCount ??= _constructViewCount();
  GeneratedIntColumn _constructViewCount() {
    return GeneratedIntColumn(
      'view_count',
      $tableName,
      true,
    );
  }

  final VerificationMeta _orderCountMeta = const VerificationMeta('orderCount');
  GeneratedIntColumn _orderCount;
  @override
  GeneratedIntColumn get orderCount => _orderCount ??= _constructOrderCount();
  GeneratedIntColumn _constructOrderCount() {
    return GeneratedIntColumn(
      'order_count',
      $tableName,
      true,
    );
  }

  final VerificationMeta _sharedCountMeta =
      const VerificationMeta('sharedCount');
  GeneratedIntColumn _sharedCount;
  @override
  GeneratedIntColumn get sharedCount =>
      _sharedCount ??= _constructSharedCount();
  GeneratedIntColumn _constructSharedCount() {
    return GeneratedIntColumn(
      'shared_count',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, productId, viewCount, orderCount, sharedCount];
  @override
  $RankingsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'rankings';
  @override
  final String actualTableName = 'rankings';
  @override
  VerificationContext validateIntegrity(Insertable<Ranking> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id'], _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('view_count')) {
      context.handle(_viewCountMeta,
          viewCount.isAcceptableOrUnknown(data['view_count'], _viewCountMeta));
    }
    if (data.containsKey('order_count')) {
      context.handle(
          _orderCountMeta,
          orderCount.isAcceptableOrUnknown(
              data['order_count'], _orderCountMeta));
    }
    if (data.containsKey('shared_count')) {
      context.handle(
          _sharedCountMeta,
          sharedCount.isAcceptableOrUnknown(
              data['shared_count'], _sharedCountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Ranking map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Ranking.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $RankingsTable createAlias(String alias) {
    return $RankingsTable(_db, alias);
  }
}

class Variant extends DataClass implements Insertable<Variant> {
  final int id;
  final String color;
  final int size;
  final int price;
  final int productId;
  Variant(
      {@required this.id,
      @required this.color,
      this.size,
      this.price,
      this.productId});
  factory Variant.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Variant(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      color:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}color']),
      size: intType.mapFromDatabaseResponse(data['${effectivePrefix}size']),
      price: intType.mapFromDatabaseResponse(data['${effectivePrefix}price']),
      productId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}product_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || size != null) {
      map['size'] = Variable<int>(size);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<int>(price);
    }
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<int>(productId);
    }
    return map;
  }

  VariantsCompanion toCompanion(bool nullToAbsent) {
    return VariantsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      size: size == null && nullToAbsent ? const Value.absent() : Value(size),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
    );
  }

  factory Variant.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Variant(
      id: serializer.fromJson<int>(json['id']),
      color: serializer.fromJson<String>(json['color']),
      size: serializer.fromJson<int>(json['size']),
      price: serializer.fromJson<int>(json['price']),
      productId: serializer.fromJson<int>(json['productId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'color': serializer.toJson<String>(color),
      'size': serializer.toJson<int>(size),
      'price': serializer.toJson<int>(price),
      'productId': serializer.toJson<int>(productId),
    };
  }

  Variant copyWith(
          {int id, String color, int size, int price, int productId}) =>
      Variant(
        id: id ?? this.id,
        color: color ?? this.color,
        size: size ?? this.size,
        price: price ?? this.price,
        productId: productId ?? this.productId,
      );
  @override
  String toString() {
    return (StringBuffer('Variant(')
          ..write('id: $id, ')
          ..write('color: $color, ')
          ..write('size: $size, ')
          ..write('price: $price, ')
          ..write('productId: $productId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(color.hashCode,
          $mrjc(size.hashCode, $mrjc(price.hashCode, productId.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Variant &&
          other.id == this.id &&
          other.color == this.color &&
          other.size == this.size &&
          other.price == this.price &&
          other.productId == this.productId);
}

class VariantsCompanion extends UpdateCompanion<Variant> {
  final Value<int> id;
  final Value<String> color;
  final Value<int> size;
  final Value<int> price;
  final Value<int> productId;
  const VariantsCompanion({
    this.id = const Value.absent(),
    this.color = const Value.absent(),
    this.size = const Value.absent(),
    this.price = const Value.absent(),
    this.productId = const Value.absent(),
  });
  VariantsCompanion.insert({
    this.id = const Value.absent(),
    @required String color,
    this.size = const Value.absent(),
    this.price = const Value.absent(),
    this.productId = const Value.absent(),
  }) : color = Value(color);
  static Insertable<Variant> custom({
    Expression<int> id,
    Expression<String> color,
    Expression<int> size,
    Expression<int> price,
    Expression<int> productId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (color != null) 'color': color,
      if (size != null) 'size': size,
      if (price != null) 'price': price,
      if (productId != null) 'product_id': productId,
    });
  }

  VariantsCompanion copyWith(
      {Value<int> id,
      Value<String> color,
      Value<int> size,
      Value<int> price,
      Value<int> productId}) {
    return VariantsCompanion(
      id: id ?? this.id,
      color: color ?? this.color,
      size: size ?? this.size,
      price: price ?? this.price,
      productId: productId ?? this.productId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (size.present) {
      map['size'] = Variable<int>(size.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VariantsCompanion(')
          ..write('id: $id, ')
          ..write('color: $color, ')
          ..write('size: $size, ')
          ..write('price: $price, ')
          ..write('productId: $productId')
          ..write(')'))
        .toString();
  }
}

class $VariantsTable extends Variants with TableInfo<$VariantsTable, Variant> {
  final GeneratedDatabase _db;
  final String _alias;
  $VariantsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  GeneratedTextColumn _color;
  @override
  GeneratedTextColumn get color => _color ??= _constructColor();
  GeneratedTextColumn _constructColor() {
    return GeneratedTextColumn('color', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _sizeMeta = const VerificationMeta('size');
  GeneratedIntColumn _size;
  @override
  GeneratedIntColumn get size => _size ??= _constructSize();
  GeneratedIntColumn _constructSize() {
    return GeneratedIntColumn(
      'size',
      $tableName,
      true,
    );
  }

  final VerificationMeta _priceMeta = const VerificationMeta('price');
  GeneratedIntColumn _price;
  @override
  GeneratedIntColumn get price => _price ??= _constructPrice();
  GeneratedIntColumn _constructPrice() {
    return GeneratedIntColumn(
      'price',
      $tableName,
      true,
    );
  }

  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  GeneratedIntColumn _productId;
  @override
  GeneratedIntColumn get productId => _productId ??= _constructProductId();
  GeneratedIntColumn _constructProductId() {
    return GeneratedIntColumn('product_id', $tableName, true,
        $customConstraints: 'NULLABLE REFERENCES Product(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [id, color, size, price, productId];
  @override
  $VariantsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'variants';
  @override
  final String actualTableName = 'variants';
  @override
  VerificationContext validateIntegrity(Insertable<Variant> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color'], _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('size')) {
      context.handle(
          _sizeMeta, size.isAcceptableOrUnknown(data['size'], _sizeMeta));
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price'], _priceMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id'], _productIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Variant map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Variant.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $VariantsTable createAlias(String alias) {
    return $VariantsTable(_db, alias);
  }
}

class Tax extends DataClass implements Insertable<Tax> {
  final int id;
  final String name;
  final double value;
  final int productId;
  Tax(
      {@required this.id,
      @required this.name,
      this.value,
      @required this.productId});
  factory Tax.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    return Tax(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      value:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}value']),
      productId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}product_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<double>(value);
    }
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<int>(productId);
    }
    return map;
  }

  ProductTaxCompanion toCompanion(bool nullToAbsent) {
    return ProductTaxCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
    );
  }

  factory Tax.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Tax(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      value: serializer.fromJson<double>(json['value']),
      productId: serializer.fromJson<int>(json['productId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'value': serializer.toJson<double>(value),
      'productId': serializer.toJson<int>(productId),
    };
  }

  Tax copyWith({int id, String name, double value, int productId}) => Tax(
        id: id ?? this.id,
        name: name ?? this.name,
        value: value ?? this.value,
        productId: productId ?? this.productId,
      );
  @override
  String toString() {
    return (StringBuffer('Tax(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('value: $value, ')
          ..write('productId: $productId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(name.hashCode, $mrjc(value.hashCode, productId.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Tax &&
          other.id == this.id &&
          other.name == this.name &&
          other.value == this.value &&
          other.productId == this.productId);
}

class ProductTaxCompanion extends UpdateCompanion<Tax> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> value;
  final Value<int> productId;
  const ProductTaxCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.value = const Value.absent(),
    this.productId = const Value.absent(),
  });
  ProductTaxCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    this.value = const Value.absent(),
    @required int productId,
  })  : name = Value(name),
        productId = Value(productId);
  static Insertable<Tax> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<double> value,
    Expression<int> productId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (value != null) 'value': value,
      if (productId != null) 'product_id': productId,
    });
  }

  ProductTaxCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<double> value,
      Value<int> productId}) {
    return ProductTaxCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      productId: productId ?? this.productId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductTaxCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('value: $value, ')
          ..write('productId: $productId')
          ..write(')'))
        .toString();
  }
}

class $ProductTaxTable extends ProductTax
    with TableInfo<$ProductTaxTable, Tax> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProductTaxTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _valueMeta = const VerificationMeta('value');
  GeneratedRealColumn _value;
  @override
  GeneratedRealColumn get value => _value ??= _constructValue();
  GeneratedRealColumn _constructValue() {
    return GeneratedRealColumn(
      'value',
      $tableName,
      true,
    );
  }

  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  GeneratedIntColumn _productId;
  @override
  GeneratedIntColumn get productId => _productId ??= _constructProductId();
  GeneratedIntColumn _constructProductId() {
    return GeneratedIntColumn('product_id', $tableName, false,
        $customConstraints: 'REFERENCES Product(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, value, productId];
  @override
  $ProductTaxTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'product_tax';
  @override
  final String actualTableName = 'product_tax';
  @override
  VerificationContext validateIntegrity(Insertable<Tax> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value'], _valueMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id'], _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tax map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Tax.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ProductTaxTable createAlias(String alias) {
    return $ProductTaxTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $CategoriesTable _categories;
  $CategoriesTable get categories => _categories ??= $CategoriesTable(this);
  $ProductsTable _products;
  $ProductsTable get products => _products ??= $ProductsTable(this);
  $RankingsTable _rankings;
  $RankingsTable get rankings => _rankings ??= $RankingsTable(this);
  $VariantsTable _variants;
  $VariantsTable get variants => _variants ??= $VariantsTable(this);
  $ProductTaxTable _productTax;
  $ProductTaxTable get productTax => _productTax ??= $ProductTaxTable(this);
  CategoryDao _categoryDao;
  CategoryDao get categoryDao =>
      _categoryDao ??= CategoryDao(this as AppDatabase);
  ProductDao _productDao;
  ProductDao get productDao => _productDao ??= ProductDao(this as AppDatabase);
  RankingDao _rankingDao;
  RankingDao get rankingDao => _rankingDao ??= RankingDao(this as AppDatabase);
  VariantDao _variantDao;
  VariantDao get variantDao => _variantDao ??= VariantDao(this as AppDatabase);
  TaxDao _taxDao;
  TaxDao get taxDao => _taxDao ??= TaxDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [categories, products, rankings, variants, productTax];
}
