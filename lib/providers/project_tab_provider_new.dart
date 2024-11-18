import 'package:wan_flutter/api/services/wan_service.dart';
import 'package:wan_flutter/models/article_item.dart';
import 'package:wan_flutter/providers/common/articles_list_provider.dart';

class ProjectTabProviderNew extends ArticlesListProvider {
  final String cid;

  final WanService _apiService = WanService();

  ProjectTabProviderNew(this.cid) {
    // loadList();
    // 在 pull to refresh 的 initLoad 处理
  }

  @override
  Future<List<ArticleItem>> fetchArticlesList() {
    return _apiService.getProjectList(cid, currentPage);
  }
}
