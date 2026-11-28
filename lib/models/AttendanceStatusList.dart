import 'dart:convert';


AttendanceStatusList attendanceStatusListFromJson(String str) => AttendanceStatusList.fromJson(json.decode(str));
String attendanceStatusListToJson(AttendanceStatusList data) => json.encode(data.toJson());
class AttendanceStatusList {
  AttendanceStatusList({
      String? ulbid, 
      String? uLBName, 
      String? totalEmployee, 
      String? presentCount, 
      String? absentCount, 
      String? leaveCount, 
      String? notMarkedCount, 
      String? presentPercentage, 
      String? absentPercentage, 
      String? leavePercentage, 
      String? notMarkedPercentage, 
      String? uLBTypeName,}){
    _ulbid = ulbid;
    _uLBName = uLBName;
    _totalEmployee = totalEmployee;
    _presentCount = presentCount;
    _absentCount = absentCount;
    _leaveCount = leaveCount;
    _notMarkedCount = notMarkedCount;
    _presentPercentage = presentPercentage;
    _absentPercentage = absentPercentage;
    _leavePercentage = leavePercentage;
    _notMarkedPercentage = notMarkedPercentage;
    _uLBTypeName = uLBTypeName;
}

  AttendanceStatusList.fromJson(dynamic json) {
    _ulbid = json['ULBID'];
    _uLBName = json['ULBName'];
    _totalEmployee = json['TotalEmployee'];
    _presentCount = json['PresentCount'];
    _absentCount = json['AbsentCount'];
    _leaveCount = json['LeaveCount'];
    _notMarkedCount = json['NotMarkedCount'];
    _presentPercentage = json['PresentPercentage'];
    _absentPercentage = json['AbsentPercentage'];
    _leavePercentage = json['LeavePercentage'];
    _notMarkedPercentage = json['NotMarkedPercentage'];
    _uLBTypeName = json['ULBTypeName'];
  }
  String? _ulbid;
  String? _uLBName;
  String? _totalEmployee;
  String? _presentCount;
  String? _absentCount;
  String? _leaveCount;
  String? _notMarkedCount;
  String? _presentPercentage;
  String? _absentPercentage;
  String? _leavePercentage;
  String? _notMarkedPercentage;
  String? _uLBTypeName;
AttendanceStatusList copyWith({  String? ulbid,
  String? uLBName,
  String? totalEmployee,
  String? presentCount,
  String? absentCount,
  String? leaveCount,
  String? notMarkedCount,
  String? presentPercentage,
  String? absentPercentage,
  String? leavePercentage,
  String? notMarkedPercentage,
  String? uLBTypeName,
}) => AttendanceStatusList(  ulbid: ulbid ?? _ulbid,
  uLBName: uLBName ?? _uLBName,
  totalEmployee: totalEmployee ?? _totalEmployee,
  presentCount: presentCount ?? _presentCount,
  absentCount: absentCount ?? _absentCount,
  leaveCount: leaveCount ?? _leaveCount,
  notMarkedCount: notMarkedCount ?? _notMarkedCount,
  presentPercentage: presentPercentage ?? _presentPercentage,
  absentPercentage: absentPercentage ?? _absentPercentage,
  leavePercentage: leavePercentage ?? _leavePercentage,
  notMarkedPercentage: notMarkedPercentage ?? _notMarkedPercentage,
  uLBTypeName: uLBTypeName ?? _uLBTypeName,
);
  String? get ulbid => _ulbid;
  String? get uLBName => _uLBName;
  String? get totalEmployee => _totalEmployee;
  String? get presentCount => _presentCount;
  String? get absentCount => _absentCount;
  String? get leaveCount => _leaveCount;
  String? get notMarkedCount => _notMarkedCount;
  String? get presentPercentage => _presentPercentage;
  String? get absentPercentage => _absentPercentage;
  String? get leavePercentage => _leavePercentage;
  String? get notMarkedPercentage => _notMarkedPercentage;
  String? get uLBTypeName => _uLBTypeName;

  // Convenient typed helpers for UI and filters
  int get totalStaff =>
      int.tryParse(_totalEmployee ?? '') ??
      (present + absent + leave + notMarked);
  int get present => int.tryParse(_presentCount ?? '') ?? 0;
  int get absent => int.tryParse(_absentCount ?? '') ?? 0;
  int get leave => int.tryParse(_leaveCount ?? '') ?? 0;
  int get notMarked => int.tryParse(_notMarkedCount ?? '') ?? 0;
  String get ulbName => _uLBName ?? '';
  String get ulbTypeName => _uLBTypeName ?? '';

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ULBID'] = _ulbid;
    map['ULBName'] = _uLBName;
    map['TotalEmployee'] = _totalEmployee;
    map['PresentCount'] = _presentCount;
    map['AbsentCount'] = _absentCount;
    map['LeaveCount'] = _leaveCount;
    map['NotMarkedCount'] = _notMarkedCount;
    map['PresentPercentage'] = _presentPercentage;
    map['AbsentPercentage'] = _absentPercentage;
    map['LeavePercentage'] = _leavePercentage;
    map['NotMarkedPercentage'] = _notMarkedPercentage;
    map['ULBTypeName'] = _uLBTypeName;
    return map;
  }

  /// Factory constructor to convert from [UlbProgressData] for fallback
  factory AttendanceStatusList.dummyData(dynamic data) {
    if (data == null) {
      return AttendanceStatusList(
        uLBName: '',
        totalEmployee: '0',
        presentCount: '0',
        absentCount: '0',
        leaveCount: '0',
        notMarkedCount: '0',
      );
    }
    final emp = int.tryParse(data.numberOfEmployees?.toString() ?? '') ??
        (int.tryParse(data.employeeCount?.toString() ?? '') ?? 0);
    final vehicles = int.tryParse(data.numberOfVehicles?.toString() ?? '') ?? 0;
    final total = emp > 0 ? emp : (vehicles > 0 ? vehicles * 2 : 25);
    final present = (total * 0.75).round().clamp(1, total);
    final absent = (total * 0.10).round();
    final leave = (total * 0.05).round();
    final notMarked = (total - present - absent - leave).clamp(0, total);

    final name = data.ulbName?.toString() ?? data.ulb?.toString() ?? '';
    final typeName = name.toLowerCase().contains('nigam')
        ? 'Nagar Nigam'
        : (name.toLowerCase().contains('panchayat')
            ? 'Nagar Panchayat'
            : 'Nagar Palika');

    return AttendanceStatusList(
      uLBName: name,
      totalEmployee: total.toString(),
      presentCount: present.toString(),
      absentCount: absent.toString(),
      leaveCount: leave.toString(),
      notMarkedCount: notMarked.toString(),
      uLBTypeName: typeName,
    );
  }

  /// Sample mock list for testing and offline fallback
  static List<AttendanceStatusList> get sampleList => [
        AttendanceStatusList(
          ulbid: '248441',
          uLBName: 'Nagar Nigam, Kanvnagri Kotdwar',
          totalEmployee: '80',
          presentCount: '62',
          absentCount: '6',
          leaveCount: '4',
          notMarkedCount: '8',
          uLBTypeName: 'Nagar Nigam',
        ),
        AttendanceStatusList(
          ulbid: '248459',
          uLBName: 'Nagar Nigam, Haldwani',
          totalEmployee: '152',
          presentCount: '118',
          absentCount: '12',
          leaveCount: '8',
          notMarkedCount: '14',
          uLBTypeName: 'Nagar Nigam',
        ),
        AttendanceStatusList(
          ulbid: '248449',
          uLBName: 'Nagar Palika Parishad, Almora',
          totalEmployee: '130',
          presentCount: '98',
          absentCount: '12',
          leaveCount: '5',
          notMarkedCount: '15',
          uLBTypeName: 'Nagar Palika',
        ),
        AttendanceStatusList(
          ulbid: '248485',
          uLBName: 'Nagar Nigam, Haridwar',
          totalEmployee: '544',
          presentCount: '410',
          absentCount: '44',
          leaveCount: '25',
          notMarkedCount: '65',
          uLBTypeName: 'Nagar Nigam',
        ),
      ];
}

/// Backwards compatibility alias for attendance record item
typedef UlbAttendanceItem = AttendanceStatusList;