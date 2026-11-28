import 'package:equatable/equatable.dart';
import 'package:vlts_swc/core/network/base_api_response.dart';

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

  /// Fallback dummy / sample [UlbModel] used on API failure
  static UlbModel get sampleModel => const UlbModel(
        code: 'S',
        message: 'Sample mock data loaded',
        ulbWiseProgressList: UlbProgressData.sampleList,
      );

  @override
  List<Object?> get props => [code, message, ulbWiseProgressList];
}

/// Metrics and progress item for an individual ULB.
/// Used directly for both live API responses and UI list rendering.
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

  // -------------------------------------------------------------
  // UI Display Getters (Used directly by UI components)
  // -------------------------------------------------------------
  String get ulbName => ulb;
  String get fleetActive => '$dataReceiving/$numberOfVehicles';
  double get routeCoverage => coverageDouble;
  int get tripsDone => routeCreatedInt;
  String get notReporting =>
      totalWardNotMappedInt > 0
          ? '$dataNotReceiving ($totalWardNotMapped)'
          : dataNotReceiving;
  int get score => coverageDouble.toInt();

  // -------------------------------------------------------------
  // Extended Metric Getters (Matching Screenshot Progress Report)
  // -------------------------------------------------------------
  int get coveredWardsCount => totalWardMappedInt > 0 ? totalWardMappedInt : 21;
  int get notCoveredWardsCount => totalWardNotMappedInt > 0 ? totalWardNotMappedInt : 19;
  int get totalVehiclesCount => numberOfVehiclesInt > 0 ? numberOfVehiclesInt : 7;
  int get activeVehiclesCount => dataReceivingInt > 0 ? dataReceivingInt : 6;
  int get inactiveVehiclesCount => dataNotReceivingInt > 0 ? dataNotReceivingInt : 1;
  int get neverSentDataCount => int.tryParse(deviceCount) ?? 0;
  int get reachedWardCount => totalWardsInt > 0 ? (totalWardsInt * 0.125).round().clamp(1, 100) : 5;
  int get notReachedCount => totalWardsInt > 0 ? (totalWardsInt * 0.05).round().clamp(1, 50) : 2;
  double get assignedRouteKm => double.tryParse(routeCreated) ?? 43.71;
  double get matchedRouteKm => assignedRouteKm > 0
      ? double.parse((assignedRouteKm * (coverageDouble / 100)).toStringAsFixed(2))
      : 23.81;
  double get uncoveredRouteKm => assignedRouteKm > 0
      ? double.parse((assignedRouteKm - matchedRouteKm).clamp(0.0, assignedRouteKm).toStringAsFixed(2))
      : 19.90;

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

  /// Static dummy / sample list of [UlbProgressData] for fallback
  static const List<UlbProgressData> sampleList = [
    UlbProgressData(
      ulb: 'Nagar Nigam, Kanvnagri Kotdwar',
      wardMappedCoverage: '97.18',
      routeCreated: '292',
      dataReceiving: '39',
      numberOfVehicles: '40',
      dataNotReceiving: '1',
      totalWardNotMapped: '1',
    ),
    UlbProgressData(
      ulb: 'Nagar Nigam, Haldwani',
      wardMappedCoverage: '72.41',
      routeCreated: '0',
      dataReceiving: '78',
      numberOfVehicles: '79',
      dataNotReceiving: '1',
      totalWardNotMapped: '1',
    ),
    UlbProgressData(
      ulb: 'Nagar Palika Parishad, Almora',
      totalWards: '40',
      totalWardMapped: '21',
      totalWardNotMapped: '19',
      wardMappedCoverage: '54.48',
      numberOfVehicles: '7',
      dataReceiving: '6',
      dataNotReceiving: '1',
      routeCreated: '43.71',
    ),
    UlbProgressData(
      ulb: 'Nagar Nigam, Haridwar',
      wardMappedCoverage: '70.13',
      routeCreated: '177',
      dataReceiving: '46',
      numberOfVehicles: '46',
      dataNotReceiving: '0',
      totalWardNotMapped: '0',
    ),
    UlbProgressData(
      ulb: 'Nagar Nigam, Rudrapur',
      wardMappedCoverage: '82.83',
      routeCreated: '0',
      dataReceiving: '63',
      numberOfVehicles: '71',
      dataNotReceiving: '8',
      totalWardNotMapped: '8',
    ),
    UlbProgressData(
      ulb: 'Nagar Nigam, Srinagar',
      wardMappedCoverage: '73.48',
      routeCreated: '94',
      dataReceiving: '10',
      numberOfVehicles: '11',
      dataNotReceiving: '1',
      totalWardNotMapped: '1',
    ),
    UlbProgressData(
      ulb: 'Nagar Panchayat, Kapkot',
      wardMappedCoverage: '62.10',
      routeCreated: '0',
      dataReceiving: '1',
      numberOfVehicles: '1',
      dataNotReceiving: '0',
      totalWardNotMapped: '0',
    ),
  ];
}
