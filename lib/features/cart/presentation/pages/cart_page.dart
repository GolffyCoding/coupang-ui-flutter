import 'package:flutter/material.dart';
import '../../../../core/theme/cp_theme.dart';
import '../../../../core/widgets/coupang_widgets.dart';
import '../../data/repositories/demo_cart_repository.dart';
import '../widgets/cart_widgets.dart';
import 'checkout_page.dart';
import '../../../wishlist/presentation/pages/wishlist_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../search/presentation/pages/category_page.dart';

class CpCartPage extends StatefulWidget {
  const CpCartPage({super.key});

  @override
  State<CpCartPage> createState() => _CpCartPageState();
}

class _CpCartPageState extends State<CpCartPage> {
  final _repo = DemoCartRepository.instance;

  String _fmt(int v) => v.toString().replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (m) => '${m[1]},',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CpColors.bg,
      appBar: const CpHeader(title: '장바구니', showBack: false),
      drawer: CpAppDrawer(
        onWishlistTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CpWishlistPage()),
        ),
        onProfileTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CpProfilePage()),
        ),
        onCategoryTap: (name) => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CpCategoryPage(categoryName: name)),
        ),
      ),
      body: ListenableBuilder(
        listenable: _repo,
        builder: (context, _) {
          final items = _repo.getItems();
          if (items.isEmpty) {
            return CpEmptyState(
              icon: Icons.shopping_cart_outlined,
              message: '장바구니가 비어 있습니다',
              actionLabel: '쇼핑 계속하기',
              onAction: () => Navigator.popUntil(context, (r) => r.isFirst),
            );
          }
          final allSelected = items.every((i) => i.selected);
          final selectedItems = items.where((i) => i.selected).toList();
          final totalPrice = selectedItems.fold<int>(
            0,
            (sum, i) => sum + i.subtotal,
          );

          return Column(
            children: [
              Container(
                color: CpColors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: allSelected,
                      activeColor: CpColors.blue,
                      onChanged: (v) => _repo.setAllSelected(v ?? false),
                    ),
                    const Text(
                      '전체선택',
                      style: TextStyle(fontSize: 13, color: CpColors.textBody),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: _repo.clearSelected,
                      child: const Text(
                        '선택삭제',
                        style: TextStyle(
                          fontSize: 13,
                          color: CpColors.textMuted,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: CpColors.divider),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: items.length,
                  separatorBuilder: (_, __) =>
                      const Divider(height: 8, color: CpColors.bg),
                  itemBuilder: (context, i) {
                    final item = items[i];
                    return CpCartItemTile(
                      item: item,
                      onSelectChanged: (v) =>
                          _repo.setSelected(item.product.id, v ?? false),
                      onQuantityChanged: (q) =>
                          _repo.updateQuantity(item.product.id, q),
                      onRemove: () => _repo.removeItem(item.product.id),
                    );
                  },
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                decoration: BoxDecoration(
                  color: CpColors.white,
                  border: const Border(
                    top: BorderSide(color: CpColors.divider),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '총 상품금액',
                              style: CpText.caption.copyWith(fontSize: 12),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${_fmt(totalPrice)}원',
                              style: CpText.price.copyWith(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedItems.isEmpty
                                ? CpColors.textPlaceholder
                                : CpColors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          onPressed: selectedItems.isEmpty
                              ? null
                              : () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => CpCheckoutPage(
                                        items: selectedItems,
                                      ),
                                    ),
                                  );
                                },
                          child: Text(
                            '구매하기 (${selectedItems.length})',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
