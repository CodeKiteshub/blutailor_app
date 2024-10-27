// This file contains all the routes in the app
import 'package:bluetailor_app/common/widgets/bottom_navigation_bar.dart';
import 'package:bluetailor_app/features/address/domain/entities/address_entity.dart';
import 'package:bluetailor_app/features/address/presentation/cubit/address_cubit.dart';
import 'package:bluetailor_app/features/address/presentation/screens/add_address.dart';
import 'package:bluetailor_app/features/address/presentation/screens/address_list.dart';
import 'package:bluetailor_app/features/alteration/domain/entities/alteration_entity.dart';
import 'package:bluetailor_app/features/alteration/presentation/cubit/alteration_config/alteration_config_cubit.dart';
import 'package:bluetailor_app/features/alteration/presentation/cubit/save_alteration/save_alteration_cubit.dart';
import 'package:bluetailor_app/features/alteration/presentation/cubit/user_measurement/user_measurement_cubit.dart';
import 'package:bluetailor_app/features/alteration/presentation/screens/alteration_details.dart';
import 'package:bluetailor_app/features/alteration/presentation/screens/alteration_option.dart';
import 'package:bluetailor_app/features/alteration/presentation/screens/alteration_order_summary.dart';
import 'package:bluetailor_app/features/alteration/presentation/screens/select_alteraion_cat.dart';
import 'package:bluetailor_app/features/alteration/presentation/screens/upload_image.dart';
import 'package:bluetailor_app/features/appointment/data/model/appointment_model.dart';
import 'package:bluetailor_app/features/appointment/domain/entities/appointment_entity.dart';
import 'package:bluetailor_app/features/appointment/presentation/cubit/appointment_cubit.dart';
import 'package:bluetailor_app/features/appointment/presentation/screens/create_appointment.dart';
import 'package:bluetailor_app/features/auth/presentation/screens/auth_selection.dart';
import 'package:bluetailor_app/features/auth/presentation/screens/login_successful.dart';
import 'package:bluetailor_app/features/chat/presentation/screens/chat_screen.dart';
import 'package:bluetailor_app/features/chat/presentation/screens/media_history.dart';
import 'package:bluetailor_app/common/models/selected_cat_model.dart';
import 'package:bluetailor_app/features/measurement/presentation/cubit/body_profile/body_profile_cubit.dart';
import 'package:bluetailor_app/common/cubit/category_cubit/category_cubit.dart';
import 'package:bluetailor_app/features/measurement/presentation/cubit/measurement/measurement_cubit.dart';
import 'package:bluetailor_app/features/measurement/presentation/cubit/product_config/product_config_cubit.dart';
import 'package:bluetailor_app/features/measurement/presentation/cubit/size_chart/size_chart_cubit.dart';
import 'package:bluetailor_app/features/measurement/presentation/cubit/user_attribue/user_attribute_cubit.dart';
import 'package:bluetailor_app/features/measurement/presentation/cubit/user_measurement/user_measurement_cubit.dart';
import 'package:bluetailor_app/features/measurement/presentation/screens/body_details.dart';
import 'package:bluetailor_app/features/measurement/presentation/screens/body_images.dart';
import 'package:bluetailor_app/features/measurement/presentation/screens/measurement_details.dart';
import 'package:bluetailor_app/features/measurement/presentation/screens/measurement_home.dart';
import 'package:bluetailor_app/features/measurement/presentation/screens/select_garment_cat.dart';
import 'package:bluetailor_app/features/measurement/presentation/screens/selected_cat.dart';
import 'package:bluetailor_app/features/measurement/presentation/screens/standard_sizing.dart';
import 'package:bluetailor_app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:bluetailor_app/features/appointment/presentation/screens/appointment_details.dart';
import 'package:bluetailor_app/features/appointment/presentation/screens/appointment_history.dart';
import 'package:bluetailor_app/features/settings/presentation/screens/edit_profile.dart';
import 'package:bluetailor_app/features/settings/presentation/screens/order_detail.dart';
import 'package:bluetailor_app/features/settings/presentation/screens/orders.dart';
import 'package:bluetailor_app/features/settings/presentation/screens/settings.dart';
import 'package:bluetailor_app/features/splashes/presentation/screens/loading_screen.dart';
import 'package:bluetailor_app/features/splashes/presentation/screens/splash1_screen.dart';
import 'package:bluetailor_app/features/splashes/presentation/screens/splash2_screen.dart';
import 'package:bluetailor_app/features/splashes/presentation/screens/splash3_screen.dart';
import 'package:bluetailor_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'routes.main.dart';