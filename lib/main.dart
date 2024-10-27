
import 'package:bluetailor_app/common/cubit/user_cubit/app_user_cubit.dart';
import 'package:bluetailor_app/common/widgets/bottom_navigation_bar.dart';
import 'package:bluetailor_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bluetailor_app/features/splashes/presentation/screens/loading_screen.dart';
import 'package:bluetailor_app/gen/fonts.gen.dart';
import 'package:bluetailor_app/routes/routes.dart';
import 'package:bluetailor_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => sl<AppUserCubit>(),
      ),
      BlocProvider(
        create: (context) => sl<AuthBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsLoggedIn());

  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BLUTAILOR',
        theme: ThemeData(useMaterial3: true, fontFamily: FontFamily.inter),
        onGenerateRoute: Routes.onGenerateRoutes,
        // initialRoute: "/",
        home: BlocSelector<AppUserCubit, AppUserState, bool>(
          selector: (state) {
            return state is AppUserLoggedIn;
          },
          builder: (context, isUserLoggedIn) {
            if (isUserLoggedIn) {
              return const BottomNavigationBarWidget();
            }
            return const LoadingScreen();
          },
        ),
      );
    });
  }
}