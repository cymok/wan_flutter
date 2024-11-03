import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:wan_flutter/models/article_item.dart';
import 'package:wan_flutter/models/api_response.dart';
import 'package:wan_flutter/models/articles_tree_item.dart';
import 'package:wan_flutter/services/api_service.dart';

class ProjectProvider with ChangeNotifier {

  List<ArticlesTreeItem> tabList = [];
  bool loading = false;

  final ApiService _apiService = ApiService();

  Future<void> getProjectTree() async {
    loading = true;
    notifyListeners();

    try {
      tabList = await _apiService.getProjectTree();
    } catch (e) {
      print(e);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

}
