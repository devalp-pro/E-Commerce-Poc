import 'package:moor/moor.dart';

@DataClassName('Ranking')
class Rankings extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get productId => integer().nullable().customConstraint('NULLABLE REFERENCES Product(id)')();

  IntColumn get viewCount => integer().nullable()();

  IntColumn get orderCount => integer().nullable()();

  IntColumn get sharedCount => integer().nullable()();
}
