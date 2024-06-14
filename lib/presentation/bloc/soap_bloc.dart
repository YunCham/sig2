import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/soap_response.dart';
import '../../domain/usecases/get_soap_data.dart';

part 'soap_event.dart';
part 'soap_state.dart';

class SoapBloc extends Bloc<SoapEvent, SoapState> {
  // SoapBloc() : super(SoapInitial()) {
  //   on<SoapEvent>((event, emit) {
  //     // TODO: implement event handler
  //   });
  // }
  final GetSoapData getSoapData;

  SoapBloc(this.getSoapData) : super(SoapInitial()) {
    on<FetchSoapData>((event, emit) async {
      emit(SoapLoading());
      try {
        final soapData = await getSoapData.execute();
        emit(SoapLoaded(soapData));
      } catch (e) {
        emit(SoapError(e.toString()));
      }
    });
  }
}
