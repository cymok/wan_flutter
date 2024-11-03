import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:wan_flutter/models/api_response.dart';
import 'package:wan_flutter/models/article_item.dart';
import 'package:wan_flutter/models/articles_tree_item.dart';

class ApiService {
  final String baseUrl = "https://www.wanandroid.com";

  String projectTreeUrl = "/project/tree/json";
  String projectListUrl = "/project/list/{page}/json";

  String squareListUrl = "/user_article/list/{page}/json";

  String subscribeTree = "/wxarticle/chapters/json";
  String subscribeListUrl = "/wxarticle/list/{id}/{page}/json";

  final dio = Dio();

  Future<List<ArticlesTreeItem>> getProjectTree() async {
    debugPrint("fetch getProjectTree");

    var path = baseUrl + projectTreeUrl;

    Response result = await dio.get(path);
    // string = result.data.toString();

    // json 转换 接口返回数据格式
    ApiResponse<List<ArticlesTreeItem>> response =
        ApiResponse.fromJson(result.data, (jsonStr) {
      List<dynamic> list = jsonStr;
      // list 的 item, json 转换为对象
      return list.map((json) => ArticlesTreeItem.fromJson(json)).toList();
    });

    debugPrint("tabList.length = ${response.data?.length}");
    return response.data!;

    // List<dynamic> list = response.data['data'];
    // List<ArticlesTreeItem> tabList = list.map((json) => ArticlesTreeItem.fromJson(json)).toList();

    // print("list.size = ${tabList.length} ${tabList.map((e) => e.name)}");
  }

  Future<List<ArticleItem>> getProjectList(
    String cid,
    String page,
  ) async {
    debugPrint("fetch getProjectList(cid: ${cid}, page: ${page})");

    Response response = await dio.get(
      baseUrl + projectListUrl.replaceAll("{page}", page),
      queryParameters: {"cid": cid, "page_size": 10},
    );
    dynamic data = response.data['data'];
    List<dynamic> list = data['datas'];
    // 解析 list 里 item 的对象
    List<ArticleItem> itemList =
        list.map((e) => ArticleItem.fromJson(e)).toList();
    debugPrint("itemList = ${itemList.map((e) => e.title).toList()}");
    return itemList;
  }

  Future<List<ArticleItem>> getSquareList(
    String page,
  ) async {
    Response response =
        await dio.get(baseUrl + squareListUrl.replaceAll("{page}", page),
            queryParameters: {"page_size": 10}, // fixme 此接口返回的条数有问题
            options: Options(headers: {
              // headers
              "testKey": "testValue",
            }));

    debugPrint("request: ${response.requestOptions.path})");
    if (response.requestOptions.data != null) {
      debugPrint("request data: ${response.requestOptions.data}");
    }
    if (response.requestOptions.headers.isNotEmpty) {
      debugPrint("request headers: ${response.requestOptions.headers}");
    }
    debugPrint("response: ${response.data})");
    if (response.extra.isNotEmpty) {
      debugPrint("response extra: ${response.extra})");
    }
    if (response.headers.map.isNotEmpty) {
      debugPrint("response headers: ${response.headers.map})");
    }

    dynamic data = response.data['data'];
    List<dynamic> list = data['datas'];
    // 解析 list 里 item 的对象
    List<ArticleItem> itemList =
        list.map((e) => ArticleItem.fromJson(e)).toList();
    debugPrint("itemList = ${itemList.map((e) => e.title).toList()}");
    debugPrint("itemList.length = ${itemList.length}");
    return itemList;
  }

  Future<List<ArticlesTreeItem>> getSubscribeTree() async {
    debugPrint("fetch getSubscribeTree");

    var path = baseUrl + subscribeTree;

    Response result = await dio.get(path);

    // json 转换 接口返回数据格式
    ApiResponse<List<ArticlesTreeItem>> response =
        ApiResponse.fromJson(result.data, (jsonStr) {
      List<dynamic> list = jsonStr;
      // list 的 item, json 转换为对象
      return list.map((json) => ArticlesTreeItem.fromJson(json)).toList();
    });

    debugPrint("tabList.length = ${response.data?.length}");
    return response.data!;
  }

  Future<List<ArticleItem>> getSubscribeList(
    String id,
    String page,
  ) async {
    debugPrint("fetch getSubscribeList(cid: ${id}, page: ${page})");

    Response response = await dio.get(
      baseUrl +
          subscribeListUrl.replaceAll("{id}", id).replaceAll("{page}", page),
      queryParameters: {"page_size": 10},
    );
    dynamic data = response.data['data'];
    List<dynamic> list = data['datas'];
    // 解析 list 里 item 的对象
    List<ArticleItem> itemList =
        list.map((e) => ArticleItem.fromJson(e)).toList();
    debugPrint("itemList = ${itemList.map((e) => e.title).toList()}");
    return itemList;
  }
}
