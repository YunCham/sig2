part of 'soap_bloc.dart';

@immutable
sealed class SoapState {}

final class SoapInitial extends SoapState {}

final class SoapLoading extends SoapState {}

final class SoapLoaded extends SoapState {
  final SoapResponse response;
  SoapLoaded(this.response);
}

final class SoapError extends SoapState {
  final String message;
  SoapError(this.message);
}
