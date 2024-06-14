import 'package:xml/xml.dart' as xml;

import '../../domain/entities/soap_response.dart';

class SoapResponseModel {
  final String result;

  SoapResponseModel({required this.result});

  factory SoapResponseModel.fromXml(String xmlString) {
    //Aqui se parse el XML y se obtien el resultado
    final document = xml.XmlDocument.parse(xmlString);
    final resultElement = document.findAllElements('elementName').first;
    return SoapResponseModel(result: resultElement.value ?? '');
  }

  SoapResponse toEntity() {
    return SoapResponse(result: result);
  }
}
