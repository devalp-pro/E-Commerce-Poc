import 'package:moor/moor.dart';

@DataClassName('Tax')
class ProductTax extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 50)();

  RealColumn get value => real().nullable()();

  IntColumn get productId => integer().customConstraint('REFERENCES Product(id)')();
}
