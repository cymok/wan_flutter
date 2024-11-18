import 'package:dio/dio.dart';
import 'package:wan_flutter/utils/sp_utils.dart';

// 或可直接使用 InterceptorsWrapper
class CookieInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String? cookies = await SpUtils.getString("cookies");
    if (cookies != null && cookies.isNotEmpty) {
      options.headers["Cookie"] = cookies;
      // debugPrint("CookieInterceptor onRequest cookies = ${cookies}");
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    var setCookie = response.headers['set-cookie'];
    if (setCookie != null) {
      // 将 Set-Cookie 转为字符串以供下次请求使用
      String cookies = setCookie.join('; ');
      // debugPrint("CookieInterceptor onResponse cookies = ${cookies}");
      SpUtils.setString("cookies", cookies);
    }
    return handler.next(response);
  }
}
