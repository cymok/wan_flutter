import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:wan_flutter/models/user_info.dart';
import 'package:wan_flutter/utils/sp_utils.dart';

class UserUtils {
  static saveSupperUserInfo(SuperUserInfo superUserInfo) {
    var json = superUserInfo.toJson(); // Object --> Map
    var jsonStr = jsonEncode(json); // Map --> String
    // todo 处理加解密
    SpUtils.setString("SuperUserInfo", jsonStr); // 保存 String
  }

  static Future<SuperUserInfo?> getSuperUserInfo() async {
    var jsonStr = await SpUtils.getString("SuperUserInfo"); // 取出 String
    if (jsonStr == null) {
      return null;
    }
    // todo 处理加解密
    var json = jsonDecode(jsonStr); // String --> Map
    try {
      return SuperUserInfo.fromJson(json); // Map --> Object
    } catch (e) {
      debugPrint("${e}");
      return null;
    }
  }

  static clear() {
    SpUtils.remove("SuperUserInfo");
    SpUtils.remove("cookies");
  }

  static Future<bool> isLogin() async {
    var superUserInfo = await getSuperUserInfo();
    return superUserInfo?.userInfo != null && superUserInfo?.userInfo?.id != null;
  }
}
