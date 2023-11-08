import 'package:get/get.dart';

import '../../core.dart';

abstract class StateStore {
  final Rx<StateStoreStatus> _status =
      Rx<StateStoreStatus>(StateStoreStatus.loading);
  StateStoreStatus get status => _status.value;
  Rx<StateStoreStatus> get rxStatus => _status;

  final _error = Rxn<Exception>();
  Exception? get error => _error.value;
  Rx<Exception?> get rxError => _error;

  set status(StateStoreStatus value) => _status.value = value;
  set error(Exception? value) {
    _status.value = StateStoreStatus.error;
    _error.value = value;
  }

  void completed() {
    _status.value = StateStoreStatus.completed;
  }

  void loading() => _status.value = StateStoreStatus.loading;
  void noContent() => _status.value = StateStoreStatus.noContent;

  bool get isLoading => status == StateStoreStatus.loading;
  bool get hasError => status == StateStoreStatus.error;
  bool get isCompleted => status == StateStoreStatus.completed;
}
