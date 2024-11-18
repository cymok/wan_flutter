import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wan_flutter/common/my_color.dart';
import 'package:wan_flutter/providers/user_provider.dart';
import 'package:wan_flutter/utils/toast_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;

      Provider.of<UserProvider>(context, listen: false).login(username, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        if (provider.superUserInfo != null) {
          // 显示登录成功信息
          toast("登录成功");
          // 可以导航到主页或其他页面
          // 微任务优先执行，与其他常规异步操作（例如 Future.delayed）相比，微任务会在当前事件循环中的所有同步代码执行完后立即执行，比延时任务或 I/O 操作更快
          // Future.microtask(() {
          //   // 异步代码，先检查小部件是否仍在 widget 树中
          //   if (!mounted) return;
          //   Navigator.pop(context);
          // });
          Navigator.pop(context);
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('登录'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: '用户名',
                      border: OutlineInputBorder(),
                      // 边框颜色
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyColor.iconColorFore, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '请输入用户名';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: '密码',
                      border: OutlineInputBorder(),
                      // 边框颜色
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyColor.iconColorFore, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '请输入密码';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColor.iconColorFore,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: _login,
                      child: Text('登录'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
