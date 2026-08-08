import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../features/auth/data/repositories/demo_auth_repository.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/cart/data/repositories/demo_cart_repository.dart';
import '../../features/cart/domain/repositories/cart_repository.dart';
import '../../features/orders/data/repositories/demo_order_repository.dart';
import '../../features/orders/domain/repositories/order_repository.dart';
import '../../features/product/data/repositories/demo_product_repository.dart';
import '../../features/product/domain/repositories/product_repository.dart';
import '../../features/wishlist/data/repositories/demo_wishlist_repository.dart';
import '../../features/wishlist/domain/repositories/wishlist_repository.dart';

/// Interface-typed DI providers — used by usecase providers so usecases
/// only ever depend on the domain-layer abstraction, never the concrete
/// Demo*Repository. These wrap the existing app-wide singletons; they do
/// not create new instances.
final cartRepositoryProvider = Provider<CartRepository>(
  (ref) => DemoCartRepository.instance,
);

final wishlistRepositoryProvider = Provider<WishlistRepository>(
  (ref) => DemoWishlistRepository.instance,
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => DemoAuthRepository.instance,
);

final orderRepositoryProvider = Provider<OrderRepository>(
  (ref) => DemoOrderRepository.instance,
);

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) => DemoProductRepository.instance,
);

/// Concrete ChangeNotifier-typed providers — used by widgets that need to
/// *reactively watch* repository state (cart badge, wishlist grid, order
/// list) via `ref.watch(...)`. Kept distinct from the interface-typed
/// providers above, which exist purely for DI into usecases. (Riverpod 3.x
/// moved ChangeNotifierProvider into the `legacy.dart` entrypoint.)
final cartChangeNotifierProvider = ChangeNotifierProvider<DemoCartRepository>(
  (ref) => DemoCartRepository.instance,
);

final wishlistChangeNotifierProvider =
    ChangeNotifierProvider<DemoWishlistRepository>(
  (ref) => DemoWishlistRepository.instance,
);

final orderChangeNotifierProvider =
    ChangeNotifierProvider<DemoOrderRepository>(
  (ref) => DemoOrderRepository.instance,
);

final authChangeNotifierProvider = ChangeNotifierProvider<DemoAuthRepository>(
  (ref) => DemoAuthRepository.instance,
);
