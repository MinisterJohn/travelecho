import "package:dio/dio.dart";
import "package:get_it/get_it.dart";
import 'features/features_exports.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);

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
  sl.registerLazySingleton<AmadeusApiService>(() => AmadeusApiService());
  sl.registerLazySingleton<AirlineApiService>(() => AirlineApiService());

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

  sl.registerLazySingleton<AirportRepository>(() => AirportRepositoryImpl());
  sl.registerLazySingleton<FlightOffersRepository>(
      () => FlightOffersRepositoryImpl());
 

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
   sl.registerLazySingleton<GetFlightOfferPricingUseCase>(
      () => GetFlightOfferPricingUseCase());
  sl.registerLazySingleton<GetSeatmapUseCase>(
      () => GetSeatmapUseCase());
  sl.registerLazySingleton<SearchAirport>(() => SearchAirport());

  //blocs
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc());
  sl.registerLazySingleton<CurrencyBloc>(() => CurrencyBloc());
  sl.registerLazySingleton<DataSearchBloc>(() => DataSearchBloc());
  sl.registerLazySingleton<ProfileBloc>(
      () => ProfileBloc(sl<ProfileApiService>(), sl<SharedPreferences>()));

  sl.registerLazySingleton<AirportBloc>(() => AirportBloc());
  sl.registerLazySingleton<FlightBookingBloc>(() => FlightBookingBloc());
  sl.registerLazySingleton<ProfileApiService>(
      () => ProfileApiServiceImpl(sl<Dio>(), sl<SharedPreferences>()));
  sl.registerLazySingleton<FlightOffersBloc>(() => FlightOffersBloc());

  //cubits
  sl.registerLazySingleton<AirlineCubit>(() => AirlineCubit());
  sl.registerLazySingleton<FlightPricingCubit>(() => FlightPricingCubit());
  sl.registerLazySingleton<SeatmapCubit>(() => SeatmapCubit());
  
}
