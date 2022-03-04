import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../home_view_provider.dart';

class Providers {
  static List<SingleChildWidget> getAllProviders() {
    List<SingleChildWidget> _providers = [
      ChangeNotifierProvider(create: (context) => HomeViewProvider()),
    ];
    return _providers;
  }
}
