

class CartItemEntity {
  String id;
  String catId;
  String name;
  dynamic totalAmount;
  List<CartItemChangeEntity>? alterations;
  StitchingCartEntity? stitching;
  CartItemEntity({
    required this.id,
    required this.catId,
    required this.name,
    required this.totalAmount,
     this.alterations,
     this.stitching
  });


  factory CartItemEntity.fromMap(Map<String, dynamic> map) {
    return CartItemEntity(
      id: map['_id'],
      catId: map['catId'],
      name: map['name'],
      totalAmount: map['totalAmount'],
      alterations: List<CartItemChangeEntity>.from(
        (map['alterations']).map<CartItemChangeEntity>(
          (x) => CartItemChangeEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
      stitching: StitchingCartEntity.fromMap(map['stitching'])
    );
  }
}

class CartItemChangeEntity {
  String name;
  String label;
  dynamic price;
  CartItemChangeEntity({
    required this.name,
    required this.label,
    required this.price,
  });

    factory CartItemChangeEntity.fromMap(Map<String, dynamic> map) {
    return CartItemChangeEntity(
      name: map['name'],
      label: map['label'],
      price: map['price'],
    );
  }
}


class StitchingCartEntity {
dynamic name;
StitchingStylingEntity styling;
StitchingCartEntity({
  required this.name,
  required this.styling,
});

  factory StitchingCartEntity.fromMap(Map<String, dynamic> map) {
    return StitchingCartEntity(
      name: map['name'],
      styling: StitchingStylingEntity.fromMap(map['styling'])
    );
  }
}



class StitchingStylingEntity {
  List<StitchingStyleEntity> styles;
  StitchingStylingEntity({
    required this.styles,
  });

    factory StitchingStylingEntity.fromMap(Map<String, dynamic> map) {
    return StitchingStylingEntity(
      styles: List<StitchingStyleEntity>.from(
        (map['styles']).map<StitchingStyleEntity>(
          (x) => StitchingStyleEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class StitchingStyleEntity {
  String label;
  String value;
  StitchingStyleEntity({
    required this.label,
    required this.value,
  });


  factory StitchingStyleEntity.fromMap(Map<String, dynamic> map) {
    return StitchingStyleEntity(
      label: map['label'],
      value: map['value'],
    );
  }
}