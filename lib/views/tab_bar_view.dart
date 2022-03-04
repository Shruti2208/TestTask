import 'package:flutter/material.dart';
import 'package:nextbase_task/views/home_view.dart';
import 'package:nextbase_task/views/map_view.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({Key key}) : super(key: key);

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              indicatorColor: Colors.red,
              indicatorWeight: 5,
              tabs: [
                Tab(icon: Icon(Icons.stacked_line_chart)),
                Tab(icon: Icon(Icons.map)),
              ],
            ),
            title: const Text('Data Representation'),
          ),
          body: const TabBarView(children: [
            HomeView(),
            MapView(),
          ])),
    );
  }
}
