import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../passport_exports.dart';

class TravelDocumentDetailsPage extends StatefulWidget {
  const TravelDocumentDetailsPage({super.key});

  @override
  _TravelDocumentDetailsPageState createState() =>
      _TravelDocumentDetailsPageState();
}

class _TravelDocumentDetailsPageState extends State<TravelDocumentDetailsPage> {
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    // Dispatch event to get all passports when the page loads
    context.read<TravelDocumentBloc>().add(
      GetAllTravelDocumentsEvent(limit: 100, skip: 0),
    );
  }

  Future<void> _onRefresh() async {
    setState(() => _isRefreshing = true);
    context.read<TravelDocumentBloc>().add(
      GetAllTravelDocumentsEvent(limit: 100, skip: 0),
    );
    await Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 100));
      final state = context.read<TravelDocumentBloc>().state;
      return state is TravelDocumentLoading;
    });
    setState(() => _isRefreshing = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("Travel Documents", context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: BlocBuilder<TravelDocumentBloc, TravelDocumentState>(
            builder: (context, state) {
              if (state is TravelDocumentLoading && !_isRefreshing) {
                return TravelDocumentsLoadingOverlay();
              }
              if (state is TravelDocumentLoaded) {
                if (state.passports.isEmpty) {
                  return const NoTravelDocument();
                } else {
                  return const AllTravelDocumentsPage();
                }
              }
              if (state is TravelDocumentError) {
                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(height: 200),
                    Center(child: Text(state.message)),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
