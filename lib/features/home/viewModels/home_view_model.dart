import 'package:get/get.dart';
import 'package:vlts_swc/common_utils/common_functions.dart';
import 'package:vlts_swc/core/aes_encypt.dart';
import 'package:vlts_swc/core/base/base_view_model.dart';
import 'package:vlts_swc/core/storage/shared_prefs_service.dart';
import 'package:vlts_swc/models/ulb_model.dart';

import '../repositories/home_repository.dart';
import '../repositories/HomeRepositoryImpl.dart';

/// MVVM ViewModel for the Home screen.
/// Manages ULB progress data, metrics, loading states, and error handling.
class HomeViewModel extends BaseViewModel {
  final HomeRepository repository;

  HomeViewModel({HomeRepository? repository})
    : repository =
          repository ??
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

      final profile = await SharedPrefsService.getProfile();

      // Fallback defaults matching backend super-admin credentials if prefs empty

      final encryptionHelper = AESENCRYPTION();

      final encryptedLoginId = encryptionHelper.aesEncryption(
        plainText: profile?.loginID ?? '',
      );
      final encryptedUlbId = encryptionHelper.aesEncryption(
        plainText: profile?.ulbid ??'',
      );
      final encryptedRoleId = encryptionHelper.aesEncryption(
        plainText: profile?.roleID ??'',
      );

      final requestBody = {
        "LoginID": encryptedLoginId,
        "ULBID": encryptedUlbId,
        "RoleID": encryptedRoleId,
      };

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
          Log.d(
            "HomeViewModel",
            "UlbModel fetched successfully: ${data.ulbWiseProgressList.length} items",
          );
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
