import 'package:bluetailor_app/common/cubit/user_cubit/app_user_cubit.dart';
import 'package:bluetailor_app/common/widgets/dialog_and_snackbar.dart.dart';
import 'package:bluetailor_app/common/widgets/phone_text_field.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/common/widgets/primary_text_field.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/core/theme/app_strings.dart';
import 'package:bluetailor_app/features/address/domain/entities/address_entity.dart';
import 'package:bluetailor_app/features/address/presentation/cubit/address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class AddAddress extends StatefulWidget {
  final AddressEntity? address;
  const AddAddress({super.key, this.address});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  String countryCode = "+91";

  @override
  void initState() {
    if (widget.address != null) {
      addressController.text = widget.address!.address;
      phoneController.text = widget.address!.phone;
      countryController.text = widget.address!.country;
      landmarkController.text = widget.address!.landmark;
      pincodeController.text = widget.address!.pincode;
      cityController.text = widget.address!.city;
      stateController.text = widget.address!.state;
      countryCode = widget.address!.countryCode;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlue,
        toolbarHeight: 8.h,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.all(17),
            child: SvgPicture.asset(backIcon),
          ),
        ),
        title: Text(
          "Address",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryTextField(
                title: "Address",
                border: true,
                controller: addressController,
                maxLines: 3,
              ),
              SizedBox(
                height: 2.h,
              ),
              PhoneTextField(
                border: true,
                controller: phoneController,
                onCountryChanged: (p0) {
                  countryCode = p0.dialCode!;
                  setState(() {});
                },
              ),
              Text(
                "(Phone number may be used to assist in delivery)",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: Colors.black.withOpacity(0.25)),
              ),
              SizedBox(
                height: 2.h,
              ),
              PrimaryTextField(
                title: "Landmark",
                border: true,
                controller: landmarkController,
              ),
              SizedBox(
                height: 2.h,
              ),
              PrimaryTextField(
                title: "Country",
                border: true,
                controller: countryController,
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                children: [
                  Expanded(
                      child: PrimaryTextField(
                    title: "Pincode",
                    border: true,
                    controller: pincodeController,
                  )),
                  SizedBox(
                    width: 5.w,
                  ),
                  Expanded(
                      child: PrimaryTextField(
                          title: "Town/City",
                          border: true,
                          controller: cityController)),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              PrimaryTextField(
                title: "State",
                border: true,
                controller: stateController,
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomAppBar(
        color: Colors.transparent,
        child: BlocListener<AddressCubit, AddressState>(
          listenWhen: (previous, current) =>
              previous.addressStatus != current.addressStatus,
          listener: (context, state) {
            if (state.addressStatus == AddressStatus.loading) {
              LoadingDialog(context);
            }
            if (state.addressStatus == AddressStatus.error) {
              Navigator.pop(context);
              PrimarySnackBar(context, "Something went wrong", Colors.red);
            }
            if (state.addressStatus == AddressStatus.saved) {
              Navigator.pop(context);
              context.read<AddressCubit>().fetchAddress();
              PrimarySnackBar(context, "Address is saved", Colors.green);
            }
            if (state.addressStatus == AddressStatus.loaded) {
              Navigator.pop(context);
            }
          },
          child: PrimaryGradientButton(
              title: "Submit",
              onPressed: () {
                final isValid = _formKey.currentState?.validate() ?? false;
                if (isValid) {
                  final user =
                      (context.read<AppUserCubit>().state as AppUserLoggedIn)
                          .user;
                  context.read<AddressCubit>().saveAddress(
                      landmark: landmarkController.text,
                      phone: phoneController.text,
                      address: addressController.text,
                      pincode: pincodeController.text,
                      city: cityController.text,
                      stateCountry: stateController.text,
                      countryCode: countryCode,
                      country: countryController.text,
                      user: user,
                      id: widget.address?.id);
                }
              }),
        ),
      ),
    );
  }
}