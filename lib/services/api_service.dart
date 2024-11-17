import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:wan_flutter/models/api_response.dart';
import 'package:wan_flutter/models/article_item.dart';
import 'package:wan_flutter/models/articles_tree_item.dart';
import 'package:wan_flutter/models/banner_item.dart';
import 'package:wan_flutter/utils/log_utils.dart';

class ApiService {
  final String baseUrl = "https://www.wanandroid.com";

  String bannerListUrl = "/banner/json";
  String homeTopListUrl = "/article/top/json";
  String homeListUrl = "/article/list/{page}/json";

  String projectTreeUrl = "/project/tree/json";
  String projectListUrl = "/project/list/{page}/json";

  String squareListUrl = "/user_article/list/{page}/json";

  String subscribeTreeUrl = "/wxarticle/chapters/json";
  String subscribeListUrl = "/wxarticle/list/{id}/{page}/json";

  final dio = Dio();

  void printResponse(Response<dynamic> response, {bool chunk = false}) {
    LogUtils.logRed("========== ========== ========== ========== ==========");
    LogUtils.logRed("request start 👇");
    LogUtils.log("url: ${response.requestOptions.path}");
    if (response.requestOptions.data != null) {
      debugPrint("data: ${response.requestOptions.data}");
    }
    if (response.requestOptions.headers.isNotEmpty) {
      LogUtils.logYellow("headers: ${response.requestOptions.headers}");
    }
    LogUtils.logRed("request end 👆");
    LogUtils.log("========== ========== ==========");
    LogUtils.logRed("response start 👇");
    if (chunk) {
      LogUtils.logChunk("${response.data}");
    } else {
      LogUtils.log("${response.data}");
    }
    if (response.extra.isNotEmpty) {
      debugPrint("extra: ${response.extra}");
    }
    if (response.headers.map.isNotEmpty) {
      LogUtils.logYellow("headers: ${response.headers.map}");
    }
    LogUtils.logRed("response end 👆");
    LogUtils.logRed("========== ========== ========== ========== ==========");
  }

  void printBannerList(List<BannerItem> bannerList) {
    // debugPrint("bannerList(${bannerList.length}) = ${bannerList.map((e) => e.id).join(", ")}");
  }

  void printArticleList(List<ArticleItem> itemList) {
    // debugPrint("itemList(${itemList.length}) = ${itemList.map((e) => e.id).join(", ")}");
  }

  Future<List<BannerItem>> getBannerList() async {
    debugPrint("fetch getBannerList()");

    Response response = await dio.get(
      baseUrl + bannerListUrl,
    );

    printResponse(response);

    List<dynamic> list = response.data['data'];
    // 解析 list 里 item 的对象
    List<BannerItem> bannerList = list.map((e) => BannerItem.fromJson(e)).toList();
    printBannerList(bannerList);
    return bannerList;
  }

  Future<List<ArticleItem>> getHomeTopList() async {
    debugPrint("fetch getHomeTopList()");

    Response response = await dio.get(
      baseUrl + homeTopListUrl,
    );

    printResponse(response);

    List<dynamic> list = response.data['data'];
    // 解析 list 里 item 的对象
    List<ArticleItem> itemList = list.map((e) => ArticleItem.fromJson(e)).toList();
    printArticleList(itemList);
    return itemList;
  }

  Future<List<ArticleItem>> getHomeList(
    String page,
  ) async {
    debugPrint("fetch getHomeList(page: ${page})");

    Response response = await dio.get(
      baseUrl + homeListUrl.replaceAll("{page}", page),
      queryParameters: {"page_size": 10},
    );

    printResponse(response);

    dynamic data = response.data['data'];
    List<dynamic> list = data['datas'];
    // 解析 list 里 item 的对象
    List<ArticleItem> itemList = list.map((e) => ArticleItem.fromJson(e)).toList();
    printArticleList(itemList);
    return itemList;
  }

  Future<List<ArticlesTreeItem>> getProjectTree() async {
    debugPrint("fetch getProjectTree");

    var path = baseUrl + projectTreeUrl;

    Response result = await dio.get(path);
    // string = result.data.toString();

    printResponse(result);

    // json 转换 接口返回数据格式
    ApiResponse<List<ArticlesTreeItem>> response = ApiResponse.fromJson(result.data, (jsonStr) {
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

    printResponse(response);

    dynamic data = response.data['data'];
    List<dynamic> list = data['datas'];
    // 解析 list 里 item 的对象
    List<ArticleItem> itemList = list.map((e) => ArticleItem.fromJson(e)).toList();
    printArticleList(itemList);
    return itemList;
  }

  Future<List<ArticleItem>> getSquareList(
    String page,
  ) async {
    Response response = await dio.get(baseUrl + squareListUrl.replaceAll("{page}", page),
        queryParameters: {"page_size": 10}, // fixme 此接口返回的条数有问题
        options: Options(headers: {
          // headers
          "testKey": "testValue",
        }));

    printResponse(response);

    dynamic data = response.data['data'];
    List<dynamic> list = data['datas'];
    // 解析 list 里 item 的对象
    List<ArticleItem> itemList = list.map((e) => ArticleItem.fromJson(e)).toList();
    printArticleList(itemList);
    return itemList;
  }

  Future<List<ArticlesTreeItem>> getSubscribeTree() async {
    debugPrint("fetch getSubscribeTree");

    var path = baseUrl + subscribeTreeUrl;

    Response result = await dio.get(path);

    printResponse(result);

    // json 转换 接口返回数据格式
    ApiResponse<List<ArticlesTreeItem>> response = ApiResponse.fromJson(result.data, (jsonStr) {
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
      baseUrl + subscribeListUrl.replaceAll("{id}", id).replaceAll("{page}", page),
      queryParameters: {"page_size": 10},
    );

    printResponse(response);

    dynamic data = response.data['data'];
    List<dynamic> list = data['datas'];
    // 解析 list 里 item 的对象
    List<ArticleItem> itemList = list.map((e) => ArticleItem.fromJson(e)).toList();
    printArticleList(itemList);
    return itemList;
  }
}
