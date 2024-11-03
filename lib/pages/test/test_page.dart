// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wan_flutter/common/my_color.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State createState() => _TestState();
}

class _TestState extends State<TestPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late AnimationController _controller;

  late Tween<double> _animationTween;

  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1), // 动画持续时间
      vsync: this, // 垂直同步，通常传入当前Widget的State
    );
    _animationTween = Tween<double>(
      begin: 0,
      end: 200,
    );
    _animation = _animationTween.animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: MyColor.wxBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("广场"),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                width: _animation.value,
                height: _animation.value,
                color: Colors.blue,
                // child: Text("Test"),
              );
            },
          ),
          OutlinedButton(
            onPressed: () {
              _controller.forward(); // 开始动画
              // _controller.reverse(); // 反向播放动画
              // _controller.stop(); // 停止动画
            },
            child: Text("执行动画"),
          ),
          OutlinedButton(
            onPressed: () {
              // _controller.forward(); // 开始动画
              _controller.reverse(); // 反向播放动画
              // _controller.stop(); // 停止动画
            },
            child: Text("反向执行动画"),
          ),
          OutlinedButton(
            onPressed: () {
              // _controller.forward(); // 开始动画
              // _controller.reverse(); // 反向播放动画
              _controller.stop(); // 停止动画
            },
            child: Text("停止动画"),
          ),
        ],
      ),
    );
  }
}
