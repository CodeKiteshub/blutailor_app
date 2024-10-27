part of 'address_cubit.dart';

 class AddressState {
  final AddressStatus addressStatus;
  final List<AddressEntity>? addresses;

 const AddressState({required this.addressStatus, required this.addresses});

  static AddressState initial() =>
      const AddressState(addressStatus: AddressStatus.initial, addresses: null);

  AddressState copyWith(
          {AddressStatus? addressStatus, List<AddressEntity>? addresses}) =>
      AddressState(
          addressStatus: addressStatus ?? this.addressStatus,
          addresses: addresses ?? this.addresses);
}

enum AddressStatus { initial, saved, error, loading , loaded, deleted}
