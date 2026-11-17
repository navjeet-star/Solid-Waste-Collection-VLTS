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

  /// Convenient helper to check if the API returned a success status ("S").
  bool get isSuccess => code?.toUpperCase() == CommonConstants.successCode;

  @override
  List<Object?> get props => [code, message];
}

