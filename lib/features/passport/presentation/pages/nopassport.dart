import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelecho/features/profile/profile_exports.dart';

class NoTravelDocument extends StatelessWidget {
  const NoTravelDocument({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upload your TravelDocuments',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        WidgetsSpacer.verticalSpacer48,

        Center(child: Image.asset('assets/NoResultFound.png', height: 100)),
        WidgetsSpacer.verticalSpacer20,
        const Center(
          child: Text(
            'Nothing to see here!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        WidgetsSpacer.verticalSpacer20,
        const Center(
          child: Text(
            'Your passports will appear here.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),
        WidgetsSpacer.verticalSpacer20,

        Center(
          child: ElevatedButton(
            onPressed: () {
              AppNavigator.push(
                context,
                BlocProvider.value(
                  value: sl<TravelDocumentBloc>(),
                  child: AddEditTravelDocumentPage(),
                ),

                // MultiBlocProvider(
                //   providers: [
                //     BlocProvider.value(value: sl<CurrencyBloc>()),
                //     BlocProvider.value(value: sl<BudgetBloc>()),
                //   ],
                //   child: BlocBuilder<CurrencyBloc, CurrencyState>(
                //     builder: (context, state) {
                //       return AddExpensePage(
                //         budget: budget,
                //         mergedCurrencies:
                //             state is MergedCurrencyListLoaded
                //                 ? state.currencies
                //                 : [],
                //       );
                //     },
                //   ),
                // ),
              );
            },

            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Upload your TravelDocuments',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.add, color: Colors.white),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
