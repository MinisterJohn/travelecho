import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelecho/features/profile/data/models/occupations_model.dart';
import 'package:travelecho/features/profile/domain/usecases/occupations_list_usecase.dart';
import 'package:travelecho/features/profile/domain/usecases/school_list_usecase.dart';
import 'package:travelecho/service_locator.dart';
import 'data_search_event.dart';
import 'data_search_state.dart';

class DataSearchBloc extends Bloc<DataSearchEvent, DataSearchState> {
  DataSearchBloc() : super(DataSearchInitial()) {
    on<SchoolListRequested>((event, emit) async {
      // Corrected event name
      emit(DataSearchLoading());

      final result = await sl<GetSchoolList>().getList(event.schoolHint);

      result.fold(
        (failure) => emit(DataSearchError(failure)),
        (schools) => emit(SchoolListLoaded(schools)),
      );
    });
    on<OccupationsRequested>((event, emit) async {
      // Corrected event name
      emit(DataSearchLoading());

      final occupations =
          await sl<GetOccupations>().getOccupationsList(event.occupationHint);

      emit(OccupationsLoaded(occupations));
    });

    on<ClearSchoolList>((event, emit) async {
      emit(SchoolListLoaded([]));
    });
    on<ClearOccupationList>((event, emit) async {
      emit(OccupationsLoaded(OccupationsModel(occupations: [])));
    });
  }
}
