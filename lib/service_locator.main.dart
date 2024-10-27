part of 'service_locator.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Shared Preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

// core
  sl.registerLazySingleton(
    () => AppUserCubit(),
  );
  sl.registerLazySingleton<ApiClient>(() => ApiClient());

  // Features
  _initAuth();
  _initSettings();
  _initMeasurement();
  _initAlteration();
  _initAppointment();
  _initAddress();
}

void _initAuth() {
  // Bloc
  sl.registerFactory<AuthBloc>(() => AuthBloc(
      loginWithOtpUsecase: sl(),
      loginWithPasswordUsecase: sl(),
      verifyOtpUsecase: sl(),
      forgotPasswordUsecase: sl(),
      registerUsecase: sl(),
      loginWithGoogleUsecase: sl(),
      getCurrentUserUsecase: sl(),
      logoutUsecase: sl(),
      appUserCubit: sl()));
  // Usecase
  sl.registerFactory<LoginWithOtpUsecase>(
      () => LoginWithOtpUsecase(authRepo: sl()));
  sl.registerFactory<LoginWithPasswordUsecase>(
      () => LoginWithPasswordUsecase(authRepo: sl()));
  sl.registerFactory<VerifyOtpUsecase>(() => VerifyOtpUsecase(authRepo: sl()));
  sl.registerFactory<ForgotPasswordUsecase>(
      () => ForgotPasswordUsecase(authRepo: sl()));
  sl.registerFactory<RegisterUsecase>(() => RegisterUsecase(authRepo: sl()));
  sl.registerFactory<LoginWithGoogleUsecase>(
      () => LoginWithGoogleUsecase(authRepo: sl()));
  sl.registerFactory<LogoutUsecase>(() => LogoutUsecase(authRepo: sl()));
  sl.registerFactory<GetCurrentUserUsecase>(
      () => GetCurrentUserUsecase(authRepo: sl()));
  // Repository
  sl.registerFactory<AuthRepo>(() => AuthRepoImpl(authDataSource: sl()));
  // Remote Data Source
  sl.registerFactory<AuthDataSource>(
      () => AuthDataSourceImpl(apiClient: sl(), prefs: sl()));
}

_initSettings() {
  // Bloc
  sl.registerFactory<SettingsBloc>(() => SettingsBloc(
        editProfileUsecase: sl(),
        fetchProfilePictureSignedUrl: sl(),
        fetchStoreOrderUsecase: sl(),
        fetchProductOrderUsecase: sl(),
      ));
  // Usecase
  sl.registerFactory<EditProfileUsecase>(
      () => EditProfileUsecase(settingsRepo: sl()));
  sl.registerFactory<FetchProfileSignedUrlUsecase>(
      () => FetchProfileSignedUrlUsecase(settingsRepo: sl()));
  sl.registerFactory<FetchStoreOrderUsecase>(
      () => FetchStoreOrderUsecase(settingsRepo: sl()));
  sl.registerFactory<FetchProductOrderUsecase>(
      () => FetchProductOrderUsecase(settingsRepo: sl()));
  // Repository
  sl.registerFactory<SettingsRepo>(
      () => SettingsRepoImpl(settingsDataSource: sl()));
  // Remote Data Source
  sl.registerFactory<SettingsDataSource>(
      () => SettingsDataSourceImpl(apiClient: sl()));
}

_initMeasurement() {
// Bloc
  sl.registerFactory<CategoryCubit>(() => CategoryCubit(
        fetchCatUsecase: sl(),
      ));
  sl.registerFactory<UserAttributeCubit>(
      () => UserAttributeCubit(fetchUserAttributeUsecase: sl()));
  sl.registerFactory(() => ProductConfigCubit(fetchProductConfigUsecase: sl()));
  sl.registerFactory<MeasurementCubit>(() => MeasurementCubit(
        saveMeasurementUsecase: sl(),
      ));
  sl.registerFactory<UserMeasurementCubit>(
      () => UserMeasurementCubit(fetchUserMeasurementUsecase: sl()));
  sl.registerFactory<SizeChartCubit>(
      () => SizeChartCubit(fetchSizeChartUsecase: sl()));
  sl.registerFactory(() => BodyProfileCubit(
      fetchBodyProfileUsecase: sl(),
      saveBodyProfileUsecase: sl(),
      saveStandardSizingUsecase: sl(),
      fetchUserSizeUsecase: sl(),
      fetchSignedUrlUsecase: sl()));

  // Usecase
  sl.registerFactory<FetchCatUsecase>(
      () => FetchCatUsecase(measurementRepo: sl()));
  sl.registerFactory<FetchUserAttributeUsecase>(
      () => FetchUserAttributeUsecase(measurementRepo: sl()));
  sl.registerFactory<FetchProductConfigUseCase>(
      () => FetchProductConfigUseCase(measurementRepo: sl()));
  sl.registerFactory<SaveMeasurementUsecase>(
      () => SaveMeasurementUsecase(measurementRepo: sl()));
  sl.registerFactory<FetchUserMeasurementUsecase>(
      () => FetchUserMeasurementUsecase(measurementRepo: sl()));
  sl.registerFactory<FetchSizeChartUsecase>(
      () => FetchSizeChartUsecase(measurementRepo: sl()));
  sl.registerFactory<FetchBodyProfileUsecase>(
      () => FetchBodyProfileUsecase(measurementRepo: sl()));
  sl.registerFactory<SaveBodyProfileUsecase>(
      () => SaveBodyProfileUsecase(repository: sl()));
  sl.registerFactory<SaveStandardSizingUsecase>(
      () => SaveStandardSizingUsecase(measurementRepo: sl()));
  sl.registerFactory<FetchUserSizeUsecase>(
      () => FetchUserSizeUsecase(measurementRepo: sl()));
  sl.registerFactory<FetchSignedUrlUsecase>(
      () => FetchSignedUrlUsecase(measurementRepo: sl()));

  // Repository
  sl.registerFactory<MeasurementRepo>(
      () => MeasurementRepoImpl(measurementDataSource: sl()));

  // Remote Data Source
  sl.registerFactory<MeasurementDataSource>(
      () => MeasurementDataSourceImpl(apiClient: sl(), prefs: sl()));
}

_initAlteration() {
  // Bloc
  sl.registerFactory<AlterationConfigCubit>(
      () => AlterationConfigCubit(fetchAlterationConfigUsecase: sl()));
  sl.registerFactory<SaveAlterationCubit>(() => SaveAlterationCubit(
      fetchAlterationSignedUrl: sl(), saveAlterationUsecase: sl()));
  sl.registerFactory<AlterationUserMeasurementCubit>(
      () => AlterationUserMeasurementCubit(fetchUserMeasurementUsecase: sl()));

  // Usecase
  sl.registerFactory<FetchAlterationConfigUsecase>(
      () => FetchAlterationConfigUsecase(alterationRepo: sl()));
  sl.registerFactory<FetchAlteraionSignedUrlUsecase>(
      () => FetchAlteraionSignedUrlUsecase(alterationRepo: sl()));
  sl.registerFactory<SaveAlterationUsecase>(
      () => SaveAlterationUsecase(alterationRepo: sl()));
  sl.registerFactory<FetchAlterationUserMeasurementUsecase>(
      () => FetchAlterationUserMeasurementUsecase(alterationRepo: sl()));

  // Repo
  sl.registerFactory<AlterationRepo>(
      () => AlterationRepoImpl(alterationDataSource: sl()));

  // Data Source
  sl.registerFactory<AlterationDataSource>(
      () => AlterationDataSourceImpl(client: sl()));
}

_initAppointment() {
  // Bloc
  sl.registerFactory<AppointmentCubit>(() => AppointmentCubit(
      saveAppointmentUsecase: sl(), fetchAppointmentsUsecase: sl()));

  // Usecase
  sl.registerFactory<SaveAppointmentUsecase>(
      () => SaveAppointmentUsecase(appointmentRepo: sl()));
  sl.registerFactory<FetchAppointmentUsecase>(
      () => FetchAppointmentUsecase(appointmentRepo: sl()));

  // Repo
  sl.registerFactory<AppointmentRepo>(
      () => AppointmentRepoImpl(appointmentDataSource: sl()));

  // Data Source
  sl.registerFactory<AppointmentDataSource>(
      () => AppointmentDataSourceImpl(apiClient: sl()));
}

_initAddress() {
  // Bloc
  sl.registerFactory<AddressCubit>(() => AddressCubit(
      saveAddressUsecase: sl(),
      deleteAddressUsecase: sl(),
      fetchAddressList: sl()));

  // Usecase
  sl.registerFactory<SaveAddressUsecase>(
      () => SaveAddressUsecase(addressRepo: sl()));
  sl.registerFactory<FetchAddressListUsecase>(
      () => FetchAddressListUsecase(addressRepo: sl()));
  sl.registerFactory<DeleteAddressUsecase>(
      () => DeleteAddressUsecase(addressRepo: sl()));

  // Repo
  sl.registerFactory<AddressRepo>(
      () => AddressRepoImpl(addressDataSource: sl()));

  // Data Source
  sl.registerFactory<AddressDataSource>(
      () => AddressDataSourceImpl(apiClient: sl()));
}
