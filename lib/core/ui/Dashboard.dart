import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

class DashboardLayout extends StatelessWidget {
  const DashboardLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdaptiveScaffold(destinations: [
      NavigationDestination(icon: Icon(Icons.folder_copy_sharp), label: 'projects'),
      NavigationDestination(icon: Icon(Icons.folder_copy_sharp), label: 'projects'),
    ]);
  }
}
