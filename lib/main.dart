import 'package:flutter/material.dart';
import 'package:nextbase_task/common/providers.dart';
import 'package:nextbase_task/views/tab_bar_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: Providers.getAllProviders(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const TabBarScreen(),
        ));
  }
}
