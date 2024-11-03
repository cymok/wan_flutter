import 'package:flutter/material.dart';
import 'package:wan_flutter/common/my_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() => _HomeState();
}

class _HomeState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        color: MyColor.wxBackground,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("推荐"),
          ],
        ),
      );
}
