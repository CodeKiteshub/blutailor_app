import 'package:bluetailor_app/features/measurement/domain/entities/user_attribute_entity.dart';
import 'package:bluetailor_app/features/measurement/domain/usecases/fetch_user_attribute_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_attribute_state.dart';

class UserAttributeCubit extends Cubit<UserAttributeState> {
  final FetchUserAttributeUsecase _attributeUsecase;
  UserAttributeCubit(
      {required FetchUserAttributeUsecase fetchUserAttributeUsecase})
      : _attributeUsecase = fetchUserAttributeUsecase,
        super(UserAttributeInitial());

  fetchUserAttribute({required String master}) async {
    emit(UserAttributeLoading());
    final response = await _attributeUsecase.call(params: master);
    response.fold(
      (l) => emit(UserAttributeError(message: l.message)),
      (r) => emit(UserAttributeLoaded(userAttributes: r)),
    );
  }
}
