import 'package:e_commerce_poc/database/dao/category_dao.dart';
import 'package:e_commerce_poc/database/dao/product_dao.dart';
import 'package:e_commerce_poc/database/dao/ranking_dao.dart';
import 'package:e_commerce_poc/database/model/categories.dart';
import 'package:e_commerce_poc/database/model/products.dart';
import 'package:e_commerce_poc/database/model/rankings.dart';
import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'app_database.g.dart';

@UseMoor(tables: [Categories, Products, Rankings], daos: [CategoryDao, ProductDao, RankingDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'app.sqlite', logStatements: true));

  @override
  int get schemaVersion => 2;

  MigrationStrategy get migration => MigrationStrategy(onCreate: (Migrator migrator) {
        return migrator.createAll();
      }, onUpgrade: (Migrator migrator, int from, int to) async {
        if (from == 1) {
          await migrator.createTable(rankings);
        }
      });
}
