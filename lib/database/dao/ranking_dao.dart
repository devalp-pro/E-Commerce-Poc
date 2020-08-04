import 'package:e_commerce_poc/bean/data_bean.dart';
import 'package:e_commerce_poc/bean/ranking_bean.dart';
import 'package:e_commerce_poc/bean/ranking_product_bean.dart';
import 'package:e_commerce_poc/database/app_database.dart';
import 'package:e_commerce_poc/database/model/product_ranking.dart';
import 'package:e_commerce_poc/database/model/products.dart';
import 'package:e_commerce_poc/database/model/rankings.dart';
import 'package:moor/moor.dart';

part 'ranking_dao.g.dart';

@UseDao(tables: [Rankings, Products])
class RankingDao extends DatabaseAccessor<AppDatabase> with _$RankingDaoMixin {
  final AppDatabase appDatabase;

  RankingDao(this.appDatabase) : super(appDatabase);

  Future<void> insertAllRankings(DataBean appData) {
    return transaction(() async {
      for (RankingBean rankingBean in appData.rankings) {
        if (rankingBean.products.isNotEmpty) {
          for (RankingProductBean productsBean in rankingBean.products) {
            Ranking ranking = await (select(rankings)..where((tbl) => tbl.productId.equals(productsBean.id))).getSingle();
            RankingsCompanion rankingsCompanion;
            if (ranking != null) {
              rankingsCompanion = ranking.toCompanion(false);
              if (productsBean.orderCount != null) {
                rankingsCompanion = rankingsCompanion.copyWith(orderCount: Value(productsBean.orderCount));
              } else if (productsBean.shares != null) {
                rankingsCompanion = rankingsCompanion.copyWith(sharedCount: Value(productsBean.shares));
              }
            } else {
              rankingsCompanion = RankingsCompanion(
                  viewCount: Value(productsBean.viewCount),
                  orderCount: Value(productsBean.orderCount),
                  sharedCount: Value(productsBean.shares),
                  productId: Value(productsBean.id));
            }
            await into(rankings).insertOnConflictUpdate(rankingsCompanion);
          }
        }
      }
    });
  }

  Future<Map<String, List<ProductRanking>>> getRankingProducts() async {
    Map<String, List<ProductRanking>> mapRankings = Map();
    final viewRankingList = await (select(rankings).join([innerJoin(products, products.id.equalsExp(rankings.productId))])
          ..groupBy([rankings.productId])
          ..orderBy([OrderingTerm(expression: rankings.productId)])
          ..where(rankings.viewCount.isBiggerThanValue(0)))
        .map((rawResult) => ProductRanking(rawResult.readTable(products), rawResult.readTable(rankings).viewCount))
        .get();
    mapRankings['Most Viewed Products'] = viewRankingList;

    final orderRankingList = await (select(rankings).join([innerJoin(products, products.id.equalsExp(rankings.productId))])
          ..groupBy([rankings.productId])
          ..orderBy([OrderingTerm(expression: rankings.productId)])
          ..where(rankings.orderCount.isBiggerThanValue(0)))
        .map((rawResult) => ProductRanking(rawResult.readTable(products), rawResult.readTable(rankings).orderCount))
        .get();
    mapRankings['Most Ordered Products'] = orderRankingList;

    final sharedRankingList = await (select(rankings).join([innerJoin(products, products.id.equalsExp(rankings.productId))])
          ..groupBy([rankings.productId])
          ..orderBy([OrderingTerm(expression: rankings.productId)])
          ..where(rankings.sharedCount.isBiggerThanValue(0)))
        .map((rawResult) => ProductRanking(rawResult.readTable(products), rawResult.readTable(rankings).sharedCount))
        .get();
    mapRankings['Most Shared Products'] = sharedRankingList;

    return mapRankings;
  }
}
