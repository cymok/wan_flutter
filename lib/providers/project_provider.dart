import 'package:flutter/widgets.dart';
import 'package:wan_flutter/api/services/wan_service.dart';
import 'package:wan_flutter/models/articles_tree_item.dart';

class ProjectProvider with ChangeNotifier {
  List<ArticlesTreeItem> tabList = [];
  bool loading = false;

  final WanService _apiService = WanService();

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
