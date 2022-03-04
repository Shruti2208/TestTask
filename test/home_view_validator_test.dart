import 'package:flutter_test/flutter_test.dart';
import 'package:nextbase_task/home_view_provider.dart';

void main() {
  test('test if loader is initialised', () {
    expect(HomeViewProvider().loading, false);
  });
}
