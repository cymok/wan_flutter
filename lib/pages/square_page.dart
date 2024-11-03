// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wan_flutter/common/my_color.dart';
import 'package:wan_flutter/pages/common/articles_list_state.dart';
import 'package:wan_flutter/providers/square_provider.dart';

class SquarePage extends StatefulWidget {
  const SquarePage({super.key});

  @override
  State createState() => _SquareState();
}

class _SquareState extends ArticlesListState<SquarePage, SquareProvider> {

}
