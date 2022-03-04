import 'package:flutter/cupertino.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nextbase_task/data_model.dart';
import 'package:nextbase_task/repository.dart';

import 'common/constants.dart';

class HomeViewProvider extends Mock with ChangeNotifier {
  bool loading = false;
  DataModel data = DataModel();

  init() async {
    loading = true;

    await APIRepository().getData(Constants.baseUrl).then((_data) {
      data = _data;
      loading = false;
      notifyListeners();
    });

    notifyListeners();
  }
}
