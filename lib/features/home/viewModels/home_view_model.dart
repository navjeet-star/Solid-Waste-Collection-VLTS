import 'package:get/get.dart';
import 'package:vlts_swc/common_utils/common_functions.dart';
import 'package:vlts_swc/core/aes_encypt.dart';
import 'package:vlts_swc/core/base/base_view_model.dart';
import 'package:vlts_swc/core/network/base_api_response.dart';
import 'package:vlts_swc/core/storage/shared_prefs_service.dart';
import 'package:vlts_swc/models/AttendanceStatusList.dart';
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

  final RxList<AttendanceStatusList> attendanceStatusList =
      <AttendanceStatusList>[].obs;

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

  /// Fetches the attendance status list using the GetAttendanceStatus API
  Future<void> fetchAttendanceStatus({String? loginId}) async {
    try {
      setLoading();

      final profile = await SharedPrefsService.getProfile();
      final encryptionHelper = AESENCRYPTION();

      final encryptedLoginId =encryptionHelper.aesEncryption(plainText: profile?.loginID ??'',);
      final encryptedUlbID   =encryptionHelper.aesEncryption(plainText: profile?.ulbid ??'',);

      final requestBody = {
        "LoginID": encryptedLoginId,
        "ULBID": encryptedUlbID,
        "AttendanceDate":""
      };

      final result = await repository.getAttendanceStatus(
        requestBody: requestBody,
      );

      result.fold(
        (failure) {
          setError(failure.message);
          Log.d("HomeViewModel", "Attendance API error: ${failure.message}");
          if (attendanceStatusList.isEmpty) {
            attendanceStatusList.assignAll(AttendanceStatusList.sampleList);
          }
        },
        (response) {
          setSuccess();
          final items = response.data;
          if (items != null && items.isNotEmpty) {
            Log.d("HomeViewModel", "AttendanceStatusList fetched: ${items.length} items",);
            attendanceStatusList.assignAll(items);
          } else {
            attendanceStatusList.assignAll(AttendanceStatusList.sampleList);
          }
        },
      );
    } catch (e) {
      setError(e.toString());
      if (attendanceStatusList.isEmpty) {
        attendanceStatusList.assignAll(AttendanceStatusList.sampleList);
      }
    } finally {
      if (isLoading.value && !isError && !isSuccess) {
        resetState();
      }
    }
  }
}

/// Backwards compatibility alias
typedef HomeController = HomeViewModel;
