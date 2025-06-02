import "package:dio/dio.dart";
import "package:get_it/get_it.dart";
import 'package:travelecho/navigation_menu/blocs/navigation_menu_cubit.dart';
import 'features/features_exports.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

/// Service locator instance for dependency injection
final sl = GetIt.instance;

/// Sets up the service locator with all required dependencies
Future<void> setupServiceLocator() async {
  // Register core services
  await _registerCoreServices();

  // Register API services
  _registerApiServices();

  // Register repositories
  _registerRepositories();

  // Register use cases
  _registerUseCases();

  // Register blocs
  _registerBlocs();

  // Register cubits
  _registerCubits();
}

/// Registers core services like SharedPreferences and Dio
Future<void> _registerCoreServices() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);
  sl.registerSingleton<DioClient>(DioClient());
  sl.registerSingleton<Dio>(Dio());
  sl.registerSingleton<Logger>(Logger());
}

/// Registers all API services
void _registerApiServices() {
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
  sl.registerLazySingleton<MemoriesApiService>(() => MemoriesApiServiceImpl());
  sl.registerLazySingleton<ProfileApiService>(
    () => ProfileApiServiceImpl(sl<DioClient>(), sl<SharedPreferences>()),
  );
  sl.registerLazySingleton<BudgetRemoteDataSource>(
      () => BudgetRemoteDataSourceImpl());
}

/// Registers all repositories
void _registerRepositories() {
  // Auth and Profile
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  // Data repositories
  sl.registerLazySingleton<CurrencyRepository>(() => CurrencyRepositoryImpl());
  sl.registerLazySingleton<SchoolRepository>(() => SchoolRepositoryImpl());
  sl.registerLazySingleton<LocationRepository>(() => LocationRepositoryImpl());
  sl.registerLazySingleton<OccupationsRepository>(
      () => OccupationsRepositoryImpl());
  sl.registerLazySingleton<LanguagesRepository>(
      () => LanguagesRepositoryImpl());
  sl.registerLazySingleton<InterestsRepository>(
      () => InterestsRepositoryImpl());
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl());

  // Travel related repositories
  sl.registerLazySingleton<AirportRepository>(() => AirportRepositoryImpl());
  sl.registerLazySingleton<FlightOffersRepository>(
      () => FlightOffersRepositoryImpl());
  sl.registerLazySingleton<HotelBookingRepository>(
      () => HotelBookingRepositoryImpl());
  sl.registerLazySingleton<MemoriesRepository>(() => MemoriesRepositoryImpl());

  //Budget repositories
  sl.registerLazySingleton<BudgetRepository>(() => BudgetRepositoryImpl());
}

/// Registers all use cases
void _registerUseCases() {
  // Auth use cases
  sl.registerLazySingleton<SignupUseCase>(() => SignupUseCase());
  sl.registerLazySingleton<SigninUseCase>(() => SigninUseCase());
  sl.registerLazySingleton<VerifyOtpUseCase>(() => VerifyOtpUseCase());
  sl.registerLazySingleton<SendOtpUseCase>(() => SendOtpUseCase());
  sl.registerLazySingleton<ResetPasswordUseCase>(() => ResetPasswordUseCase());
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
  sl.registerSingleton<IsNotNewUserUseCase>(IsNotNewUserUseCase());
  sl.registerSingleton<GetMemoryDetailsUseCase>(GetMemoryDetailsUseCase());
  sl.registerSingleton<LogoutUseCase>(LogoutUseCase());

  // Data use cases
  sl.registerLazySingleton(() => ConvertCurrency());
  sl.registerLazySingleton(() => GetCurrencyList());
  sl.registerLazySingleton(() => GetLocationList());
  sl.registerLazySingleton(() => GetSchoolList());
  sl.registerLazySingleton(() => GetOccupations());
  sl.registerLazySingleton(() => GetLanguages());
  sl.registerLazySingleton(() => GetInterests());

  // Travel related use cases
  sl.registerLazySingleton<GetFlightOfferPricingUseCase>(
      () => GetFlightOfferPricingUseCase());
  sl.registerLazySingleton<GetSeatmapUseCase>(() => GetSeatmapUseCase());
  sl.registerLazySingleton<SearchAirport>(() => SearchAirport());

  // Memories use cases
  sl.registerLazySingleton<CreateMemoryUseCase>(() => CreateMemoryUseCase());
  // sl.registerLazySingleton<UploadMemoryImageUseCase>(
  //     () => UploadMemoryImageUseCase());
  sl.registerLazySingleton<UploadMultipleMemoryImagesUseCase>(
      () => UploadMultipleMemoryImagesUseCase());
  sl.registerLazySingleton<GetMemoriesUseCase>(() => GetMemoriesUseCase());
  sl.registerLazySingleton<DeleteMemoryUseCase>(() => DeleteMemoryUseCase());
  sl.registerLazySingleton<EditMemoryUseCase>(() => EditMemoryUseCase());
  sl.registerLazySingleton<DeleteMultipleMemoriesUseCase>(
      () => DeleteMultipleMemoriesUseCase());
  sl.registerLazySingleton<GetUserProfileUseCase>(
      () => GetUserProfileUseCase());
  sl.registerLazySingleton<UpdateProfileImageUseCase>(
      () => UpdateProfileImageUseCase());

  //Budget usecases
  sl.registerLazySingleton<CreateBudgetUseCase>(() => CreateBudgetUseCase());
  sl.registerLazySingleton<UpdateBudgetUseCase>(() => UpdateBudgetUseCase());
  sl.registerLazySingleton<GetBudgetsUseCase>(() => GetBudgetsUseCase());
  sl.registerLazySingleton<GetAllBudgetsUseCase>(() => GetAllBudgetsUseCase());
  sl.registerLazySingleton<GetBudgetByIdUseCase>(() => GetBudgetByIdUseCase());
  sl.registerLazySingleton<GetBudgetWithExpensesUseCase>(
      () => GetBudgetWithExpensesUseCase());
  sl.registerLazySingleton<CreateExpenseUseCase>(() => CreateExpenseUseCase());
  sl.registerLazySingleton<DeleteBudgetUseCase>(() => DeleteBudgetUseCase());
  sl.registerLazySingleton<UpdateExpenseUseCase>(() => UpdateExpenseUseCase());
  sl.registerLazySingleton<DeleteExpenseUseCase>(() => DeleteExpenseUseCase());
  sl.registerLazySingleton<GetExpensesUseCase>(() => GetExpensesUseCase());
  }

/// Registers all blocs
void _registerBlocs() {
  sl.registerLazySingleton<NavigationMenuCubit>(() => NavigationMenuCubit());
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc());
  sl.registerLazySingleton<CurrencyBloc>(() => CurrencyBloc());
  sl.registerLazySingleton<DataSearchBloc>(() => DataSearchBloc());
  sl.registerLazySingleton<ProfileBloc>(
    () => ProfileBloc(),
  );
  sl.registerLazySingleton<AirportBloc>(() => AirportBloc());
  sl.registerLazySingleton<FlightBookingBloc>(() => FlightBookingBloc());
  sl.registerLazySingleton<FlightOffersBloc>(() => FlightOffersBloc());
  sl.registerLazySingleton<HotelBookingBloc>(() => HotelBookingBloc());
  sl.registerLazySingleton<MemoriesBloc>(() => MemoriesBloc());
  sl.registerLazySingleton<BudgetBloc>(() => BudgetBloc());
}

/// Registers all cubits
void _registerCubits() {
  sl.registerLazySingleton<AirlineCubit>(() => AirlineCubit());
  sl.registerLazySingleton<FlightPricingCubit>(() => FlightPricingCubit());
  sl.registerLazySingleton<SeatmapCubit>(() => SeatmapCubit());
}
