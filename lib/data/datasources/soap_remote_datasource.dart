import 'package:dio/dio.dart';

class SoapRemoteDataSource {
  final String url = 'http://190.171.244.211:8080/wsVarios/wsBS.asmx';
  final String soapAction = 'http://activebs.net/W2Corte_ReporteParaCortesSIG';
  final Dio dio;

  SoapRemoteDataSource({Dio? dio}) : dio = dio ?? Dio() {
    // Habilitar el logging de Dio
    this
        .dio
        .interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
  }

  Future<String> fetchSoapData() async {
    const String envelope = '''
    <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <soap:Body>
    <W2Corte_ReporteParaCortesSIG xmlns="http://activebs.net/">
      <parameter1>0</parameter1>
      <parameter2>0</parameter2>
      <parameter3>0</parameter3>
    </W2Corte_ReporteParaCortesSIG>
    </soap:Body>
    </soap:Envelope>
    ''';

    try {
      final response = await dio.post(
        url,
        data: envelope,
        options: Options(
          headers: {
            'Content-Type': 'text/xml; charset=utf-8',
            'SOAPAction': soapAction,
          },
          validateStatus: (status) {
            return status! <
                500; // Permitir capturar errores 400 sin lanzar excepción
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
            'Failed to fetch data from SOAP API: ${response.statusCode} ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to fetch data from SOAP API: $e');
    }
  }
}
