import 'package:hooks_riverpod/hooks_riverpod.dart';

final bottomBarProvider = StateNotifierProvider<BottomBarProvider, int>(
    (ref) => BottomBarProvider(0));

class BottomBarProvider extends StateNotifier<int> {
  BottomBarProvider(super.state);

  void setPosition(int value) {
    state = value;
  }
}
