// guest_cart_service.dart
import 'package:bluetailor_app/common/db/service_cart/cart_hive_model.dart';
import 'package:bluetailor_app/common/entities/cart_item_entity.dart';
import 'package:bluetailor_app/features/cart/domain/entities/cart_entity.dart';
import 'package:hive/hive.dart';

class GuestCartService {
  static const String _boxName = 'guest_cart';
  Future<void> initHive() async {
    Hive.registerAdapter(CartHiveModelAdapter());
    Hive.registerAdapter(CartItemHiveModelAdapter());
    Hive.registerAdapter(CartItemChangeHiveModelAdapter());
    Hive.registerAdapter(StitchingCartHiveModelAdapter());
    Hive.registerAdapter(StitchingStylingHiveModelAdapter());
    Hive.registerAdapter(StitchingStyleHiveModelAdapter());

    await Hive.openBox<CartHiveModel>(_boxName);
  }

  Future<void> saveCart(CartEntity cart) async {
    final box = Hive.box<CartHiveModel>(_boxName);

    final cartHiveModel = CartHiveModel(
      id: cart.id.toString(),
      totalAmount: cart.totalAmount.toDouble(),
      discTotal: cart.discTotal.toDouble(),
      gTotal: cart.gTotal.toDouble(),
      items:
          cart.items.map((item) => _convertToCartItemHiveModel(item)).toList(),
    );

    await box.put('guest_cart', cartHiveModel);
  }

  CartEntity? getCart() {
    final box = Hive.box<CartHiveModel>(_boxName);
    final cartHiveModel = box.get('guest_cart');

    if (cartHiveModel == null) return null;

    return CartEntity(
      id: cartHiveModel.id,
      totalAmount: cartHiveModel.totalAmount,
      discTotal: cartHiveModel.discTotal,
      gTotal: cartHiveModel.gTotal,
      items: cartHiveModel.items
          .map((item) => _convertToCartItemEntity(item))
          .toList(),
    );
  }

  Future<void> clearCart() async {
    final box = Hive.box<CartHiveModel>(_boxName);
    await box.clear();
  }

  CartItemHiveModel _convertToCartItemHiveModel(CartItemEntity item) {
    return CartItemHiveModel(
      id: item.id.toString(),
      catId: item.catId.toString(),
      name: item.name.toString(),
      totalAmount: item.totalAmount.toDouble(),
      alterations: item.alterations
          ?.map((a) => CartItemChangeHiveModel(
                name: a.name.toString(),
                label: a.label,
                price: a.price.toDouble(),
              ))
          .toList(),
      stitching: item.stitching != null
          ? StitchingCartHiveModel(
              name: item.stitching!.name.toString(),
              styling: StitchingStylingHiveModel(
                styles: item.stitching!.styling.styles
                    ?.map((s) => StitchingStyleHiveModel(
                          label: s.label,
                          value: s.value,
                        ))
                    .toList(),
              ),
            )
          : null,
    );
  }

  CartItemEntity _convertToCartItemEntity(CartItemHiveModel item) {
    return CartItemEntity(
      id: item.id,
      catId: item.catId,
      name: item.name,
      totalAmount: item.totalAmount,
      alterations: item.alterations
          ?.map((a) => CartItemChangeEntity(
                name: a.name,
                label: a.label,
                price: a.price,
              ))
          .toList(),
      stitching: item.stitching != null
          ? StitchingCartEntity(
              name: item.stitching!.name,
              styling: StitchingStylingEntity(
                styles: item.stitching!.styling.styles
                    ?.map((s) => StitchingStyleEntity(
                          label: s.label,
                          value: s.value,
                        ))
                    .toList(),
              ),
            )
          : null,
    );
  }

  Future<void> addItemToCart(CartItemEntity newItem) async {
    final box = Hive.box<CartHiveModel>(_boxName);
    CartHiveModel? existingCart = box.get('guest_cart');

    if (existingCart == null) {
      // Create new cart if doesn't exist
      final newCart = CartHiveModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        totalAmount: newItem.totalAmount ?? 0,
        discTotal: 0,
        gTotal: newItem.totalAmount ?? 0,
        items: [_convertToCartItemHiveModel(newItem)],
      );
      await box.put('guest_cart', newCart);
    } else {
      // Add item to existing cart
      double newTotalAmount =
          existingCart.totalAmount + (newItem.totalAmount ?? 0);

      List<CartItemHiveModel> updatedItems = [...existingCart.items];

      // Check if item already exists in cart
      int existingIndex =
          updatedItems.indexWhere((item) => item.id == newItem.id);

      if (existingIndex != -1) {
        // Update existing item
        updatedItems[existingIndex] = _convertToCartItemHiveModel(newItem);
      } else {
        // Add new item
        updatedItems.add(_convertToCartItemHiveModel(newItem));
      }

      final updatedCart = CartHiveModel(
        id: existingCart.id,
        totalAmount: newTotalAmount,
        discTotal: existingCart.discTotal,
        gTotal: newTotalAmount - existingCart.discTotal,
        items: updatedItems,
      );

      await box.put('guest_cart', updatedCart);
    }
  }

  // Add a method to remove item from cart
  Future<void> removeItemFromCart(String itemId) async {
    final box = Hive.box<CartHiveModel>(_boxName);
    CartHiveModel? existingCart = box.get('guest_cart');

    if (existingCart != null) {
      List<CartItemHiveModel> updatedItems =
          existingCart.items.where((item) => item.id != itemId).toList();

      double newTotalAmount = updatedItems.fold(
        0,
        (sum, item) => sum + (item.totalAmount ?? 0),
      );

      final updatedCart = CartHiveModel(
        id: existingCart.id,
        totalAmount: newTotalAmount,
        discTotal: existingCart.discTotal,
        gTotal: newTotalAmount - existingCart.discTotal,
        items: updatedItems,
      );

      await box.put('guest_cart', updatedCart);
    }
  }

  // Add a method to update item quantity
  Future<void> updateItemQuantity(String itemId, int quantity) async {
    final box = Hive.box<CartHiveModel>(_boxName);
    CartHiveModel? existingCart = box.get('guest_cart');

    if (existingCart != null) {
      List<CartItemHiveModel> updatedItems = [...existingCart.items];
      int itemIndex = updatedItems.indexWhere((item) => item.id == itemId);

      if (itemIndex != -1) {
        CartItemHiveModel existingItem = updatedItems[itemIndex];
        double unitPrice = existingItem.totalAmount / quantity;

        CartItemHiveModel updatedItem = CartItemHiveModel(
          id: existingItem.id,
          catId: existingItem.catId,
          name: existingItem.name,
          totalAmount: unitPrice * quantity,
          alterations: existingItem.alterations,
          stitching: existingItem.stitching,
        );

        updatedItems[itemIndex] = updatedItem;

        double newTotalAmount = updatedItems.fold(
          0,
          (sum, item) => sum + (item.totalAmount ?? 0),
        );

        final updatedCart = CartHiveModel(
          id: existingCart.id,
          totalAmount: newTotalAmount,
          discTotal: existingCart.discTotal,
          gTotal: newTotalAmount - existingCart.discTotal,
          items: updatedItems,
        );

        await box.put('guest_cart', updatedCart);
      }
    }
  }
}
