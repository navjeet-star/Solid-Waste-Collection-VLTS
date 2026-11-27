import 'package:equatable/equatable.dart';

/// Data model representing a detailed ULB record.
/// Keeps data cleanly separated from UI rendering.
class UlbDetailItemModel extends Equatable {
  final String id;
  final String ulbName;
  final String ulbType; // 'Nagar Nigam', 'Nagar Palika Parishad', 'Nagar Panchayat'
  final String optionCode; // e.g. 'nn_1', 'npp_2', etc.
  final int wardsRegistered;
  final int wardsTarget;
  final int vehiclesRegistered;
  final int vehiclesTarget;
  final int d2dVehiclesRegistered;
  final int d2dVehiclesTarget;
  final int sanitaryInspector;
  final int environmentInspector;
  final int sanitaryWorker;
  final int driver;
  final int helper;
  final int employee;

  const UlbDetailItemModel({
    required this.id,
    required this.ulbName,
    required this.ulbType,
    required this.optionCode,
    required this.wardsRegistered,
    required this.wardsTarget,
    required this.vehiclesRegistered,
    required this.vehiclesTarget,
    required this.d2dVehiclesRegistered,
    required this.d2dVehiclesTarget,
    required this.sanitaryInspector,
    required this.environmentInspector,
    required this.sanitaryWorker,
    required this.driver,
    required this.helper,
    required this.employee,
  });

  @override
  List<Object?> get props => [
        id,
        ulbName,
        ulbType,
        optionCode,
        wardsRegistered,
        wardsTarget,
        vehiclesRegistered,
        vehiclesTarget,
        d2dVehiclesRegistered,
        d2dVehiclesTarget,
        sanitaryInspector,
        environmentInspector,
        sanitaryWorker,
        driver,
        helper,
        employee,
      ];

  /// Comprehensive sample/dummy records for each category (1, 2, 3, 4).
  static const List<UlbDetailItemModel> sampleList = [
    // ------------------- Nagar Nigam -------------------
    UlbDetailItemModel(
      id: '1',
      ulbName: 'Nagar Nigam Dehradun',
      ulbType: 'Nagar Nigam',
      optionCode: 'nn_1',
      wardsRegistered: 98,
      wardsTarget: 100,
      vehiclesRegistered: 215,
      vehiclesTarget: 220,
      d2dVehiclesRegistered: 180,
      d2dVehiclesTarget: 185,
      sanitaryInspector: 18,
      environmentInspector: 12,
      sanitaryWorker: 650,
      driver: 210,
      helper: 230,
      employee: 1120,
    ),
    UlbDetailItemModel(
      id: '2',
      ulbName: 'Nagar Nigam Haridwar',
      ulbType: 'Nagar Nigam',
      optionCode: 'nn_2',
      wardsRegistered: 58,
      wardsTarget: 60,
      vehiclesRegistered: 145,
      vehiclesTarget: 150,
      d2dVehiclesRegistered: 120,
      d2dVehiclesTarget: 130,
      sanitaryInspector: 12,
      environmentInspector: 8,
      sanitaryWorker: 420,
      driver: 140,
      helper: 160,
      employee: 740,
    ),
    UlbDetailItemModel(
      id: '3',
      ulbName: 'Nagar Nigam Haldwani',
      ulbType: 'Nagar Nigam',
      optionCode: 'nn_3',
      wardsRegistered: 57,
      wardsTarget: 60,
      vehiclesRegistered: 135,
      vehiclesTarget: 140,
      d2dVehiclesRegistered: 110,
      d2dVehiclesTarget: 120,
      sanitaryInspector: 10,
      environmentInspector: 7,
      sanitaryWorker: 380,
      driver: 130,
      helper: 145,
      employee: 672,
    ),
    UlbDetailItemModel(
      id: '4',
      ulbName: 'Nagar Nigam Roorkee',
      ulbType: 'Nagar Nigam',
      optionCode: 'nn_4',
      wardsRegistered: 39,
      wardsTarget: 40,
      vehiclesRegistered: 95,
      vehiclesTarget: 100,
      d2dVehiclesRegistered: 80,
      d2dVehiclesTarget: 85,
      sanitaryInspector: 8,
      environmentInspector: 5,
      sanitaryWorker: 290,
      driver: 90,
      helper: 105,
      employee: 498,
    ),

    // ------------------- Nagar Palika Parishad -------------------
    UlbDetailItemModel(
      id: '5',
      ulbName: 'Nagar Palika Parishad Mussoorie',
      ulbType: 'Nagar Palika Parishad',
      optionCode: 'npp_1',
      wardsRegistered: 13,
      wardsTarget: 13,
      vehiclesRegistered: 42,
      vehiclesTarget: 45,
      d2dVehiclesRegistered: 35,
      d2dVehiclesTarget: 38,
      sanitaryInspector: 4,
      environmentInspector: 3,
      sanitaryWorker: 160,
      driver: 40,
      helper: 48,
      employee: 255,
    ),
    UlbDetailItemModel(
      id: '6',
      ulbName: 'Nagar Palika Parishad Nainital',
      ulbType: 'Nagar Palika Parishad',
      optionCode: 'npp_2',
      wardsRegistered: 15,
      wardsTarget: 15,
      vehiclesRegistered: 38,
      vehiclesTarget: 40,
      d2dVehiclesRegistered: 30,
      d2dVehiclesTarget: 32,
      sanitaryInspector: 4,
      environmentInspector: 3,
      sanitaryWorker: 145,
      driver: 36,
      helper: 42,
      employee: 230,
    ),
    UlbDetailItemModel(
      id: '7',
      ulbName: 'Nagar Palika Parishad Rishikesh',
      ulbType: 'Nagar Palika Parishad',
      optionCode: 'npp_3',
      wardsRegistered: 38,
      wardsTarget: 40,
      vehiclesRegistered: 82,
      vehiclesTarget: 88,
      d2dVehiclesRegistered: 70,
      d2dVehiclesTarget: 75,
      sanitaryInspector: 7,
      environmentInspector: 5,
      sanitaryWorker: 260,
      driver: 78,
      helper: 92,
      employee: 442,
    ),
    UlbDetailItemModel(
      id: '8',
      ulbName: 'Nagar Palika Parishad Ramnagar',
      ulbType: 'Nagar Palika Parishad',
      optionCode: 'npp_4',
      wardsRegistered: 20,
      wardsTarget: 20,
      vehiclesRegistered: 48,
      vehiclesTarget: 50,
      d2dVehiclesRegistered: 40,
      d2dVehiclesTarget: 42,
      sanitaryInspector: 5,
      environmentInspector: 3,
      sanitaryWorker: 180,
      driver: 45,
      helper: 52,
      employee: 285,
    ),

    // ------------------- Nagar Panchayat -------------------
    UlbDetailItemModel(
      id: '9',
      ulbName: 'Nagar Panchayat Badrinath',
      ulbType: 'Nagar Panchayat',
      optionCode: 'np_1',
      wardsRegistered: 7,
      wardsTarget: 7,
      vehiclesRegistered: 16,
      vehiclesTarget: 18,
      d2dVehiclesRegistered: 12,
      d2dVehiclesTarget: 14,
      sanitaryInspector: 2,
      environmentInspector: 1,
      sanitaryWorker: 65,
      driver: 15,
      helper: 18,
      employee: 101,
    ),
    UlbDetailItemModel(
      id: '10',
      ulbName: 'Nagar Panchayat Kedarnath',
      ulbType: 'Nagar Panchayat',
      optionCode: 'np_2',
      wardsRegistered: 7,
      wardsTarget: 7,
      vehiclesRegistered: 14,
      vehiclesTarget: 15,
      d2dVehiclesRegistered: 10,
      d2dVehiclesTarget: 12,
      sanitaryInspector: 2,
      environmentInspector: 1,
      sanitaryWorker: 58,
      driver: 14,
      helper: 16,
      employee: 91,
    ),
    UlbDetailItemModel(
      id: '11',
      ulbName: 'Nagar Panchayat Gangotri',
      ulbType: 'Nagar Panchayat',
      optionCode: 'np_3',
      wardsRegistered: 5,
      wardsTarget: 5,
      vehiclesRegistered: 11,
      vehiclesTarget: 12,
      d2dVehiclesRegistered: 9,
      d2dVehiclesTarget: 10,
      sanitaryInspector: 1,
      environmentInspector: 1,
      sanitaryWorker: 45,
      driver: 10,
      helper: 12,
      employee: 69,
    ),
    UlbDetailItemModel(
      id: '12',
      ulbName: 'Nagar Panchayat Yamunotri',
      ulbType: 'Nagar Panchayat',
      optionCode: 'np_4',
      wardsRegistered: 5,
      wardsTarget: 5,
      vehiclesRegistered: 10,
      vehiclesTarget: 12,
      d2dVehiclesRegistered: 8,
      d2dVehiclesTarget: 10,
      sanitaryInspector: 1,
      environmentInspector: 1,
      sanitaryWorker: 42,
      driver: 9,
      helper: 11,
      employee: 64,
    ),
  ];

  /// Filters [sampleList] based on the selected dropdown code.
  /// If [optionCode] is null or 'all', all items are returned.
  /// If it matches an optionCode or a category prefix, matching items are returned.
  static List<UlbDetailItemModel> filterByOption(String? optionCode) {
    if (optionCode == null || optionCode.isEmpty || optionCode == 'all') {
      return sampleList;
    }

    final query = optionCode.trim().toLowerCase();
    final directMatch = sampleList.where((item) => item.optionCode.toLowerCase() == query).toList();
    if (directMatch.isNotEmpty) {
      return directMatch;
    }

    // Category match (e.g., all Nagar Nigam items)
    if (query == 'nn' || query.contains('nigam')) {
      return sampleList.where((item) => item.ulbType == 'Nagar Nigam').toList();
    }
    if (query == 'npp' || query.contains('palika')) {
      return sampleList.where((item) => item.ulbType == 'Nagar Palika Parishad').toList();
    }
    if (query == 'np' || query.contains('panchayat')) {
      return sampleList.where((item) => item.ulbType == 'Nagar Panchayat').toList();
    }

    return sampleList;
  }
}
