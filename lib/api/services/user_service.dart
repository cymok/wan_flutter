import 'package:flutter/widgets.dart';
import 'package:wan_flutter/api/api_path.dart';
import 'package:wan_flutter/api/api_service.dart';
import 'package:wan_flutter/models/user_info.dart';

class UserService extends ApiService {
  Future<UserInfo> login(
    String username,
    String password,
  ) async {
    debugPrint("fetch login()");
    UserInfo userInfo = await request(
      method: "post",
      path: ApiPath.userLogin,
      paramsMap: {
        "username": username,
        "password": password,
      },
      fromJsonT: (json) {
        return UserInfo.fromJson(json);
      },
    );
    return userInfo;
  }

  Future<Object?> logout() async {
    debugPrint("logout()");
    Object? result = await request(
      method: "get",
      path: ApiPath.userLogout,
      fromJsonT: (json) {
        return json;
      },
    );
    return result;
  }

  Future<SuperUserInfo> getUserInfo() async {
    debugPrint("getUserInfo()");
    SuperUserInfo userInfo = await request(
      method: "get",
      path: ApiPath.userInfo,
      fromJsonT: (json) {
        return SuperUserInfo.fromJson(json);
      },
    );
    return userInfo;
  }
}
