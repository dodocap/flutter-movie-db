import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui_event.freezed.dart';

@freezed
sealed class UiEvent with _$UiEvent {
  const factory UiEvent.showSnackBar(String msg) = ShowSnackBar;
}