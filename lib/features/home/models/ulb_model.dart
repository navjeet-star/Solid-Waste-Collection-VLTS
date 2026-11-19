import 'package:equatable/equatable.dart';
import 'package:vlts_swc/core/network/base_api_response.dart';
import 'package:vlts_swc/models/ulb_progress_item.dart';

/// Top-level response model for the ULB-wise progress API.
/// Extends [BaseApiResponse] to inherit `Code`, `Message`, and `isSuccess`.
class UlbModel extends BaseApiResponse {
  final List<UlbProgressData> ulbWiseProgressList;

  const UlbModel({
    super.code,
    super.message,
    this.ulbWiseProgressList = const [],
  });

  factory UlbModel.fromJson(Map<String, dynamic> json) {
    // Handles both camelCase and PascalCase variations
    final rawList = json['ulbWiseProgressList'] ?? json['UlbWiseProgressList'];
    List<UlbProgressData> list = [];

    if (rawList is List) {
      list = rawList
          .whereType<Map<String, dynamic>>()
          .map((item) => UlbProgressData.fromJson(item))
          .toList();
    }

    return UlbModel(
      code: json['Code']?.toString() ?? json['code']?.toString(),
      message: json['Message']?.toString() ?? json['message']?.toString(),
      ulbWiseProgressList: list,
    );
  }

  Map<String, dynamic> toJson() => {
        'Code': code,
        'Message': message,
        'ulbWiseProgressList':
            ulbWiseProgressList.map((item) => item.toJson()).toList(),
      };

  /// Total number of ULBs returned in the response
  int get totalUlbsCount => ulbWiseProgressList.length;

  /// Whether valid ULB records exist
  bool get hasData => ulbWiseProgressList.isNotEmpty;

  @override
  List<Object?> get props => [code, message, ulbWiseProgressList];
}

/// Metrics and progress item for an individual ULB.
class UlbProgressData extends Equatable {
  final String ulb;
  final String totalWards;
  final String totalWardMapped;
  final String totalWardNotMapped;
  final String wardMappedCoverage;
  final String numberOfVehicles;
  final String vehicleRegistration;
  final String deviceCount;
  final String dataReceiving;
  final String dataNotReceiving;
  final String routeCreated;
  final String routeCreatedWithGeojson;
  final String totalMappedVehiclesWithRouteAndDevice;
  final String fuelCount;
  final String transferCount;
  final String parkingCount;
  final String dustbinCount;
  final String workshopCount;
  final String processingPlantCount;
  final String numberOfEmployees;
  final String employeeCount;

  const UlbProgressData({
    this.ulb = '',
    this.totalWards = '0',
    this.totalWardMapped = '0',
    this.totalWardNotMapped = '0',
    this.wardMappedCoverage = '0',
    this.numberOfVehicles = '0',
    this.vehicleRegistration = '0',
    this.deviceCount = '0',
    this.dataReceiving = '0',
    this.dataNotReceiving = '0',
    this.routeCreated = '0',
    this.routeCreatedWithGeojson = '0',
    this.totalMappedVehiclesWithRouteAndDevice = '0',
    this.fuelCount = '0',
    this.transferCount = '0',
    this.parkingCount = '0',
    this.dustbinCount = '0',
    this.workshopCount = '0',
    this.processingPlantCount = '0',
    this.numberOfEmployees = '0',
    this.employeeCount = '0',
  });

  /// Safe value extractor for dynamic string or numeric values from API
  static String _parseValue(dynamic val) {
    if (val == null) return '0';
    return val.toString().trim();
  }

  factory UlbProgressData.fromJson(Map<String, dynamic> json) {
    return UlbProgressData(
      ulb: json['ULB']?.toString().trim() ?? '',
      totalWards: _parseValue(json['TotalWards']),
      totalWardMapped: _parseValue(json['TotalWardMapped']),
      totalWardNotMapped: _parseValue(json['TotalWardNotMapped']),
      wardMappedCoverage: _parseValue(json['WardMappedCoverage']),
      numberOfVehicles: _parseValue(json['NumberOfVehicles']),
      vehicleRegistration: _parseValue(json['VehicleRegistration']),
      deviceCount: _parseValue(json['DeviceCount']),
      dataReceiving: _parseValue(json['DataReceiving']),
      dataNotReceiving: _parseValue(json['DataNotReceiving']),
      routeCreated: _parseValue(json['RouteCreated']),
      routeCreatedWithGeojson: _parseValue(json['RouteCreatedWithGeojson']),
      totalMappedVehiclesWithRouteAndDevice:
          _parseValue(json['TotalMappedVehiclesWithRouteAndDevice']),
      fuelCount: _parseValue(json['FuelCount']),
      transferCount: _parseValue(json['TransferCount']),
      parkingCount: _parseValue(json['ParkingCount']),
      dustbinCount: _parseValue(json['DustbinCount']),
      workshopCount: _parseValue(json['WorkshopCount']),
      processingPlantCount: _parseValue(json['ProcessingPlantCount']),
      numberOfEmployees: _parseValue(json['NumberOfEmployees']),
      employeeCount: _parseValue(json['EmployeeCount']),
    );
  }

  Map<String, dynamic> toJson() => {
        'ULB': ulb,
        'TotalWards': totalWards,
        'TotalWardMapped': totalWardMapped,
        'TotalWardNotMapped': totalWardNotMapped,
        'WardMappedCoverage': wardMappedCoverage,
        'NumberOfVehicles': numberOfVehicles,
        'VehicleRegistration': vehicleRegistration,
        'DeviceCount': deviceCount,
        'DataReceiving': dataReceiving,
        'DataNotReceiving': dataNotReceiving,
        'RouteCreated': routeCreated,
        'RouteCreatedWithGeojson': routeCreatedWithGeojson,
        'TotalMappedVehiclesWithRouteAndDevice':
            totalMappedVehiclesWithRouteAndDevice,
        'FuelCount': fuelCount,
        'TransferCount': transferCount,
        'ParkingCount': parkingCount,
        'DustbinCount': dustbinCount,
        'WorkshopCount': workshopCount,
        'ProcessingPlantCount': processingPlantCount,
        'NumberOfEmployees': numberOfEmployees,
        'EmployeeCount': employeeCount,
      };

  // -------------------------------------------------------------
  // Convenient Typed Numeric Getters (Safe against string/number types)
  // -------------------------------------------------------------
  int get totalWardsInt => int.tryParse(totalWards) ?? 0;
  int get totalWardMappedInt => int.tryParse(totalWardMapped) ?? 0;
  int get totalWardNotMappedInt => int.tryParse(totalWardNotMapped) ?? 0;
  int get numberOfVehiclesInt => int.tryParse(numberOfVehicles) ?? 0;
  int get deviceCountInt => int.tryParse(deviceCount) ?? 0;
  int get dataReceivingInt => int.tryParse(dataReceiving) ?? 0;
  int get dataNotReceivingInt => int.tryParse(dataNotReceiving) ?? 0;
  int get routeCreatedInt => int.tryParse(routeCreated) ?? 0;
  int get fuelCountInt => int.tryParse(fuelCount) ?? 0;
  int get dustbinCountInt => int.tryParse(dustbinCount) ?? 0;
  int get employeesInt =>
      int.tryParse(numberOfEmployees) ?? (int.tryParse(employeeCount) ?? 0);

  /// Double percentage for progress bars and circular indicators
  double get coverageDouble =>
      double.tryParse(wardMappedCoverage.replaceAll('%', '').trim()) ?? 0.0;

  /// Helper to convert API [UlbProgressData] to existing UI [UlbProgressItem] widget model
  UlbProgressItem toUlbProgressItem({int rank = 1}) {
    return UlbProgressItem(
      rank: rank,
      ulbName: ulb.isNotEmpty ? ulb : 'ULB $rank',
      fleetActive: '$dataReceiving/$numberOfVehicles',
      routeCoverage: coverageDouble,
      tripsDone: routeCreatedInt,
      notReporting: '$dataNotReceiving ($totalWardNotMapped)',
      score: coverageDouble.toInt(),
    );
  }

  @override
  List<Object?> get props => [
        ulb,
        totalWards,
        totalWardMapped,
        totalWardNotMapped,
        wardMappedCoverage,
        numberOfVehicles,
        vehicleRegistration,
        deviceCount,
        dataReceiving,
        dataNotReceiving,
        routeCreated,
        routeCreatedWithGeojson,
        totalMappedVehiclesWithRouteAndDevice,
        fuelCount,
        transferCount,
        parkingCount,
        dustbinCount,
        workshopCount,
        processingPlantCount,
        numberOfEmployees,
        employeeCount,
      ];
}
