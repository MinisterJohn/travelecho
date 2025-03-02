library data_search_bloc;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelecho/features/profile/data/models/languages_model.dart';
import 'package:travelecho/features/profile/data/models/occupations_model.dart';
import 'package:travelecho/features/profile/data/models/schools_list_model.dart';
import 'package:travelecho/features/profile/data/models/interests_model.dart';
import 'package:travelecho/features/profile/domain/usecases/interests_usecase.dart';
import 'package:travelecho/features/profile/domain/usecases/languages_usecase.dart';
import 'package:travelecho/features/profile/domain/usecases/occupations_list_usecase.dart';
import 'package:travelecho/features/profile/domain/usecases/school_list_usecase.dart';
import 'package:travelecho/service_locator.dart';
import 'package:equatable/equatable.dart';

// import 'data_search_event.dart';
part 'data_search_event.dart';
part 'data_search_state.dart';

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
      print("occupations loading bloc");

      final occupations =
          await sl<GetOccupations>().getOccupationsList(event.occupationHint);

      emit(OccupationsLoaded(occupations));
      print("occupations loaded bloc");
    });
    on<LanguagesRequested>((event, emit) async {
      // Corrected event name
      emit(DataSearchLoading());

      final languages =
          await sl<GetLanguages>().getLanguagesList(event.languageHint);
      emit(LanguagesLoaded(languages));
    });
    on<InterestsRequested>((event, emit) async {
      // Corrected event name
      emit(DataSearchLoading());

      final interests =
          await sl<GetInterests>().getInterestsList(event.interestHint);
      emit(InterestsLoaded(interests));
    });

    on<ClearSearchResults>((event, emit) async {
      switch (event.type) {
        case SearchType.school:
          emit(SchoolListLoaded(const []));
          break;
        case SearchType.occupation:
          emit(OccupationsLoaded(const OccupationsModel(occupations: [])));
          break;
        case SearchType.language:
          emit(LanguagesLoaded(const []));
          break;
        case SearchType.interest:
          emit(InterestsLoaded(const []));
          break;
      }
    });
  }
}
