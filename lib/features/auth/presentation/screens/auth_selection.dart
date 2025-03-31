import 'dart:developer';

import 'package:bluetailor_app/common/widgets/dialog_and_snackbar.dart.dart';
import 'package:bluetailor_app/common/widgets/primary_icon_button.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/core/theme/app_strings.dart';
import 'package:bluetailor_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bluetailor_app/features/auth/presentation/widgets/auth_selection_widget.dart';
import 'package:bluetailor_app/features/auth/presentation/widgets/forgot_password_widget.dart';
import 'package:bluetailor_app/features/auth/presentation/widgets/login_with_password_widget.dart';
import 'package:bluetailor_app/features/auth/presentation/widgets/login_with_otp.dart';
import 'package:bluetailor_app/features/auth/presentation/widgets/otp_widget.dart';
import 'package:bluetailor_app/features/auth/presentation/widgets/signup_widget.dart';
import 'package:bluetailor_app/gen/assets.gen.dart';
import 'package:bluetailor_app/service_locator.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class AuthSelection extends StatefulWidget {
  const AuthSelection({super.key});

  @override
  State<AuthSelection> createState() => _AuthSelectionState();
}

class _AuthSelectionState extends State<AuthSelection> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _pageWidget = "auth";
  double _height = 30.h;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  String _countryCode = '+91';

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(authSelection), fit: BoxFit.cover)),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Assets.images.logo.image(
                    width: 50.w,
                  ),
                  SizedBox(height: 8.h),
                  BlocListener<AuthBloc, AuthState>(
                      bloc: context.read<AuthBloc>(),
                      listener: (context, state) {
                        if (state is AuthLoading) {
                          LoadingDialog(context);
                        }
                        if (state is AuthError) {
                          Navigator.pop(context);
                          PrimarySnackBar(context, state.message, Colors.red);
                        }
                        if (state is AuthSuccess) {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/login-successful');
                        }
                        if (state is AuthOtpSent) {
                          Navigator.pop(context);
                          setState(() {
                            _height = 35.h;
                            _pageWidget = "otp";
                          });
                        }
                        if (state is ForgotPassword) {
                          Navigator.pop(context);
                          setState(() {
                            _height = 45.h;
                            _pageWidget = "forgot";
                          });
                        }
                        if (state is PasswordResetDone) {
                          Navigator.pop(context);
                          PrimarySnackBar(context, "Password reset successful",
                              Colors.green);
                          setState(() {
                            _height = 45.h;
                            _pageWidget = "password";
                          });
                        }
                        if (state is AuthRegisterSuccess) {
                          Navigator.pop(context);
                          PrimarySnackBar(
                              context, "Registration successful", Colors.green);
                          setState(() {
                            _height = 30.h;
                            _pageWidget = "auth";
                          });
                        }
                      },
                      child: Form(
                          key: _formKey,
                          child: AnimatedContainer(
                              height: _height,
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.easeInOut,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                  color: transparentColor.withOpacity(0.51),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: _pageWidget == "auth"
                                  ? AuthSelectionWidget(
                                      onLoginPressed: () {
                                        setState(() {
                                          _height = 50.h;
                                          _pageWidget = "otpLogin";
                                        });
                                      },
                                      onSignUpPressed: () {
                                        setState(() {
                                          _height = 65.h;
                                          _pageWidget = "signup";
                                        });
                                      },
                                    )
                                  : _pageWidget == "otpLogin"
                                      ? LoginWithOTP(
                                          phoneController: _phoneController,
                                          onCountryChanged:
                                              (CountryCode countryCode) {
                                            setState(() {
                                              _countryCode =
                                                  countryCode.dialCode!;
                                              log(_countryCode,
                                                  name: "Country Code");
                                            });
                                          },
                                          onLoginPasswordPressed: () {
                                            setState(() {
                                              _height = 45.h;
                                              _pageWidget = "password";
                                            });
                                          },
                                          onLoginPressed: () {
                                            context.read<AuthBloc>().add(
                                                LoginWithOtpEvent(
                                                    phoneNumber:
                                                        _phoneController.text,
                                                    isForgotPassword: false));
                                          },
                                          onGooglePressed: () {},
                                        )
                                      : _pageWidget == "otp"
                                          ? OtpWidget(
                                              pinController: _pinController,
                                              onLoginPressed: () {
                                                context.read<AuthBloc>().add(
                                                    VerifyOtpEvent(
                                                        otp:
                                                            _pinController.text,
                                                        phoneNumber:
                                                            _phoneController
                                                                .text));
                                              },
                                              onResendPressed: () {
                                                context.read<AuthBloc>().add(
                                                    LoginWithOtpEvent(
                                                        phoneNumber:
                                                            _phoneController
                                                                .text,
                                                        isForgotPassword:
                                                            false));
                                              },
                                            )
                                          : _pageWidget == "password"
                                              ? LoginWithPasswordWidget(
                                                  phoneController:
                                                      _phoneController,
                                                  passwordController:
                                                      _passwordController,
                                                  onCountryChanged: (CountryCode
                                                      countryCode) {
                                                    setState(() {
                                                      _countryCode =
                                                          countryCode.dialCode!;
                                                      log(_countryCode,
                                                          name: "Country Code");
                                                    });
                                                  },
                                                  onLoginPressed: () {
                                                    context.read<AuthBloc>().add(
                                                        LoginWithPasswordEvent(
                                                            phoneNumber:
                                                                _phoneController
                                                                    .text,
                                                            password:
                                                                _passwordController
                                                                    .text));
                                                  },
                                                  onForgotPasswordPressed: () {
                                                    context
                                                        .read<AuthBloc>()
                                                        .add(LoginWithOtpEvent(
                                                            phoneNumber:
                                                                _phoneController
                                                                    .text,
                                                            isForgotPassword:
                                                                true));
                                                  },
                                                )
                                              : _pageWidget == "forgot"
                                                  ? ForgotPasswordWidget(
                                                      passwordController:
                                                          _passwordController,
                                                      pinController:
                                                          _pinController,
                                                      onResendPressed: () {
                                                        context
                                                            .read<AuthBloc>()
                                                            .add(LoginWithOtpEvent(
                                                                phoneNumber:
                                                                    _phoneController
                                                                        .text,
                                                                isForgotPassword:
                                                                    true));
                                                      },
                                                      onSubmitPressed: () {
                                                        if (_passwordController
                                                                .text.length <
                                                            10) {
                                                          PrimarySnackBar(
                                                              context,
                                                              "Please enter valid phone number.",
                                                              Colors.red);
                                                        } else {
                                                          context
                                                              .read<AuthBloc>()
                                                              .add(ForgotPasswordEvent(
                                                                  phoneNumber:
                                                                      _phoneController
                                                                          .text,
                                                                  otp:
                                                                      _pinController
                                                                          .text,
                                                                  password:
                                                                      _passwordController
                                                                          .text));
                                                        }
                                                      })
                                                  : SignupWidget(
                                                      firstNameController:
                                                          _firstNameController,
                                                      lastNameController:
                                                          _lastNameController,
                                                      emailController:
                                                          _emailController,
                                                      passwordController:
                                                          _passwordController,
                                                      phoneController:
                                                          _phoneController,
                                                      onCountryChanged:
                                                          (CountryCode
                                                              countryCode) {
                                                        setState(() {
                                                          _countryCode =
                                                              countryCode
                                                                  .dialCode!;
                                                          log(_countryCode,
                                                              name:
                                                                  "Country Code");
                                                        });
                                                      },
                                                      onSignupPressed: () {
                                                        if (_formKey
                                                                .currentState
                                                                ?.validate() ??
                                                            false) {
                                                          context.read<AuthBloc>().add(RegisterEvent(
                                                              phoneNumber:
                                                                  _phoneController
                                                                      .text,
                                                              password:
                                                                  _passwordController
                                                                      .text,
                                                              email:
                                                                  _emailController
                                                                      .text,
                                                              firstName:
                                                                  _firstNameController
                                                                      .text,
                                                              lastName:
                                                                  _lastNameController
                                                                      .text,
                                                              countryCode:
                                                                  _countryCode));
                                                        } else {
                                                          setState(() {
                                                            _height = 75.h;
                                                          });
                                                          PrimarySnackBar(
                                                              context,
                                                              "Please enter valid details.",
                                                              Colors.red);
                                                        }
                                                      },
                                                    )))),
                  if (_pageWidget == "auth") ...[
                    SizedBox(height: 3.h),
                    PrimaryIconButton(
                        title: "Continue as Guest",
                        icon: guest,
                        onPressed: () {
                          context
                              .read<AuthBloc>()
                              .add(LoggedInAsGuest());
                        }),
                  ]
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
