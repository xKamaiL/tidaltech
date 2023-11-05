import 'package:hooks_riverpod/hooks_riverpod.dart';

class IconStatus {
  bool wifi;
  bool bluetooth;

  IconStatus({this.wifi = false, this.bluetooth = false});
}

class IconStatusNotifier extends StateNotifier<IconStatus> {
  IconStatusNotifier(super.state);

  void setBluetooth(bool value) {
    state.bluetooth = value;
    state = state;
  }
}

final iconStatusProvider =
    StateNotifierProvider<IconStatusNotifier, IconStatus>((ref) {
  return IconStatusNotifier(IconStatus());
});
