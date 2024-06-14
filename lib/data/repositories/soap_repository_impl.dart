import 'package:myapp/data/datasources/soap_remote_datasource.dart';
import 'package:myapp/domain/entities/soap_response.dart';
import 'package:myapp/domain/repositories/soap_repository.dart';
import 'package:myapp/data/models/soap_response_model.dart';

class SoapRepositoryImpl implements SoapRepository {
  final SoapRemoteDataSource remoteDataSource;

  SoapRepositoryImpl(this.remoteDataSource);

  @override
  Future<SoapResponse> getSoapData() async {
    final result = await remoteDataSource.fetchSoapData();
    return SoapResponseModel.fromXml(result).toEntity();
  }
  
}
