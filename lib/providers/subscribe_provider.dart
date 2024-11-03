import 'package:flutter/cupertino.dart';
import 'package:wan_flutter/models/articles_tree_item.dart';
import 'package:wan_flutter/services/api_service.dart';

class SubscribeProvider with ChangeNotifier {

  List<ArticlesTreeItem> tabList = [];
  bool loading = false;

  final ApiService _apiService = ApiService();

  Future<void> getSubscribeTree() async {
    loading = true;
    notifyListeners();

    try {
      tabList = await _apiService.getSubscribeTree();
    } catch (e) {
      print(e);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

}
