import 'package:flutter/material.dart';
import 'package:wan_flutter/pages/common/articles_list_state.dart';
import 'package:wan_flutter/providers/subscribe_tab_provider.dart';

class SubscribeTabPage extends StatefulWidget {
  final String tabId;

  const SubscribeTabPage({super.key, required this.tabId});

  @override
  State createState() => _SubscribeTabState();
}

class _SubscribeTabState extends ArticlesListState<SubscribeTabPage, SubscribeTabProvider> {}
