import 'package:get/get.dart';
import 'package:vlts_swc/common_utils/common_functions.dart';
import 'package:vlts_swc/core/aes_encypt.dart';
import 'package:vlts_swc/core/base/base_view_model.dart';
import 'package:vlts_swc/core/services/shared_prefs_service.dart';
import 'package:vlts_swc/models/ulb_model.dart';
import '../repositories/home_repository.dart';
import '../repositories/HomeRepositoryImpl.dart';

/// MVVM ViewModel for the Home screen.
/// Manages ULB progress data, metrics, loading states, and error handling.
class HomeViewModel extends BaseViewModel {
  final HomeRepository repository;

  HomeViewModel({HomeRepository? repository})
      : repository = repository ??
            (Get.isRegistered<HomeRepository>()
                ? Get.find<HomeRepository>()
                : HomeRepositoryImpl());

  // Reactive UI States
  final Rxn<UlbModel> ulbModel = Rxn<UlbModel>();
  final RxList<UlbProgressData> ulbList = <UlbProgressData>[].obs;

  /// Fetches the ULB wise progress list using stored user credentials
  Future<void> fetchUlbWiseProgress() async {
    try {
      setLoading();

      final prefsService = SharedPrefsService.instance;
      
      // Fallback defaults matching backend super-admin credentials if prefs empty
      final rawLoginId = prefsService.loginIdSync;
      final rawUlbId = prefsService.ulbIdSync;
      final rawRoleId = prefsService.roleIdSync;

      final effectiveLoginId = (rawLoginId != null && rawLoginId.isNotEmpty)
          ? rawLoginId
          : (prefsService.userNameSync != null && prefsService.userNameSync!.isNotEmpty)
              ? prefsService.userNameSync!
              : 'super-admin';

      final effectiveUlbId = (rawUlbId != null && rawUlbId.isNotEmpty)
          ? rawUlbId
          : '0';

      final effectiveRoleId = (rawRoleId != null && rawRoleId.isNotEmpty)
          ? rawRoleId
          : '1';

      final encryptionHelper = AESENCRYPTION();

      final encryptedLoginId = encryptionHelper.aesEncryption(
        plainText: effectiveLoginId,
      );
      final encryptedUlbId = encryptionHelper.aesEncryption(
        plainText: effectiveUlbId,
      );
      final encryptedRoleId = encryptionHelper.aesEncryption(
        plainText: effectiveRoleId,
      );

      final requestBody = {
        "LoginID": encryptedLoginId,
        "ULBID": encryptedUlbId,
        "RoleID": encryptedRoleId,
      };

      Log.d("HomeViewModel", "Request payload -> LoginID: $effectiveLoginId ($encryptedLoginId), ULBID: $effectiveUlbId ($encryptedUlbId), RoleID: $effectiveRoleId ($encryptedRoleId)");

      final result = await repository.getUlbWiseProgressList(
        requestBody: requestBody,
      );

      result.fold(
        (failure) {
          setError(failure.message);
        },
        (data) {
          setSuccess();
          ulbModel.value = data;
          Log.d("HomeViewModel", "UlbModel fetched successfully: ${data.ulbWiseProgressList.length} items");
          ulbList.assignAll(data.ulbWiseProgressList);
        },
      );
    } catch (e) {
      setError(e.toString());
    } finally {
      if (isLoading.value && !isError && !isSuccess) {
        resetState();
      }
    }
  }
}

/// Backwards compatibility alias
typedef HomeController = HomeViewModel;
