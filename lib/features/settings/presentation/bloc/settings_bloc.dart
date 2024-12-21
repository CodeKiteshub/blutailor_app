import 'dart:async';

import 'package:bluetailor_app/common/models/signed_url_param.dart';
import 'package:bluetailor_app/core/img/functions_and_aws.dart';
import 'package:bluetailor_app/features/auth/domain/usecases/login_with_password_usecase.dart';
import 'package:bluetailor_app/features/settings/domain/entities/order_entity.dart';
import 'package:bluetailor_app/features/settings/domain/entities/product_order_entity.dart';
import 'package:bluetailor_app/features/settings/domain/entities/store_order_entity.dart';
import 'package:bluetailor_app/features/settings/domain/usecases/edit_profile_usecase.dart';
import 'package:bluetailor_app/features/settings/domain/usecases/fetch_orders_usecase.dart';
import 'package:bluetailor_app/features/settings/domain/usecases/fetch_product_order_usecase.dart';
import 'package:bluetailor_app/features/settings/domain/usecases/fetch_profile_signed_url_usecase.dart';
import 'package:bluetailor_app/features/settings/domain/usecases/fetch_store_order_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final EditProfileUsecase _editProfileUsecase;
  final FetchProfileSignedUrlUsecase _fetchProfileSignedUrlUsecase;
  final FetchStoreOrderUsecase _fetchStoreOrderUsecase;
  final FetchProductOrderUsecase _fetchProductOrderUsecase;
  final FetchOrdersUsecase _fetchOrdersUsecase;
  SettingsBloc(
      {required EditProfileUsecase editProfileUsecase,
      required FetchProfileSignedUrlUsecase fetchProfilePictureSignedUrl,
      required FetchOrdersUsecase fetchOrdersUsecase,
      required FetchStoreOrderUsecase fetchStoreOrderUsecase,
      required FetchProductOrderUsecase fetchProductOrderUsecase})
      : _editProfileUsecase = editProfileUsecase,
        _fetchProfileSignedUrlUsecase = fetchProfilePictureSignedUrl,
        _fetchOrdersUsecase = fetchOrdersUsecase,
        _fetchStoreOrderUsecase = fetchStoreOrderUsecase,
        _fetchProductOrderUsecase = fetchProductOrderUsecase,
        super(SettingsInitial()) {
    on<EditProfileEvent>(_editProfileEvent);
    on<FetchStoreOrderEvent>(_fetchStoreOrderEvent);
    on<FetchProductOrderEvent>(_fetchProductOrderEvent);
    on<FetchOrderHistoryEvent>(_fetchOrdersEvent);
  }

  FutureOr<void> _editProfileEvent(
      EditProfileEvent event, Emitter<SettingsState> emit) async {
    emit(SettingsLoading());
    String? profileUrl;
    if (event.profilePicPath != "" && event.profilePicPath.startsWith("https") == false) {
      profileUrl = await fetchProfileUrl(event.profilePicPath);
    }
    final result = await _editProfileUsecase.call(
        params: UserParams(
            firstName: event.firstName,
            lastName: event.lastName,
            email: event.email,
            phoneNumber: event.phone,
            profilePic: profileUrl ??
                (event.profilePicPath.startsWith("https") == true
                    ? event.profilePicPath
                    : null)));
    result.fold((failure) => emit(SettingsError(message: failure.message)),
        (message) => emit(EditProfileDone(message: message)));
  }

  Future<String?> fetchProfileUrl(String image) async {
    String? url;
    final res = await _fetchProfileSignedUrlUsecase.call(
        params: SignedUrlParam(type: "", ext: image.split(".").last));

    res.fold((l) {
      return null;
    }, (r) {
      url = r;
    });
    final response = await uploadToAWS(image, url ?? "");
    return response;
  }

  FutureOr<void> _fetchStoreOrderEvent(
      FetchStoreOrderEvent event, Emitter<SettingsState> emit) async {
    emit(SettingsLoading());
    final result = await _fetchStoreOrderUsecase.call();
    result.fold((failure) => emit(SettingsError(message: failure.message)),
        (storeOrders) => emit(StoreOrderLoaded(storeOrders: storeOrders)));
  }

  FutureOr<void> _fetchProductOrderEvent(
      FetchProductOrderEvent event, Emitter<SettingsState> emit) async {
    emit(SettingsLoading());
    final result = await _fetchProductOrderUsecase.call();
    result.fold(
        (failure) => emit(SettingsError(message: failure.message)),
        (productOrders) =>
            emit(ProductOrderLoaded(productOrders: productOrders)));
  }

  FutureOr<void> _fetchOrdersEvent(FetchOrderHistoryEvent event, Emitter<SettingsState> emit) async{
    emit(SettingsLoading());
    final result = await _fetchOrdersUsecase.call();
    result.fold((failure) => emit(SettingsError(message: failure.message)),
        (orders) => emit(OrderHistoryLoaded(orderHistory: orders)));
  }
}
