import 'package:get/get.dart';

/// Common UI View States for MVVM ViewModels
enum ViewState { initial, loading, success, error }

/// Abstract base ViewModel providing centralized loading, error, and UI state management.
abstract class BaseViewModel extends GetxController {
  final Rx<ViewState> _state = ViewState.initial.obs;
  final RxString _errorMessage = ''.obs;

  /// Reactive boolean loading state compatible with GetX views [Obx]
  final RxBool isLoading = false.obs;

  ViewState get state => _state.value;
  String get errorMessage => _errorMessage.value;

  bool get isInitial => _state.value == ViewState.initial;
  bool get isSuccess => _state.value == ViewState.success;
  bool get isError => _state.value == ViewState.error;

  void setState(ViewState state) {
    _state.value = state;
    isLoading.value = (state == ViewState.loading);
  }

  void setLoading() {
    _state.value = ViewState.loading;
    isLoading.value = true;
    _errorMessage.value = '';
  }

  void setSuccess() {
    _state.value = ViewState.success;
    isLoading.value = false;
    _errorMessage.value = '';
  }

  void setError(String message) {
    _errorMessage.value = message;
    _state.value = ViewState.error;
    isLoading.value = false;
  }

  void resetState() {
    _state.value = ViewState.initial;
    isLoading.value = false;
    _errorMessage.value = '';
  }
}
