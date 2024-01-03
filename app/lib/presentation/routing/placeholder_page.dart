import 'package:flutter/material.dart';
import 'package:v_flutter_core/v_flutter_core.dart';

class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({
    super.key,
    required this.title,
    this.body = const Text(''),
    this.actions = const [],
  });

  final String title;
  final Widget body;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return InheritingScaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      body: Center(
        child: body,
      ),
    );
  }
}
