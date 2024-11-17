import 'package:wan_flutter/models/article_item.dart';
import 'package:wan_flutter/providers/common/articles_list_provider.dart';
import 'package:wan_flutter/services/api_service.dart';

class ProjectTabProviderNew extends ArticlesListProvider {
  final String cid;

  final ApiService _apiService = ApiService();

  ProjectTabProviderNew(this.cid) {
    // loadList();
    // 在 pull to refresh 的 initLoad 处理
  }

  @override
  Future<List<ArticleItem>> fetchArticlesList() {
    return _apiService.getProjectList(cid, currentPage.toString());
  }
}
