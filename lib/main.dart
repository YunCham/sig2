import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:myapp/data/datasources/soap_remote_datasource.dart';
import 'package:myapp/data/repositories/soap_repository_impl.dart';
import 'package:myapp/domain/usecases/get_soap_data.dart';
import 'package:myapp/presentation/bloc/soap_bloc.dart';
import 'package:myapp/presentation/screens/soap_screen.dart';

void main() {
  final dio = Dio();
  final soapRemoteDataSource = SoapRemoteDataSource(dio: dio);
  final soapRepository = SoapRepositoryImpl(soapRemoteDataSource);
  final getSoapData = GetSoapData(soapRepository);

  runApp(MyApp(getSoapData: getSoapData));
}

class MyApp extends StatelessWidget {
  final GetSoapData getSoapData;

  MyApp({required this.getSoapData});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider.value(value: getSoapData), // Añadir esta línea
        BlocProvider(create: (context) => SoapBloc(context.read<GetSoapData>())),
      ],
      child: const MaterialApp(
        home: SoapScreen(),
      ),
    );
  }
}
