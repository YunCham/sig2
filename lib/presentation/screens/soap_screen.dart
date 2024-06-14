import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_soap_data.dart';
import '../bloc/soap_bloc.dart';

class SoapScreen extends StatelessWidget {
  const SoapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SOAP Request :('),
      ),
      body: BlocProvider(
        create: (context) => SoapBloc(context.read<GetSoapData>())..add(FetchSoapData()),
        child: BlocBuilder<SoapBloc, SoapState>(
          builder: (context, state) {
            if (state is SoapInitial) {
              return _buildInitialState();
            } else if (state is SoapLoading) {
              return _buildLoadingState();
            } else if (state is SoapLoaded) {
              return _buildLoadedState(state);
            } else if (state is SoapError) {
              return _buildErrorState(state);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildInitialState() {
    return const Center(child: Text('Waiting for response...'));
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildLoadedState(SoapLoaded state) {
    return Center(child: Text(state.response.result));
  }

  Widget _buildErrorState(SoapError state) {
    return Center(child: Text(state.message));
  }
}
