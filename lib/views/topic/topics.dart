import 'package:education_helper/views/widgets/button/custom_go_back.dart';
import 'package:education_helper/views/widgets/header/appbar_bottom.dart';
import 'package:flutter/material.dart';

class Topics extends StatefulWidget {
  const Topics({Key? key}) : super(key: key);

  @override
  _TopicsState createState() => _TopicsState();
}

class _TopicsState extends State<Topics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TOPIC'),
        leading: const KGoBack(),
        bottom: const AppbarBottom(),
      ),
      body: Container(),
    );
  }
}
