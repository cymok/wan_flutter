import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:wan_flutter/utils/log_utils.dart';
import 'package:wan_flutter/utils/map_extensions.dart';
import 'package:wan_flutter/utils/sp_utils.dart';

// 或可直接使用 InterceptorsWrapper
class LoggerInterceptor extends Interceptor {
  bool chunk;

  // 分块打印，文本过长时也可以完整打印
  LoggerInterceptor({
    this.chunk = false,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    LogUtils.logCyan("request start 👇 ========== ========== ========== ========== ==========");
    LogUtils.log("url: ${options.path}");
    if (options.data != null) {
      if (options.data is FormData) {
        // 表单（FormData） 参数
        var map = <String, dynamic>{};
        for (var e in (options.data as FormData).fields) {
          map[e.key] = e.value;
        }
        debugPrint("data: ${map.toUrlEncodedString()}");
      } else {
        // json、string 参数
        debugPrint("data: ${options.data}");
      }
    }
    if (options.headers.isNotEmpty) {
      LogUtils.log("headers: ${options.headers}");
    }
    LogUtils.logYellow("request end ========== ========== ==========");
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    LogUtils.logYellow("response start ========== ========== ==========");
    if (chunk) {
      LogUtils.logChunk("${response.data}");
    } else {
      LogUtils.log("${response.data}");
    }
    if (response.extra.isNotEmpty) {
      debugPrint("extra: ${response.extra}");
    }
    if (response.headers.map.isNotEmpty) {
      LogUtils.log("headers: ${response.headers.map}");
    }
    LogUtils.logCyan("response end 👆 ========== ========== ========== ========== ==========");
    return handler.next(response);
  }
}
