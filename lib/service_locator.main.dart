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
  _initStitching();
  _initCart();
  _initCustomMade();
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
        fetchOrdersUsecase: sl(),
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
  sl.registerFactory<FetchOrdersUsecase>(
      () => FetchOrdersUsecase(settingsRepo: sl()));
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
      fetchAlterationSignedUrl: sl(),
      saveAlterationUsecase: sl(),
      addAlterationToCartUsecase: sl()));
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
  sl.registerFactory<AddAlterationToCartUsecase>(
      () => AddAlterationToCartUsecase(alterationRepo: sl()));

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
  // Bloc
  sl.registerLazySingleton<AddressCubit>(() => AddressCubit(
      saveAddressUsecase: sl(),
      deleteAddressUsecase: sl(),
      fetchAddressList: sl()));
}

_initStitching() {
  // Data Source
  sl.registerFactory<FetchCustomStylingUsecase>(
      () => FetchCustomStylingUsecase(stitchingRepo: sl()));

  sl.registerFactory<FetchStitchingSignedUrlUsecase>(
      () => FetchStitchingSignedUrlUsecase(stitchingRepo: sl()));
  sl.registerFactory<SaveStitchingUsecase>(
      () => SaveStitchingUsecase(stitchingRepo: sl()));
  sl.registerFactory<AddItemToCartUsecase>(
      () => AddItemToCartUsecase(stitchingRepo: sl()));

  // Bloc
  sl.registerLazySingleton<StylingCubit>(
      () => StylingCubit(fetchCustomStylingUsecase: sl()));
  sl.registerLazySingleton<StitchingCubit>(() => StitchingCubit(
      fetchStitchingSignedUrlUseCase: sl(),
      saveStitchingUsecase: sl(),
      addItemToCartUsecase: sl()));

  // Repo
  sl.registerFactory<StitchingRepo>(
      () => StitchingRepoImpl(stitchingDataSource: sl()));

  // Data Source
  sl.registerFactory<StitchingDataSource>(
      () => StitchingDataSourceImpl(apiClient: sl()));
}

_initCart() {
  // Bloc
  sl.registerFactory<CartCubit>(
      () => CartCubit(fetchCartUsecase: sl(), removeCartItemUsecase: sl()));
  sl.registerFactory<ProductCartCubit>(
      () => ProductCartCubit(fetchProductCart: sl()));
  sl.registerFactory<PlaceOrderCubit>(() => PlaceOrderCubit(
      createAlterationOrderUsecase: sl(),
      processAlterationOrderUsecase: sl(),
      createStitchingOrderUsecase: sl(),
      processStitchingOrderUsecase: sl()));

  // Usecase
  sl.registerFactory<FetchCartUsecase>(() => FetchCartUsecase(cartRepo: sl()));
  sl.registerFactory<RemoveCartItemUsecase>(
      () => RemoveCartItemUsecase(cartRepo: sl()));
  sl.registerFactory<CreateAlterationOrderUsecase>(
      () => CreateAlterationOrderUsecase(cartRepo: sl()));
  sl.registerFactory<ProcessAlterationOrderUsecase>(
      () => ProcessAlterationOrderUsecase(cartRepo: sl()));
  sl.registerFactory<CreateStitchingOrderUsecase>(
      () => CreateStitchingOrderUsecase(cartRepo: sl()));
  sl.registerFactory<ProcessStitchingOrderUsecase>(
      () => ProcessStitchingOrderUsecase(cartRepo: sl()));
  sl.registerFactory<FetchProductCartUsecase>(
      () => FetchProductCartUsecase(cartRepo: sl()));

  // Repo
  sl.registerFactory<CartRepo>(() => CartRepoImpl(cartDataSource: sl()));

  // Data Source
  sl.registerFactory<CartDataSource>(() => CartDataSourceImpl(apiClient: sl()));
}

_initCustomMade() {
  // Bloc
  sl.registerFactory<ProductCubit>(() => ProductCubit(
      fetchProductUsecase: sl(), addProductItemToCartUsecase: sl()));

  // Usecase
  sl.registerFactory<FetchProductUsecase>(
      () => FetchProductUsecase(customMadeRepo: sl()));
  sl.registerFactory<AddProductItemToCartUsecase>(
      () => AddProductItemToCartUsecase(customMadeRepo: sl()));

  // Repo
  sl.registerFactory<CustomMadeRepo>(
      () => CustomMadeRepoImpl(customMadeDataSource: sl()));

  // Data Source
  sl.registerFactory<CustomMadeDataSource>(
      () => CustomMadeDataSourceImpl(client: sl()));
}
