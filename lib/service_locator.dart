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
    () => CurrencyRemoteSourceImpl(),
  );
  sl.registerLazySingleton<SchoolRemoteSource>(() => SchoolRemoteSourceImpl());
  sl.registerLazySingleton<LocationRemoteSource>(
    () => LocationRemoteSourceImpl(),
  );
  sl.registerLazySingleton<OccupationsLocalSource>(
    () => OccupationsLocalSourceImpl(),
  );
  sl.registerLazySingleton<LanguageLocalSource>(
    () => LanguageLocalSourceImpl(),
  );
  sl.registerLazySingleton<InterestLocalSource>(
    () => InterestLocalSourceImpl(),
  );
  sl.registerLazySingleton<AmadeusApiService>(() => AmadeusApiService());
  sl.registerLazySingleton<AirlineApiService>(() => AirlineApiService());
  sl.registerLazySingleton<MemoriesApiService>(() => MemoriesApiServiceImpl());
  sl.registerLazySingleton<ProfileApiService>(
    () => ProfileApiServiceImpl(sl<DioClient>(), sl<SharedPreferences>()),
  );
  sl.registerLazySingleton<BudgetRemoteDataSource>(
    () => BudgetRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<TravelDocumentRemoteDataSource>(
    () => TravelDocumentRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<LevelRemoteDataSource>(
    () => LevelRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<CommunityRemoteDataSource>(
    () => CommunityRemoteDataSourceImpl(),
  );
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
    () => OccupationsRepositoryImpl(),
  );
  sl.registerLazySingleton<LanguagesRepository>(
    () => LanguagesRepositoryImpl(),
  );
  sl.registerLazySingleton<InterestsRepository>(
    () => InterestsRepositoryImpl(),
  );
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl());

  // Travel related repositories
  sl.registerLazySingleton<AirportRepository>(() => AirportRepositoryImpl());
  sl.registerLazySingleton<FlightOffersRepository>(
    () => FlightOffersRepositoryImpl(),
  );
  sl.registerLazySingleton<HotelBookingRepository>(
    () => HotelBookingRepositoryImpl(),
  );
  sl.registerLazySingleton<MemoriesRepository>(() => MemoriesRepositoryImpl());

  //Budget repositories
  sl.registerLazySingleton<BudgetRepository>(() => BudgetRepositoryImpl());

  //TravelDocument repositories
  sl.registerLazySingleton<TravelDocumentRepository>(
    () => TravelDocumentRepositoryImpl(),
  );
  //Milestone repositories
  sl.registerLazySingleton<LevelRepository>(() => LevelRepositoryImpl());
  //Community repositories
  sl.registerLazySingleton<CommunityRepository>(
    () => CommunityRepositoryImpl(),
  );
}

/// Registers all use cases
void _registerUseCases() {
  // Auth use cases
  sl.registerLazySingleton<SignupUseCase>(() => SignupUseCase());
  sl.registerLazySingleton<SigninUseCase>(() => SigninUseCase());
  sl.registerLazySingleton<VerifyOtpUseCase>(() => VerifyOtpUseCase());
  sl.registerLazySingleton<RecoveryVerifyOtpUseCase>(
    () => RecoveryVerifyOtpUseCase(),
  );
  sl.registerLazySingleton<SendOtpUseCase>(() => SendOtpUseCase());
  sl.registerLazySingleton<RecoveryResendOtpUseCase>(
    () => RecoveryResendOtpUseCase(),
  );
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
    () => GetFlightOfferPricingUseCase(),
  );
  sl.registerLazySingleton<GetSeatmapUseCase>(() => GetSeatmapUseCase());
  sl.registerLazySingleton<SearchAirport>(() => SearchAirport());

  // Memories use cases
  sl.registerLazySingleton<CreateMemoryUseCase>(() => CreateMemoryUseCase());
  // sl.registerLazySingleton<UploadMemoryImageUseCase>(
  //     () => UploadMemoryImageUseCase());
  sl.registerLazySingleton<UploadMultipleMemoryImagesUseCase>(
    () => UploadMultipleMemoryImagesUseCase(),
  );
  sl.registerLazySingleton<GetMemoriesUseCase>(() => GetMemoriesUseCase());
  sl.registerLazySingleton<DeleteMemoryUseCase>(() => DeleteMemoryUseCase());
  sl.registerLazySingleton<EditMemoryUseCase>(() => EditMemoryUseCase());
  sl.registerLazySingleton<DeleteMultipleMemoriesUseCase>(
    () => DeleteMultipleMemoriesUseCase(),
  );
  sl.registerLazySingleton<GetUserProfileUseCase>(
    () => GetUserProfileUseCase(),
  );
  sl.registerLazySingleton<UpdateProfileImageUseCase>(
    () => UpdateProfileImageUseCase(),
  );

  //Budget usecases
  sl.registerLazySingleton<CreateBudgetUseCase>(() => CreateBudgetUseCase());
  sl.registerLazySingleton<UpdateBudgetUseCase>(() => UpdateBudgetUseCase());
  sl.registerLazySingleton<DeleteBudgetUseCase>(() => DeleteBudgetUseCase());
  sl.registerLazySingleton<CreateExpenseUseCase>(() => CreateExpenseUseCase());
  sl.registerLazySingleton<UpdateExpenseUseCase>(() => UpdateExpenseUseCase());
  sl.registerLazySingleton<DeleteExpenseUseCase>(() => DeleteExpenseUseCase());
  sl.registerLazySingleton<UploadExpenseReceiptUseCase>(
    () => UploadExpenseReceiptUseCase(),
  );
  sl.registerLazySingleton<GetAllBudgetsUseCase>(() => GetAllBudgetsUseCase());
  sl.registerLazySingleton<GetBudgetByIdUseCase>(() => GetBudgetByIdUseCase());
  sl.registerLazySingleton<GetBudgetWithExpensesUseCase>(
    () => GetBudgetWithExpensesUseCase(),
  );
  sl.registerLazySingleton<GetExpensesUseCase>(() => GetExpensesUseCase());

  //passport usecases
  sl.registerLazySingleton<CreateTravelDocumentUseCase>(
    () => CreateTravelDocumentUseCase(),
  );
  sl.registerLazySingleton<UpdateTravelDocumentUseCase>(
    () => UpdateTravelDocumentUseCase(),
  );
  sl.registerLazySingleton<DeleteTravelDocumentUseCase>(
    () => DeleteTravelDocumentUseCase(),
  );
  sl.registerLazySingleton<GetAllTravelDocumentsUseCase>(
    () => GetAllTravelDocumentsUseCase(),
  );
  sl.registerLazySingleton<UploadTravelDocumentImagesUseCase>(
    () => UploadTravelDocumentImagesUseCase(),
  );
  sl.registerLazySingleton<GetTravelDocumentByIdUseCase>(
    () => GetTravelDocumentByIdUseCase(),
  );

  //Milestone use cases
  sl.registerLazySingleton<GetLevelsUseCase>(() => GetLevelsUseCase());
  sl.registerLazySingleton<GetEarnedBadgesUseCase>(
    () => GetEarnedBadgesUseCase(),
  );

  // -------------------- Community Use Cases --------------------
  sl.registerLazySingleton<CreatePostUseCase>(() => CreatePostUseCase());
  sl.registerLazySingleton<AddPostMediaUseCase>(() => AddPostMediaUseCase());
  sl.registerLazySingleton<GetPostsUseCase>(() => GetPostsUseCase());
  sl.registerLazySingleton<GetPostByIdUseCase>(() => GetPostByIdUseCase());
  sl.registerLazySingleton<UpdatePostUseCase>(() => UpdatePostUseCase());
  sl.registerLazySingleton<DeletePostUseCase>(() => DeletePostUseCase());
  sl.registerLazySingleton<TogglePostLikeUseCase>(
    () => TogglePostLikeUseCase(),
  );

  sl.registerLazySingleton<CreateCommentUseCase>(() => CreateCommentUseCase());

  sl.registerLazySingleton<GetCommentsUseCase>(() => GetCommentsUseCase());

  sl.registerLazySingleton<UpdateCommentUseCase>(() => UpdateCommentUseCase());

  sl.registerLazySingleton<DeleteCommentUseCase>(() => DeleteCommentUseCase());

  sl.registerLazySingleton<GetRepliesUseCase>(() => GetRepliesUseCase());

  sl.registerLazySingleton<CreateReplyUseCase>(() => CreateReplyUseCase());

  sl.registerLazySingleton<ToggleCommentLikeUseCase>(
    () => ToggleCommentLikeUseCase(),
  );
}

/// Registers all blocs
void _registerBlocs() {
  sl.registerLazySingleton<NavigationMenuCubit>(() => NavigationMenuCubit());
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc());
  sl.registerLazySingleton<CurrencyBloc>(() => CurrencyBloc());
  sl.registerLazySingleton<DataSearchBloc>(() => DataSearchBloc());
  sl.registerLazySingleton<ProfileBloc>(() => ProfileBloc());
  sl.registerLazySingleton<AirportBloc>(() => AirportBloc());
  sl.registerLazySingleton<FlightBookingBloc>(() => FlightBookingBloc());
  sl.registerLazySingleton<FlightOffersBloc>(() => FlightOffersBloc());
  sl.registerLazySingleton<HotelBookingBloc>(() => HotelBookingBloc());
  sl.registerLazySingleton<MemoriesBloc>(() => MemoriesBloc());
  sl.registerLazySingleton<BudgetBloc>(() => BudgetBloc());
  sl.registerLazySingleton<TravelDocumentBloc>(() => TravelDocumentBloc());

  sl.registerLazySingleton<LevelBloc>(() => LevelBloc());
  sl.registerLazySingleton<PostBloc>(() => PostBloc());
  sl.registerLazySingleton<CommentBloc>(() => CommentBloc());
  sl.registerLazySingleton<ReplyBloc>(() => ReplyBloc());
}

/// Registers all cubits
void _registerCubits() {
  sl.registerLazySingleton<AirlineCubit>(() => AirlineCubit());
  sl.registerLazySingleton<FlightPricingCubit>(() => FlightPricingCubit());
  sl.registerLazySingleton<SeatmapCubit>(() => SeatmapCubit());
}
