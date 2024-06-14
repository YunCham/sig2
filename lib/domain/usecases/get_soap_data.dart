import '../../domain/repositories/soap_repository.dart';
import '../../domain/entities/soap_response.dart';

class GetSoapData {
  final SoapRepository repository;
  

  GetSoapData(this.repository);

  // Future<String> call() async {
  //   final result = await repository.getSoapData();
  //   return result.result;
  // }
  Future<SoapResponse> execute() {
    return repository.getSoapData();
  }
}
