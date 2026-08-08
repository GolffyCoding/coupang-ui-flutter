import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/cp_theme.dart';
import '../core/widgets/coupang_widgets.dart';
import '../core/providers/repository_providers.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/search/presentation/pages/search_page.dart';
import '../features/cart/presentation/pages/cart_page.dart';
import '../features/wishlist/presentation/pages/wishlist_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';

/// App-level shell that hosts the bottom navigation bar and switches
/// between the five top-level destinations: Home / Search / Cart /
/// Wishlist / My Coupang.
class CpRootShell extends ConsumerStatefulWidget {
  const CpRootShell({super.key});

  @override
  ConsumerState<CpRootShell> createState() => _CpRootShellState();
}

class _CpRootShellState extends ConsumerState<CpRootShell> {
  int _index = 0;

  void _goTo(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    final cartRepo = ref.watch(cartChangeNotifierProvider);
    final pages = [
      CpHomePage(
        embedded: true,
        onSearchTap: () => _goTo(1),
        onCartTap: () => _goTo(2),
        onMyPageTap: () => _goTo(4),
        onWishlistTap: () => _goTo(3),
      ),
      const CpSearchPage(),
      const CpCartPage(),
      const CpWishlistPage(),
      const CpProfilePage(),
    ];

    return Scaffold(
      backgroundColor: CpColors.bg,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 180),
        child: KeyedSubtree(key: ValueKey(_index), child: pages[_index]),
      ),
      bottomNavigationBar: CpBottomNav(
        currentIndex: _index,
        cartCount: cartRepo.totalItemCount,
        onTap: _goTo,
      ),
    );
  }
}
