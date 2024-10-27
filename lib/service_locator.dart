import 'package:bluetailor_app/common/cubit/user_cubit/app_user_cubit.dart';
import 'package:bluetailor_app/core/api/api_client.dart';
import 'package:bluetailor_app/features/address/data/data_source/address_data_source.dart';
import 'package:bluetailor_app/features/address/data/repo/address_repo_impl.dart';
import 'package:bluetailor_app/features/address/domain/repo/address_repo.dart';
import 'package:bluetailor_app/features/address/domain/usecase/delete_address_usecase.dart';
import 'package:bluetailor_app/features/address/domain/usecase/fetch_address_list_usecase.dart';
import 'package:bluetailor_app/features/address/domain/usecase/save_address_usecase.dart';
import 'package:bluetailor_app/features/address/presentation/cubit/address_cubit.dart';
import 'package:bluetailor_app/features/alteration/data/data_source/alteration_data_source.dart';
import 'package:bluetailor_app/features/alteration/data/repo/alteration_repo_impl.dart';
import 'package:bluetailor_app/features/alteration/domain/repo/alteration_repo.dart';
import 'package:bluetailor_app/features/alteration/domain/usecase/fetch_alteraion_signed_url_usecase.dart';
import 'package:bluetailor_app/features/alteration/domain/usecase/fetch_alteration_config_usecase.dart';
import 'package:bluetailor_app/features/alteration/domain/usecase/fetch_user_measurement_usecase.dart';
import 'package:bluetailor_app/features/alteration/domain/usecase/save_alteration_usecase.dart';
import 'package:bluetailor_app/features/alteration/presentation/cubit/alteration_config/alteration_config_cubit.dart';
import 'package:bluetailor_app/features/alteration/presentation/cubit/save_alteration/save_alteration_cubit.dart';
import 'package:bluetailor_app/features/alteration/presentation/cubit/user_measurement/user_measurement_cubit.dart';
import 'package:bluetailor_app/features/appointment/data/data_source/appointment_data_source.dart';
import 'package:bluetailor_app/features/appointment/data/repo/appointment_repo_impl.dart';
import 'package:bluetailor_app/features/appointment/domain/repo/appointment_repo.dart';
import 'package:bluetailor_app/features/appointment/domain/usecase/fetch_appointment_usecase.dart';
import 'package:bluetailor_app/features/appointment/domain/usecase/save_appointment_usecase.dart';
import 'package:bluetailor_app/features/appointment/presentation/cubit/appointment_cubit.dart';
import 'package:bluetailor_app/features/auth/data/data_source/auth_data_source.dart';
import 'package:bluetailor_app/features/auth/data/repo/auth_repo_impl.dart';
import 'package:bluetailor_app/features/auth/domain/repo/auth_repo.dart';
import 'package:bluetailor_app/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:bluetailor_app/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:bluetailor_app/features/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:bluetailor_app/features/auth/domain/usecases/login_with_otp_usecase.dart';
import 'package:bluetailor_app/features/auth/domain/usecases/login_with_password_usecase.dart';
import 'package:bluetailor_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:bluetailor_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:bluetailor_app/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:bluetailor_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bluetailor_app/features/measurement/data/data_source/measurement_data_source.dart';
import 'package:bluetailor_app/features/measurement/data/repo/measurement_repo_impl.dart';
import 'package:bluetailor_app/features/measurement/domain/repo/measurement_repo.dart';
import 'package:bluetailor_app/features/measurement/domain/usecases/fetch_body_profile_usecase.dart';
import 'package:bluetailor_app/features/measurement/domain/usecases/fetch_cat_usecase.dart';
import 'package:bluetailor_app/features/measurement/domain/usecases/fetch_product_config.dart';
import 'package:bluetailor_app/features/measurement/domain/usecases/fetch_signed_url_usecase.dart';
import 'package:bluetailor_app/features/measurement/domain/usecases/fetch_size_chart_usecase.dart';
import 'package:bluetailor_app/features/measurement/domain/usecases/fetch_user_attribute_usecase.dart';
import 'package:bluetailor_app/features/measurement/domain/usecases/fetch_user_measurement_usecase.dart';
import 'package:bluetailor_app/features/measurement/domain/usecases/fetch_user_size_usecase.dart';
import 'package:bluetailor_app/features/measurement/domain/usecases/save_body_profile_usecase.dart';
import 'package:bluetailor_app/features/measurement/domain/usecases/save_measurement_usecase.dart';
import 'package:bluetailor_app/features/measurement/domain/usecases/save_standard_sizing_usecase.dart';
import 'package:bluetailor_app/features/measurement/presentation/cubit/body_profile/body_profile_cubit.dart';
import 'package:bluetailor_app/common/cubit/category_cubit/category_cubit.dart';
import 'package:bluetailor_app/features/measurement/presentation/cubit/measurement/measurement_cubit.dart';
import 'package:bluetailor_app/features/measurement/presentation/cubit/product_config/product_config_cubit.dart';
import 'package:bluetailor_app/features/measurement/presentation/cubit/size_chart/size_chart_cubit.dart';
import 'package:bluetailor_app/features/measurement/presentation/cubit/user_attribue/user_attribute_cubit.dart';
import 'package:bluetailor_app/features/measurement/presentation/cubit/user_measurement/user_measurement_cubit.dart';
import 'package:bluetailor_app/features/settings/data/data_source/settings_data_source.dart';
import 'package:bluetailor_app/features/settings/data/repo/settings_repo_impl.dart';
import 'package:bluetailor_app/features/settings/domain/repo/settings_repo.dart';
import 'package:bluetailor_app/features/settings/domain/usecases/edit_profile_usecase.dart';
import 'package:bluetailor_app/features/settings/domain/usecases/fetch_product_order_usecase.dart';
import 'package:bluetailor_app/features/settings/domain/usecases/fetch_profile_signed_url_usecase.dart';
import 'package:bluetailor_app/features/settings/domain/usecases/fetch_store_order_usecase.dart';
import 'package:bluetailor_app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'service_locator.main.dart';
