import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/signup_usecase.dart';
import '../../features/cart/domain/usecases/add_to_cart.dart';
import '../../features/cart/domain/usecases/get_cart_items.dart';
import '../../features/cart/domain/usecases/remove_from_cart.dart';
import '../../features/home/domain/usecases/get_home_products.dart';
import '../../features/orders/domain/usecases/get_orders.dart';
import '../../features/orders/domain/usecases/place_order.dart';
import '../../features/product/domain/usecases/get_category_products.dart';
import '../../features/product/domain/usecases/get_product_detail.dart';
import '../../features/product/domain/usecases/search_products.dart';
import '../../features/wishlist/domain/usecases/add_to_wishlist.dart';
import '../../features/wishlist/domain/usecases/get_wishlist_items.dart';
import '../../features/wishlist/domain/usecases/remove_from_wishlist.dart';
import 'repository_providers.dart';

// Cart
final addToCartUseCaseProvider = Provider<AddToCart>(
  (ref) => AddToCart(ref.watch(cartRepositoryProvider)),
);
final getCartItemsUseCaseProvider = Provider<GetCartItems>(
  (ref) => GetCartItems(ref.watch(cartRepositoryProvider)),
);
final removeFromCartUseCaseProvider = Provider<RemoveFromCart>(
  (ref) => RemoveFromCart(ref.watch(cartRepositoryProvider)),
);

// Wishlist
final addToWishlistUseCaseProvider = Provider<AddToWishlist>(
  (ref) => AddToWishlist(ref.watch(wishlistRepositoryProvider)),
);
final removeFromWishlistUseCaseProvider = Provider<RemoveFromWishlist>(
  (ref) => RemoveFromWishlist(ref.watch(wishlistRepositoryProvider)),
);
final getWishlistItemsUseCaseProvider = Provider<GetWishlistItems>(
  (ref) => GetWishlistItems(ref.watch(wishlistRepositoryProvider)),
);

// Auth
final loginUseCaseProvider = Provider<Login>(
  (ref) => Login(ref.watch(authRepositoryProvider)),
);
final signupUseCaseProvider = Provider<Signup>(
  (ref) => Signup(ref.watch(authRepositoryProvider)),
);
// Note: the login/signup usecase classes are named `Login` / `Signup`
// (rather than `LoginUseCase` / `SignupUseCase`) to match the existing
// naming already used by `login_usecase.dart` / `signup_usecase.dart`.
final logoutUseCaseProvider = Provider<LogoutUseCase>(
  (ref) => LogoutUseCase(ref.watch(authRepositoryProvider)),
);

// Home
final getHomeProductsUseCaseProvider = Provider<GetHomeProducts>(
  (ref) => GetHomeProducts(ref.watch(productRepositoryProvider)),
);

// Orders
final getOrdersUseCaseProvider = Provider<GetOrders>(
  (ref) => GetOrders(ref.watch(orderRepositoryProvider)),
);
final placeOrderUseCaseProvider = Provider<PlaceOrder>(
  (ref) => PlaceOrder(ref.watch(orderRepositoryProvider)),
);

// Product / search
final getProductDetailUseCaseProvider = Provider<GetProductDetail>(
  (ref) => GetProductDetail(ref.watch(productRepositoryProvider)),
);
final searchProductsUseCaseProvider = Provider<SearchProducts>(
  (ref) => SearchProducts(ref.watch(productRepositoryProvider)),
);
final getCategoryProductsUseCaseProvider = Provider<GetCategoryProducts>(
  (ref) => GetCategoryProducts(ref.watch(productRepositoryProvider)),
);
