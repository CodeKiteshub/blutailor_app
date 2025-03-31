// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartHiveModelAdapter extends TypeAdapter<CartHiveModel> {
  @override
  final int typeId = 1;

  @override
  CartHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartHiveModel(
      id: fields[0] as String,
      totalAmount: fields[1] as double,
      discTotal: fields[2] as double,
      gTotal: fields[3] as double,
      items: (fields[4] as List).cast<CartItemHiveModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, CartHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.totalAmount)
      ..writeByte(2)
      ..write(obj.discTotal)
      ..writeByte(3)
      ..write(obj.gTotal)
      ..writeByte(4)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CartItemHiveModelAdapter extends TypeAdapter<CartItemHiveModel> {
  @override
  final int typeId = 2;

  @override
  CartItemHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartItemHiveModel(
      id: fields[0] as String,
      catId: fields[1] as String,
      name: fields[2] as String,
      totalAmount: fields[3] as double,
      alterations: (fields[4] as List?)?.cast<CartItemChangeHiveModel>(),
      stitching: fields[5] as StitchingCartHiveModel?,
    );
  }

  @override
  void write(BinaryWriter writer, CartItemHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.catId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.totalAmount)
      ..writeByte(4)
      ..write(obj.alterations)
      ..writeByte(5)
      ..write(obj.stitching);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CartItemChangeHiveModelAdapter
    extends TypeAdapter<CartItemChangeHiveModel> {
  @override
  final int typeId = 3;

  @override
  CartItemChangeHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartItemChangeHiveModel(
      name: fields[0] as String,
      label: fields[1] as String,
      price: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CartItemChangeHiveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.label)
      ..writeByte(2)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemChangeHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StitchingCartHiveModelAdapter
    extends TypeAdapter<StitchingCartHiveModel> {
  @override
  final int typeId = 4;

  @override
  StitchingCartHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StitchingCartHiveModel(
      name: fields[0] as String,
      styling: fields[1] as StitchingStylingHiveModel,
    );
  }

  @override
  void write(BinaryWriter writer, StitchingCartHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.styling);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StitchingCartHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StitchingStylingHiveModelAdapter
    extends TypeAdapter<StitchingStylingHiveModel> {
  @override
  final int typeId = 5;

  @override
  StitchingStylingHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StitchingStylingHiveModel(
      styles: (fields[0] as List?)?.cast<StitchingStyleHiveModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, StitchingStylingHiveModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.styles);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StitchingStylingHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StitchingStyleHiveModelAdapter
    extends TypeAdapter<StitchingStyleHiveModel> {
  @override
  final int typeId = 6;

  @override
  StitchingStyleHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StitchingStyleHiveModel(
      label: fields[0] as String,
      value: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StitchingStyleHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.label)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StitchingStyleHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
