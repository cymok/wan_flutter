import 'package:dio/dio.dart';
import 'package:wan_flutter/api/api_exception.dart';
import 'package:wan_flutter/api/api_path.dart';
import 'package:wan_flutter/api/api_result.dart';
import 'package:wan_flutter/api/interceptors/cookies_interceptor.dart';
import 'package:wan_flutter/api/interceptors/logger_interceptor.dart';
import 'package:wan_flutter/utils/log_utils.dart';
import 'package:wan_flutter/utils/map_extensions.dart';

class ApiService {
  final _dio = Dio();

  ApiService() {
    // 拦截器
    _dio.interceptors.add(CookieInterceptor());
    _dio.interceptors.add(LoggerInterceptor(chunk: false)); // 分块完整打印
  }

  Future<T> request<T>({
    required String method,
    String baseUrl = ApiPath.baseUrl,
    required String path,
    Map<String, dynamic> paramsMap = const {}, // 使用 `const {}` 作为默认值，因为空 Map 也是一个编译时常量
    Map<String, dynamic> headersMap = const {},
    required T Function(dynamic) fromJsonT, // 手动解析 json 转 object
  }) async {
    if (!path.startsWith("/")) {
      path = "/$path";
    }
    if (!path.startsWith("http")) {
      path = baseUrl + path;
    }

    try {
      Response response;
      if (method.toLowerCase() == "get") {
        response = await _dio.get(
          path,
          queryParameters: paramsMap,
          options: Options(headers: headersMap),
        );
      } else if (method.toLowerCase() == "put") {
        response = await _dio.put(
          path,
          data: FormData.fromMap(paramsMap),
          options: Options(headers: headersMap),
        );
      } else if (method.toLowerCase() == "delete") {
        response = await _dio.delete(
          path,
          data: FormData.fromMap(paramsMap),
          options: Options(headers: headersMap),
        );
      } else {
        // post
        response = await _dio.post(
          path,
          // dio 不支持不能直接在 options 的 headers 修改 cookies、content-type 等请求头，可以在拦截器修改
          // 这里使用 FormData 会自动添加请求头 `content-type: multipart/form-data`
          data: FormData.fromMap(paramsMap),
          options: Options(headers: headersMap),
        );
      }

      ApiResult<dynamic> result = ApiResult.fromJson(response.data, fromJsonT);

      if (result.errorCode != 0) {
        throw ApiException(result.errorCode, result.errorMsg);
      }

      return result.data;
    } catch (e) {
      LogUtils.logRed("url = ${path}");
      if (paramsMap.isNotEmpty) {
        LogUtils.logRed("paramsMap = ${paramsMap}");
      }
      if (headersMap.isNotEmpty) {
        LogUtils.logRed("headersMap = ${headersMap}");
      }
      LogUtils.logRed(e);
      rethrow;
    }
  }
}
