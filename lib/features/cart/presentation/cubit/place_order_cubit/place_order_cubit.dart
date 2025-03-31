import 'dart:developer';

import 'package:bluetailor_app/common/entities/product_cart_entity.dart';
import 'package:bluetailor_app/common/entities/user.dart';
import 'package:bluetailor_app/common/models/address_model.dart';
import 'package:bluetailor_app/features/cart/domain/usecase/create_alteration_order_usecase.dart';
import 'package:bluetailor_app/features/cart/domain/usecase/create_product_order_usecase.dart';
import 'package:bluetailor_app/features/cart/domain/usecase/create_stitching_order_usecase.dart';
import 'package:bluetailor_app/features/cart/domain/usecase/process_alteration_order_usecase.dart';
import 'package:bluetailor_app/features/cart/domain/usecase/process_stitching_order_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

part 'place_order_state.dart';

class PlaceOrderCubit extends Cubit<PlaceOrderState> {
  final _razorpay = Razorpay();
  final CreateAlterationOrderUsecase _createAlterationOrderUsecase;
  final ProcessAlterationOrderUsecase _processAlterationOrderUsecase;
  final CreateStitchingOrderUsecase _createStitchingOrderUsecase;
  final ProcessStitchingOrderUsecase _processStitchingOrderUsecase;
  final CreateProductOrderUsecase _createProductOrderUsecase;
  PlaceOrderCubit(
      {required CreateAlterationOrderUsecase createAlterationOrderUsecase,
      required ProcessAlterationOrderUsecase processAlterationOrderUsecase,
      required CreateStitchingOrderUsecase createStitchingOrderUsecase,
      required ProcessStitchingOrderUsecase processStitchingOrderUsecase,
      required CreateProductOrderUsecase createProductOrderUsecase})
      : _processAlterationOrderUsecase = processAlterationOrderUsecase,
        _createAlterationOrderUsecase = createAlterationOrderUsecase,
        _createStitchingOrderUsecase = createStitchingOrderUsecase,
        _processStitchingOrderUsecase = processStitchingOrderUsecase,
        _createProductOrderUsecase = createProductOrderUsecase,
        super(PlaceOrderInitial()) {
    _init();
  }

  bool isAlteration = true;
  String orderId = "";
  bool productOrder = false;
  AddressModel? addressDetail;
  ProductCartEntity? productCart;

  createProductOrder(
      {required AddressModel address,
      required ProductCartEntity cart,
      required User user}) async {
    emit(PlaceOrderLoading());
    productOrder = true;
    addressDetail = address;
    productCart = cart;
    initiatePayment(user: user, amount: cart.gTotal.toString());
  }

  placeAlterationOrder(
      {required String addressId,
      required String cartId,
      required User user,
      required String amount}) async {
    emit(PlaceOrderLoading());
    productOrder = false;
    isAlteration = true;
    final order = await _createAlterationOrderUsecase(
        params: CreateOrderParams(addressId: addressId, cartId: cartId));

    if (order.isRight()) {
      order.fold((l) => null, (r) {
        orderId = r;
      });
      if (amount == '0') {
        final res = await _processAlterationOrderUsecase(
            params:
                ProcessOrderUsecaseParams(orderId: orderId, razorpayId: ''));
        res.fold(
          (l) => emit(PlaceOrderError()),
          (r) => emit(PlaceOrderSuccess()),
        );
      } else {
        initiatePayment(user: user, amount: amount);
      }
    } else {
      emit(PlaceOrderError());
    }
  }

  placeStitchingOrder(
      {required String addressId,
      required String cartId,
      required User user,
      required String amount}) async {
    emit(PlaceOrderLoading());
    productOrder = false;
    isAlteration = false;
    final order = await _createStitchingOrderUsecase(
        params: CreateOrderParams(addressId: addressId, cartId: cartId));

    if (order.isRight()) {
      order.fold((l) => null, (r) {
        orderId = r;
      });
      if (amount == '0') {
        final res = await _processStitchingOrderUsecase(
            params:
                ProcessOrderUsecaseParams(orderId: orderId, razorpayId: ''));
        res.fold(
          (l) => emit(PlaceOrderError()),
          (r) => emit(PlaceOrderSuccess()),
        );
      } else {
        initiatePayment(user: user, amount: amount);
      }
    } else {
      emit(PlaceOrderError());
    }
  }

  _init() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  initiatePayment({required User user, required String amount}) async {
    var options = {
     //  'key': 'rzp_test_eNOPyOQE9LDqG1',
      'key': 'rzp_live_b0QHv1mxIL2uZp',
      'amount': "${double.parse(amount) * 100}",
      'name': user.firstName + ' ' + user.lastName,
      'description': user.id,
      'prefill': {'contact': user.phone, 'email': user.email},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      log(e.toString());
      emit(PlaceOrderError());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    if (productOrder) {
      try {
        final res = await _createProductOrderUsecase(
          params: CreateProductOrderParams(
              address: addressDetail!, cart: productCart!, razorpayId: response.paymentId!));

      res.fold(
        (l) => emit(PlaceOrderError()),
        (r) => emit(PlaceOrderSuccess()),
      );
      } catch (e) {
        emit(PlaceOrderError());
      }
    } else {
      if (isAlteration) {
        final res = await _processAlterationOrderUsecase(
            params: ProcessOrderUsecaseParams(
                orderId: orderId, razorpayId: response.paymentId!));
        res.fold(
          (l) => emit(PlaceOrderError()),
          (r) => emit(PlaceOrderSuccess()),
        );
      } else {
        final res = await _processStitchingOrderUsecase(
            params: ProcessOrderUsecaseParams(
                orderId: orderId, razorpayId: response.paymentId!));
        res.fold(
          (l) => emit(PlaceOrderError()),
          (r) => emit(PlaceOrderSuccess()),
        );
      }
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    emit(PlaceOrderError());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }
}
