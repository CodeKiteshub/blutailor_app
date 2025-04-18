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
import 'package:bluetailor_app/features/alteration/domain/usecase/add_alteration_to_cart_usecase.dart';
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
import 'package:bluetailor_app/features/cart/data/data_source/cart_data_source.dart';
import 'package:bluetailor_app/features/cart/data/repo/cart_repo_impl.dart';
import 'package:bluetailor_app/features/cart/domain/repo/cart_repo.dart';
import 'package:bluetailor_app/features/cart/domain/usecase/create_alteration_order_usecase.dart';
import 'package:bluetailor_app/features/cart/domain/usecase/create_product_order_usecase.dart';
import 'package:bluetailor_app/features/cart/domain/usecase/create_stitching_order_usecase.dart';
import 'package:bluetailor_app/features/cart/domain/usecase/fetch_cart_usecase.dart';
import 'package:bluetailor_app/features/cart/domain/usecase/fetch_product_cart_usecase.dart';
import 'package:bluetailor_app/features/cart/domain/usecase/process_alteration_order_usecase.dart';
import 'package:bluetailor_app/features/cart/domain/usecase/process_stitching_order_usecase.dart';
import 'package:bluetailor_app/features/cart/domain/usecase/remove_cart_item_usecase.dart';
import 'package:bluetailor_app/features/cart/domain/usecase/remove_item_from_product_cart.dart';
import 'package:bluetailor_app/features/cart/domain/usecase/validate_product_coupon_usecase.dart';
import 'package:bluetailor_app/features/cart/presentation/cubit/cart_cubit/cart_cubit.dart';
import 'package:bluetailor_app/features/cart/presentation/cubit/place_order_cubit/place_order_cubit.dart';
import 'package:bluetailor_app/features/cart/presentation/cubit/product_cart_cubit/product_cart_cubit.dart';
import 'package:bluetailor_app/features/custom_made/data/repo/custom_made_repo_impl.dart';
import 'package:bluetailor_app/features/custom_made/domain/repo/custom_made_repo.dart';
import 'package:bluetailor_app/features/custom_made/domain/usecase/add_item_to_cart_usecase.dart';
import 'package:bluetailor_app/features/custom_made/domain/usecase/fetch_product_usecase.dart';
import 'package:bluetailor_app/features/custom_made/presentation/cubit/product_cubit.dart';
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
import 'package:bluetailor_app/common/cubit/body_profile/body_profile_cubit.dart';
import 'package:bluetailor_app/common/cubit/category_cubit/category_cubit.dart';
import 'package:bluetailor_app/features/measurement/presentation/cubit/measurement/measurement_cubit.dart';
import 'package:bluetailor_app/features/measurement/presentation/cubit/product_config/product_config_cubit.dart';
import 'package:bluetailor_app/common/cubit/size_chart/size_chart_cubit.dart';
import 'package:bluetailor_app/common/cubit/user_attribue/user_attribute_cubit.dart';
import 'package:bluetailor_app/features/measurement/presentation/cubit/user_measurement/user_measurement_cubit.dart';
import 'package:bluetailor_app/features/settings/data/data_source/settings_data_source.dart';
import 'package:bluetailor_app/features/settings/data/repo/settings_repo_impl.dart';
import 'package:bluetailor_app/features/settings/domain/repo/settings_repo.dart';
import 'package:bluetailor_app/features/settings/domain/usecases/edit_profile_usecase.dart';
import 'package:bluetailor_app/features/settings/domain/usecases/fetch_orders_usecase.dart';
import 'package:bluetailor_app/features/settings/domain/usecases/fetch_product_order_usecase.dart';
import 'package:bluetailor_app/features/settings/domain/usecases/fetch_profile_signed_url_usecase.dart';
import 'package:bluetailor_app/features/settings/domain/usecases/fetch_store_order_usecase.dart';
import 'package:bluetailor_app/features/settings/presentation/bloc/product_order/product_order_cubit.dart';
import 'package:bluetailor_app/features/settings/presentation/bloc/settings/settings_bloc.dart';
import 'package:bluetailor_app/features/settings/presentation/bloc/store_order/store_order_cubit.dart';
import 'package:bluetailor_app/features/stitching/data/data_source/stitching_data_source.dart';
import 'package:bluetailor_app/features/stitching/data/repo/stitching_repo_impl.dart';
import 'package:bluetailor_app/features/stitching/domain/repo/stitching_repo.dart';
import 'package:bluetailor_app/features/stitching/domain/usecase/add_item_to_cart_usecase.dart';
import 'package:bluetailor_app/features/stitching/domain/usecase/fetch_custom_styling_usecase.dart';
import 'package:bluetailor_app/features/stitching/domain/usecase/fetch_stitching_signed_url_usecase.dart';
import 'package:bluetailor_app/features/stitching/domain/usecase/save_stitching_usecase.dart';
import 'package:bluetailor_app/features/stitching/presentation/cubit/stitching_cubit/stitching_cubit.dart';
import 'package:bluetailor_app/common/cubit/styling_cubit/styling_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/custom_made/data/data_source/custom_made_data_source.dart';

part 'service_locator.main.dart';

