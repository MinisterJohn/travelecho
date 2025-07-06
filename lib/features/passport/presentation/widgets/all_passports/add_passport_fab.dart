import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../passport_exports.dart';

class AddTravelDocumentFab extends StatelessWidget {
  const AddTravelDocumentFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      onPressed: () {
        AppNavigator.push(
          context,
          BlocProvider.value(
            value: sl<TravelDocumentBloc>(),
            child: AddEditTravelDocumentPage(),
          ),
        );
      },
      child: Icon(Icons.add),
    );
  }
}
