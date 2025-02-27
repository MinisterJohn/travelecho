import "package:dio/dio.dart";
import "package:get_it/get_it.dart";
import "package:travelecho/core/network/dio_client.dart";
import "package:travelecho/features/auth/data/repository/auth_repository_data.dart";
import "package:travelecho/features/auth/data/sources/auth_api_service.dart";
import "package:travelecho/features/auth/domain/repository/auth_repository.dart";
import "package:travelecho/features/auth/domain/usecases/auth_usecases.dart";
import "package:travelecho/features/auth/presentation/bloc/user_bloc.dart";
import "package:travelecho/features/currency_converter/data/repository/currency_repository_impl.dart";
import "package:travelecho/features/currency_converter/data/sources/currency_remote_source.dart";
import "package:travelecho/features/currency_converter/domain/repository/currency_repository.dart";
import "package:travelecho/features/currency_converter/domain/usecases/convert_currency_usecase.dart";
import "package:travelecho/features/currency_converter/presentation/blocs/currency_bloc.dart";
import "package:travelecho/features/profile/data/repository/languages_repository_impl.dart";
import "package:travelecho/features/profile/data/repository/interests_repository_impl.dart";
import "package:travelecho/features/profile/data/repository/occupations_repository_impl.dart";
import "package:travelecho/features/profile/data/repository/schools_repository_impl.dart";
import "package:travelecho/features/profile/data/sources/interests_local_source.dart";
import "package:travelecho/features/profile/data/sources/language_local_source.dart";
import "package:travelecho/features/profile/data/sources/occupations_local_source.dart";
import "package:travelecho/features/profile/data/sources/schools_remote_source.dart";
import "package:travelecho/features/profile/domain/repository/languages_repository.dart";
import "package:travelecho/features/profile/domain/repository/occupations_repository.dart";
import "package:travelecho/features/profile/domain/repository/interests_repository.dart";
import "package:travelecho/features/profile/domain/repository/schools_repository.dart";
import "package:travelecho/features/profile/domain/usecases/interests_usecase.dart";
import "package:travelecho/features/profile/domain/usecases/languages_usecase.dart";
import "package:travelecho/features/profile/domain/usecases/occupations_list_usecase.dart";
import "package:travelecho/features/profile/domain/usecases/school_list_usecase.dart";
import "package:travelecho/features/profile/presentation/blocs/data_search_bloc.dart";
import "package:travelecho/features/profile/presentation/blocs/profile_bloc.dart";

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());
  sl.registerSingleton<Dio>(Dio());

  //services
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerLazySingleton<CurrencyRemoteSource>(
      () => CurrencyRemoteSourceImpl());
  sl.registerLazySingleton<SchoolRemoteSource>(() => SchoolRemoteSourceImpl());
  sl.registerLazySingleton<OccupationsLocalSource>(
      () => OccupationsLocalSourceImpl());
  sl.registerLazySingleton<LanguageLocalSource>(
      () => LanguageLocalSourceImpl());
  sl.registerLazySingleton<InterestLocalSource>(
      () => InterestLocalSourceImpl());

//Repository
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerLazySingleton<CurrencyRepository>(() => CurrencyRepositoryImpl());
  sl.registerLazySingleton<SchoolRepository>(() => SchoolRepositoryImpl());
  sl.registerLazySingleton<OccupationsRepository>(
      () => OccupationsRepositoryImpl());
  sl.registerLazySingleton<LanguagesRepository>(
      () => LanguagesRepositoryImpl());
  sl.registerLazySingleton<InterestsRepository>(
      () => InterestsRepositoryImpl());

//usecases
  sl.registerLazySingleton<SignupUseCase>(() => SignupUseCase());
  sl.registerLazySingleton<SigninUseCase>(() => SigninUseCase());
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
  sl.registerSingleton<IsNotNewUserUseCase>(IsNotNewUserUseCase());
  sl.registerLazySingleton(() => ConvertCurrency());
  sl.registerLazySingleton(() => GetCurrencyList());
  sl.registerLazySingleton(() => GetSchoolList());
  sl.registerLazySingleton(() => GetOccupations());
  sl.registerLazySingleton(() => GetLanguages());
  sl.registerLazySingleton(() => GetInterests());

  //blocs
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc());
  sl.registerLazySingleton<CurrencyBloc>(() => CurrencyBloc());
  sl.registerLazySingleton<DataSearchBloc>(() => DataSearchBloc());
  sl.registerLazySingleton<ProfileBloc>(() => ProfileBloc());
}
