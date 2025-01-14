import 'package:bluetailor_app/common/entities/user.dart';
import 'package:bluetailor_app/features/address/domain/entities/address_entity.dart';
import 'package:bluetailor_app/features/address/domain/usecase/delete_address_usecase.dart';
import 'package:bluetailor_app/features/address/domain/usecase/fetch_address_list_usecase.dart';
import 'package:bluetailor_app/features/address/domain/usecase/save_address_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final SaveAddressUsecase _saveAddressUsecase;
  final DeleteAddressUsecase _deleteAddressUsecase;
  final FetchAddressListUsecase _fetchAddressListUsecase;
  AddressCubit(
      {required SaveAddressUsecase saveAddressUsecase,
      required DeleteAddressUsecase deleteAddressUsecase,
      required FetchAddressListUsecase fetchAddressList})
      : _saveAddressUsecase = saveAddressUsecase,
        _deleteAddressUsecase = deleteAddressUsecase,
        _fetchAddressListUsecase = fetchAddressList,
        super(AddressState.initial());

  int selectedAddress = 0;

  changeAddress(int index) {
    selectedAddress = index;
    emit(state.copyWith(addressStatus: AddressStatus.loaded));
  }

  fetchAddress() async {
    emit(state.copyWith(addressStatus: AddressStatus.loading));

    final res = await _fetchAddressListUsecase.call();

    res.fold(
        (l) => emit(state.copyWith(addressStatus: AddressStatus.error)),
        (r) => emit(
            state.copyWith(addressStatus: AddressStatus.loaded, addresses: r)));
  }

  saveAddress(
      {required String landmark,
      required String phone,
      required String address,
      required String pincode,
      required String city,
      required String stateCountry,
      required String countryCode,
      required String country,
      required String name,
      required User user,
      String? id}) async {
    emit(state.copyWith(addressStatus: AddressStatus.loading));

    final res = await _saveAddressUsecase(
      params: AddressEntity(
          landmark: landmark,
          phone: phone,
          address: address,
          pincode: pincode,
          city: city,
          state: stateCountry,
          countryCode: countryCode,
          country: country,
          user: user,
          name: name,
          id: id),
    );

    res.fold((l) => emit(state.copyWith(addressStatus: AddressStatus.error)),
        (r) => emit(state.copyWith(addressStatus: AddressStatus.saved)));
  }

  deleteAddress({required String id}) async {
    emit(state.copyWith(addressStatus: AddressStatus.loading));
    final res = await _deleteAddressUsecase.call(params: id);

    res.fold((l) => emit(state.copyWith(addressStatus: AddressStatus.error)),
        (r) => emit(state.copyWith(addressStatus: AddressStatus.deleted)));
  }
}
