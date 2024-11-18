import 'package:flutter/widgets.dart';
import 'package:wan_flutter/api/api_path.dart';
import 'package:wan_flutter/api/api_service.dart';
import 'package:wan_flutter/models/article_item.dart';
import 'package:wan_flutter/models/articles_tree_item.dart';
import 'package:wan_flutter/models/banner_item.dart';

class WanService extends ApiService {
  void printBannerList(List<BannerItem> bannerList) {
    // debugPrint("bannerList(${bannerList.length}) = ${bannerList.map((e) => e.id).join(", ")}");
  }

  void printArticleTree(List<ArticlesTreeItem> tree) {
    // debugPrint("tree = ${tree.map((e) => e.name).toList()}");
  }

  void printArticleList(List<ArticleItem> itemList) {
    // debugPrint("itemList(${itemList.length}) = ${itemList.map((e) => e.id).join(", ")}");
  }

  Future<List<BannerItem>> getBannerList() async {
    debugPrint("fetch getBannerList()");
    List<BannerItem> bannerList = await request(
      method: "get",
      path: ApiPath.banner,
      fromJsonT: (json) {
        List<dynamic> data = json;
        return data.map((e) => BannerItem.fromJson(e)).toList();
      },
    );
    printBannerList(bannerList);
    return bannerList;
  }

  Future<List<ArticleItem>> getHomeTopList() async {
    debugPrint("fetch getHomeTopList()");
    List<ArticleItem> itemList = await request(
      method: "get",
      path: ApiPath.homeTopList,
      fromJsonT: (json) {
        List<dynamic> data = json;
        return data.map((e) => ArticleItem.fromJson(e)).toList();
      },
    );
    printArticleList(itemList);
    return itemList;
  }

  Future<List<ArticleItem>> getHomeList(
    int page,
  ) async {
    debugPrint("fetch getHomeList(page: ${page})");
    List<ArticleItem> itemList = await request(
        method: "get",
        path: ApiPath.homeList(page),
        paramsMap: {"page_size": 10},
        fromJsonT: (json) {
          List<dynamic> list = json["datas"];
          return list.map((e) => ArticleItem.fromJson(e)).toList();
        });
    printArticleList(itemList);
    return itemList;
  }

  Future<List<ArticlesTreeItem>> getProjectTree() async {
    debugPrint("fetch getProjectTree");
    List<ArticlesTreeItem> tree = await request(
        method: "get",
        path: ApiPath.projectTree,
        fromJsonT: (json) {
          List<dynamic> list = json;
          return list.map((json) => ArticlesTreeItem.fromJson(json)).toList();
        });
    printArticleTree(tree);
    return tree;
  }

  Future<List<ArticleItem>> getProjectList(
    String cid,
    int page,
  ) async {
    debugPrint("fetch getProjectList(cid: ${cid}, page: ${page})");
    List<ArticleItem> itemList = await request(
        method: "get",
        path: ApiPath.projectList(page),
        paramsMap: {"cid": cid, "page_size": 10},
        fromJsonT: (json) {
          List<dynamic> list = json["datas"];
          return list.map((e) => ArticleItem.fromJson(e)).toList();
        });
    printArticleList(itemList);
    return itemList;
  }

  Future<List<ArticleItem>> getSquareList(
    int page,
  ) async {
    debugPrint("fetch getSquareList(page: ${page})");
    List<ArticleItem> itemList = await request(
      method: "get",
      path: ApiPath.squareList(page),
      paramsMap: {"page_size": 10}, // fixme 此接口返回的条数有问题
      fromJsonT: (json) {
        List<dynamic> list = json["datas"];
        return list.map((e) => ArticleItem.fromJson(e)).toList();
      },
    );
    printArticleList(itemList);
    return itemList;
  }

  Future<List<ArticlesTreeItem>> getSubscribeTree() async {
    debugPrint("fetch getSubscribeTree");
    List<ArticlesTreeItem> tree = await request(
      method: "get",
      path: ApiPath.wxArticleTree,
      fromJsonT: (json) {
        List<dynamic> list = json;
        return list.map((json) => ArticlesTreeItem.fromJson(json)).toList();
      },
    );
    printArticleTree(tree);
    return tree;
  }

  Future<List<ArticleItem>> getSubscribeList(
    String id,
    int page,
  ) async {
    debugPrint("fetch getSubscribeList(id: ${id}, page: ${page})");
    List<ArticleItem> itemList = await request(
      method: "get",
      path: ApiPath.wxArticleList(id, page),
      paramsMap: {"page_size": 10},
      fromJsonT: (json) {
        List<dynamic> list = json["datas"];
        return list.map((e) => ArticleItem.fromJson(e)).toList();
      },
    );
    printArticleList(itemList);
    return itemList;
  }
}
