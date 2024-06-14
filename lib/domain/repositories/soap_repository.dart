import '../../domain/entities/soap_response.dart';

abstract class SoapRepository {
  Future<SoapResponse> getSoapData();
}
