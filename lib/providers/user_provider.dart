import 'package:flutter/cupertino.dart';
import 'package:wan_flutter/api/api_exception.dart';
import 'package:wan_flutter/api/services/user_service.dart';
import 'package:wan_flutter/models/user_info.dart';
import 'package:wan_flutter/utils/log_utils.dart';
import 'package:wan_flutter/utils/toast_utils.dart';
import 'package:wan_flutter/utils/user_utils.dart';

class UserProvider with ChangeNotifier {
  SuperUserInfo? superUserInfo;
  bool isLoading = false;

  UserProvider() {
    // 从本地缓存获取
    // 构造方法不能使用 async/await，使用 then
    UserUtils.getSuperUserInfo().then((e) {
      superUserInfo = e;
      notifyListeners();
    });
  }

  final UserService _apiService = UserService();

  Future<void> login(
    String username,
    String password,
  ) async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    try {
      var userInfo = await _apiService.login(
        username,
        password,
      );
      superUserInfo = SuperUserInfo();
      superUserInfo!.userInfo = userInfo;
      // 保存用户信息
      UserUtils.saveSupperUserInfo(superUserInfo!);
    } catch (e) {
      if (e is ApiException) {
        ToastUtils.show(e.message);
      } else {
        LogUtils.logRed(e);
        ToastUtils.show("登录失败");
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      await _apiService.logout();
      // 保存用户信息
      UserUtils.clear();
      superUserInfo = null;
    } catch (e) {
      LogUtils.logRed(e);
    } finally {
      notifyListeners();
    }
  }

  Future<void> getUserInfo() async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    try {
      var superUserInfo = await _apiService.getUserInfo();
      this.superUserInfo = superUserInfo;
      // 保存用户信息
      UserUtils.saveSupperUserInfo(superUserInfo);
    } catch (e) {
      LogUtils.logRed(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
