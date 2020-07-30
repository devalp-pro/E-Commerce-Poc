import 'package:e_commerce_poc/bean/data_bean.dart';
import 'package:e_commerce_poc/bean/ranking_bean.dart';
import 'package:e_commerce_poc/bean/ranking_product_bean.dart';
import 'package:e_commerce_poc/database/app_database.dart';
import 'package:e_commerce_poc/database/model/products.dart';
import 'package:e_commerce_poc/database/model/rankings.dart';
import 'package:moor/moor.dart';

part 'ranking_dao.g.dart';

@UseDao(tables: [Rankings])
class RankingDao extends DatabaseAccessor<AppDatabase> with _$RankingDaoMixin {
  final AppDatabase appDatabase;

  RankingDao(this.appDatabase) : super(appDatabase);

  Future<void> insertAllRankings(DataBean appData) {
    return transaction(() async {
      for (RankingBean rankingBean in appData.rankings) {
        if (rankingBean.products.isNotEmpty) {
          for (RankingProductBean productsBean in rankingBean.products) {
            RankingsCompanion rankingsCompanion = RankingsCompanion(
                viewCount: Value(productsBean.viewCount),
                orderCount: Value(productsBean.orderCount),
                sharedCount: Value(productsBean.shares),
                productId: Value(productsBean.id));
            try {
              await into(rankings).insert(rankingsCompanion);
            } catch (ex) {
              update(rankings).replace(rankingsCompanion);
            }
          }
        }
      }
    });
  }
}
