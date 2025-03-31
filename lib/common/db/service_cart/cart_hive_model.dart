// cart_hive_model.dart
import 'package:hive/hive.dart';

part 'cart_hive_model.g.dart';

@HiveType(typeId: 1)
class CartHiveModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final double totalAmount;

  @HiveField(2)
  final double discTotal;

  @HiveField(3)
  final double gTotal;

  @HiveField(4)
  final List<CartItemHiveModel> items;

  CartHiveModel({
    required this.id,
    required this.totalAmount,
    required this.discTotal,
    required this.gTotal,
    required this.items,
  });
}

@HiveType(typeId: 2)
class CartItemHiveModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String catId;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final double totalAmount;

  @HiveField(4)
  final List<CartItemChangeHiveModel>? alterations;

  @HiveField(5)
  final StitchingCartHiveModel? stitching;

  CartItemHiveModel({
    required this.id,
    required this.catId,
    required this.name,
    required this.totalAmount,
    this.alterations,
    this.stitching,
  });
}

@HiveType(typeId: 3)
class CartItemChangeHiveModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String label;

  @HiveField(2)
  final double price;

  CartItemChangeHiveModel({
    required this.name,
    required this.label,
    required this.price,
  });
}

@HiveType(typeId: 4)
class StitchingCartHiveModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final StitchingStylingHiveModel styling;

  StitchingCartHiveModel({
    required this.name,
    required this.styling,
  });
}

@HiveType(typeId: 5)
class StitchingStylingHiveModel extends HiveObject {
  @HiveField(0)
  final List<StitchingStyleHiveModel>? styles;

  StitchingStylingHiveModel({
    required this.styles,
  });
}

@HiveType(typeId: 6)
class StitchingStyleHiveModel extends HiveObject {
  @HiveField(0)
  final String label;

  @HiveField(1)
  final String value;

  StitchingStyleHiveModel({
    required this.label,
    required this.value,
  });
}