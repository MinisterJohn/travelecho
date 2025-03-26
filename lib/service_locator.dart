import "package:dio/dio.dart";
import "package:get_it/get_it.dart";
import 'features/features_exports.dart';


final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());
  sl.registerSingleton<Dio>(Dio());

  //services
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerLazySingleton<CurrencyRemoteSource>(
      () => CurrencyRemoteSourceImpl());
  sl.registerLazySingleton<SchoolRemoteSource>(() => SchoolRemoteSourceImpl());
  sl.registerLazySingleton<LocationRemoteSource>(
      () => LocationRemoteSourceImpl());
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
  sl.registerLazySingleton<LocationRepository>(() => LocationRepositoryImpl());
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
  sl.registerLazySingleton(() => GetLocationList());
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
