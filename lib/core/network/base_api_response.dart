import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common_utils/common_constants.dart';

/// Base response class for API models containing common fields: Code and Message.
abstract class BaseApiResponse extends Equatable {
  @JsonKey(name: 'Code')
  final String? code;

  @JsonKey(name: 'Message')
  final String? message;

  const BaseApiResponse({
    this.code,
    this.message,
  });

  /// Convenient helper to check if the API returned a success status ("S" or 200).
  bool get isSuccess =>
      code?.toUpperCase() == CommonConstants.successCode ||
      code == '200' ||
      code?.toUpperCase() == 'SUCCESS' ||
      code?.toUpperCase() == 'TRUE';

  @override
  List<Object?> get props => [code, message];
}

/// Standardized generic API response envelope across all modules:
/// Contains [code], [message], [data], and [isSuccess].
class ApiResponse<T> extends BaseApiResponse {
  final T? data;

  const ApiResponse({
    super.code,
    super.message,
    this.data,
  });

  factory ApiResponse.success(T? data, {String? message, String? code}) {
    return ApiResponse<T>(
      code: code ?? CommonConstants.successCode,
      message: message ?? 'Success',
      data: data,
    );
  }

  factory ApiResponse.error(String message, {String? code}) {
    return ApiResponse<T>(
      code: code ?? 'F',
      message: message,
      data: null,
    );
  }

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return ApiResponse<T>(
      code: json['Code']?.toString() ??
          json['code']?.toString() ??
          json['status']?.toString(),
      message: json['Message']?.toString() ?? json['message']?.toString(),
      data: json['Data'] != null
          ? fromJsonT(json['Data'])
          : (json['data'] != null ? fromJsonT(json['data']) : null),
    );
  }

  @override
  List<Object?> get props => [code, message, data];
}
