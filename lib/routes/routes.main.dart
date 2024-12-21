part of 'routes.dart';

class Routes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoadingScreen());

      case '/splash1':
        return MaterialPageRoute(builder: (_) => const Splash1Screen());

      case '/splash2':
        return MaterialPageRoute(builder: (_) => const Splash2Screen());

      case '/splash3':
        return MaterialPageRoute(builder: (_) => const Splash3Screen());

      case '/auth-selection':
        return MaterialPageRoute(builder: (context) => const AuthSelection());

      case '/login-successful':
        return MaterialPageRoute(builder: (_) => const LoginSuccessful());

      case '/bottom-bar':
        return MaterialPageRoute(
            builder: (_) => const BottomNavigationBarWidget());

      case '/chat-screen':
        return MaterialPageRoute(builder: (_) => const ChatScreen());

      case '/media-history':
        return MaterialPageRoute(builder: (_) => const MediaHistory());

      case '/cart-screen':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: sl<AddressCubit>(),
                    ),
                    BlocProvider(
                      create: (context) => sl<CartCubit>(),
                    ),
                    BlocProvider(
                      create: (context) => sl<PlaceOrderCubit>(),
                    ),
                  ],
                  child: const CartScreen(),
                ));

      case '/settings':
        return MaterialPageRoute(builder: (_) => const Settings());

      case '/address':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: sl<AddressCubit>(),
                  child: AddressList(choose: settings.arguments as bool),
                ));

      case '/add-address':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: sl<AddressCubit>(),
                  child: AddAddress(
                    address: settings.arguments as AddressEntity?,
                  ),
                ));

      case '/edit-profile':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => sl<SettingsBloc>(),
                  child: const EditProfile(),
                ));

      case '/orders':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => sl<SettingsBloc>(),
                  child: const Orders(),
                ));

      case '/appointment-details':
        return MaterialPageRoute(
            builder: (_) => AppointmentDetails(
                appointment: settings.arguments as AppointmentEntity));

      case '/measurement-home':
        return MaterialPageRoute(builder: (_) => const MeasurementHome());

      case '/order-detail':
        return MaterialPageRoute(builder: (_) => const OrderDetail());

      case '/select-garment-cat':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => sl<CategoryCubit>(),
                  child: SelectGarmentCat(
                    fromCustom: settings.arguments as bool,
                  ),
                ));

      case '/standard-size':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => sl<UserAttributeCubit>(),
                    ),
                    BlocProvider(
                      create: (context) => sl<SizeChartCubit>(),
                    ),
                    BlocProvider(
                      create: (context) => sl<BodyProfileCubit>(),
                    ),
                  ],
                  child: StandardSizing(
                    catId: settings.arguments as String,
                  ),
                ));

      case '/body-details':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => sl<BodyProfileCubit>(),
                  child: BodyDetails(
                    selectedCat: settings.arguments as List<SelectedCatModel>,
                  ),
                ));

      case '/body-images':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => sl<BodyProfileCubit>(),
                  child: BodyImages(
                    selectedCat: (settings.arguments as Map)["selectedCat"]
                        as List<SelectedCatModel>,
                    frontSavedPicture: (settings.arguments
                        as Map)["frontSavedPicture"] as String?,
                    sideSavedPicture: (settings.arguments
                        as Map)["sideSavedPicture"] as String?,
                    backSavedPicture: (settings.arguments
                        as Map)["backSavedPicture"] as String?,
                  ),
                ));

      case '/selected-cat':
        return MaterialPageRoute(
            builder: (_) => SelectedCat(
                  selectedCat: (settings.arguments as Map)["selectedCat"]
                      as List<SelectedCatModel>,
                  fromCustom: (settings.arguments as Map)["fromCustom"] as bool,
                ));

      case '/measurement-details':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => sl<ProductConfigCubit>(),
                    ),
                    BlocProvider(
                      create: (context) => sl<MeasurementCubit>(),
                    ),
                    BlocProvider(
                      create: (context) => sl<UserMeasurementCubit>(),
                    ),
                  ],
                  child: MeasurementDetails(
                      selectedCat: settings.arguments as SelectedCatModel),
                ));

      case '/select-alteration-cat':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => sl<CategoryCubit>(),
                  child: const SelectAlteraionCat(),
                ));

      case '/alteration-option':
        return MaterialPageRoute(
            builder: (_) => AlterationOption(
                  selectedCat: settings.arguments as SelectedCatModel,
                ));

      case '/upload-image':
        return MaterialPageRoute(
            builder: (_) => UploadImage(
                  selectedCat: settings.arguments as SelectedCatModel,
                ));

      case '/alteration-details':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => sl<AlterationConfigCubit>(),
                    ),
                    BlocProvider(
                      create: (context) => sl<AlterationUserMeasurementCubit>(),
                    ),
                  ],
                  child: AlterationDetails(
                    imgFile: (settings.arguments as Map)["imgFile"] as String,
                    videoFile:
                        (settings.arguments as Map)["videoFile"] as String,
                    selectedCat: (settings.arguments as Map)["selectedCat"]
                        as SelectedCatModel,
                  ),
                ));

      case '/alteration-order-summary':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => sl<SaveAlterationCubit>(),
                  child: AlterationOrderSummary(
                    alterations: (settings.arguments as Map)["alterations"]
                        as List<AlterationEntity>,
                    imgFile: (settings.arguments as Map)["imgFile"] as String,
                    videoFile:
                        (settings.arguments as Map)["videoFile"] as String,
                    selectedCat: (settings.arguments as Map)["selectedCat"]
                        as SelectedCatModel,
                  ),
                ));

      case '/create-appointment':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => sl<AppointmentCubit>(),
                  child: CreateAppointment(isBack: settings.arguments as bool?),
                ));

      case '/appointment-history':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => sl<AppointmentCubit>(),
                  child: const AppointmentHistory(),
                ));

      case '/select-stitching-cat':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => sl<CategoryCubit>(),
                  child: const SelectStitchingCat(),
                ));

      case '/selected-stitching-cat':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => sl<CategoryCubit>(),
                  child: SelectedStitchingCat(
                    selectedCat:
                        settings.arguments as List<SelectedStitchingCatEntity>,
                  ),
                ));

      case '/upload-stitching-data':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => sl<CategoryCubit>(),
                  child: UploadData(
                      selectedCat:
                          settings.arguments as SelectedStitchingCatEntity),
                ));

      case '/stitching-detail':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: sl<StylingCubit>(),
                    ),
                    BlocProvider.value(
                      value: sl<StitchingCubit>(),
                    ),
                  ],
                  child: StitchingDetail(
                    selectedCat: (settings.arguments as Map)["selectedCat"],
                    fabricLength: (settings.arguments as Map)["fabricLength"],
                    fabricWidth: (settings.arguments as Map)["fabricWidth"],
                    name: (settings.arguments as Map)["name"],
                    note: (settings.arguments as Map)["note"],
                    image: (settings.arguments as Map)["image"],
                  ),
                ));

      case '/custom_filter':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: sl<StylingCubit>(),
                  child: CustomFilter(
                    styling: settings.arguments as List<StylingConfigEntity>,
                  ),
                ));

      default:
        return null;
    }
  }
}
