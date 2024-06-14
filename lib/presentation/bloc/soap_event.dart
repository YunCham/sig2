part of 'soap_bloc.dart';

@immutable
sealed class SoapEvent {}

final class FetchSoapData extends SoapEvent {}