import 'package:flutter/material.dart';
import '../../../../core/theme/cp_theme.dart';
import '../../../../core/widgets/coupang_widgets.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/review.dart';
import '../widgets/product_widgets.dart';
import '../../../cart/data/repositories/demo_cart_repository.dart';
import '../../../wishlist/data/repositories/demo_wishlist_repository.dart';
import '../../../cart/presentation/pages/cart_page.dart';

class CpProductDetailPage extends StatefulWidget {
  final Product product;
  const CpProductDetailPage({super.key, required this.product});

  @override
  State<CpProductDetailPage> createState() => _CpProductDetailPageState();
}

class _CpProductDetailPageState extends State<CpProductDetailPage>
    with SingleTickerProviderStateMixin {
  String? _selectedColor;
  String? _selectedOption;
  int _quantity = 1;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    return Scaffold(
      backgroundColor: CpColors.bg,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          // App Bar
          SliverAppBar(
            pinned: true,
            floating: false,
            backgroundColor: CpColors.white,
            elevation: innerBoxIsScrolled ? 1 : 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: CpColors.textMain),
              onPressed: () => Navigator.pop(context),
            ),
            title: AnimatedOpacity(
              opacity: innerBoxIsScrolled ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: Text(
                p.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: CpColors.textMain,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.share_outlined,
                  color: CpColors.textMain,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: CpColors.textMain,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CpCartPage()),
                ),
              ),
            ],
          ),

          // Image Gallery
          SliverToBoxAdapter(
            child: CpImageGallery(
              imageUrls: p.galleryImages.isNotEmpty
                  ? p.galleryImages
                  : [p.imageUrl],
            ),
          ),

          // Product Info Header
          SliverToBoxAdapter(
            child: Container(
              color: CpColors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (p.brand.isNotEmpty)
                    Text(
                      p.brand,
                      style: CpText.caption.copyWith(
                        color: CpColors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  const SizedBox(height: 4),
                  Text(
                    p.title,
                    style: CpText.h3.copyWith(
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      CpRating(rating: p.rating, count: p.reviewCount),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: CpColors.greenLight,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          '최고',
                          style: TextStyle(
                            fontSize: 10,
                            color: CpColors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  CpPrice(
                    price: p.price,
                    originalPrice: p.originalPrice,
                    discountPercent: p.discountPercent,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: CpColors.redLight,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: CpColors.red.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.local_offer, size: 14, color: CpColors.red),
                        const SizedBox(width: 4),
                        Text(
                          '10,000원 쿠폰 적용 가능',
                          style: TextStyle(
                            fontSize: 12,
                            color: CpColors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Delivery Info
          SliverToBoxAdapter(
            child: Container(
              color: CpColors.white,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: CpDeliveryInfo(
                isRocket: p.isRocket,
                arrivalText: p.arrivalText ?? '내일(토) 도착 보장',
              ),
            ),
          ),

          // Options & Quantity
          SliverToBoxAdapter(
            child: Container(
              color: CpColors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (p.colors.isNotEmpty) ...[
                    CpOptionSelector(
                      label: '색상',
                      options: p.colors,
                      selected: _selectedColor,
                      onSelect: (v) => setState(() => _selectedColor = v),
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (p.options.isNotEmpty) ...[
                    CpOptionSelector(
                      label: '옵션',
                      options: p.options,
                      selected: _selectedOption,
                      onSelect: (v) => setState(() => _selectedOption = v),
                    ),
                    const SizedBox(height: 16),
                  ],
                  Row(
                    children: [
                      Text(
                        '수량',
                        style: CpText.body.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      CpQuantitySelector(
                        initial: _quantity,
                        onChanged: (v) => setState(() => _quantity = v),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Tab Bar (pinned): stays connected to the collapsing header
          // above via SliverOverlapAbsorber, while each tab below scrolls
          // independently (like separate pages) through SliverOverlapInjector.
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverPersistentHeader(
              pinned: true,
              delegate: _SliverTabBarDelegate(
                TabBar(
                  controller: _tabController,
                  tabs: [
                    const Tab(text: '상품정보'),
                    Tab(text: '리뷰 ${_fmtCount(p.reviewCount)}'),
                    const Tab(text: 'Q&A'),
                  ],
                  labelColor: CpColors.blue,
                  unselectedLabelColor: CpColors.textMuted,
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  indicatorColor: CpColors.blue,
                  indicatorWeight: 2,
                ),
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _CpDetailTabBody(
              child: Column(
                    children: [
                      Container(
                        color: CpColors.white,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InfoRow(
                              label: '브랜드',
                              value: p.brand.isNotEmpty ? p.brand : 'Apple',
                            ),
                            InfoRow(
                              label: '모델명',
                              value: p.description ?? 'MQD83KH/A',
                            ),
                            InfoRow(label: '출시년월', value: '2023년 09월'),
                            InfoRow(label: '무게', value: '50.8g'),
                            InfoRow(label: '배터리', value: '최대 6시간 재생'),
                            const SizedBox(height: 16),
                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                color: CpColors.bg,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Text(
                                  '상품 상세 이미지',
                                  style: TextStyle(color: CpColors.textMuted),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 8, color: CpColors.bg),
                      CpRelatedCarousel(
                        title: '이 상품을 본 고객님들이 많이 본 상품',
                        children: [
                          RelatedItem(
                            imageUrl: 'assets/images/product_earbuds.jpg',
                            title: '삼성 갤럭시 버즈3 프로',
                            price: 229000,
                            discount: 18,
                          ),
                          RelatedItem(
                            imageUrl: 'assets/images/product_headphones.jpg',
                            title: 'Sony WH-1000XM5',
                            price: 389000,
                            discount: 15,
                          ),
                          RelatedItem(
                            imageUrl: 'assets/images/product_earbuds_lg.jpg',
                            title: 'LG 톤프리',
                            price: 179000,
                            discount: 20,
                          ),
                          RelatedItem(
                            imageUrl: 'assets/images/product_switch.jpg',
                            title: '닌텐도 스위치 OLED',
                            price: 368000,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
            ),

            // 리뷰
            _CpDetailTabBody(
              child: Column(
                  children: [
                    CpReviewSummary(
                      averageRating: 4.8,
                      totalCount: 6997,
                      distribution: const {
                        '최고': 84,
                        '좋음': 10,
                        '보통': 3,
                        '별로': 1,
                        '나쁨': 2,
                      },
                      aspectRatings: const {
                        '디자인': '아주 마음에 들어요',
                        '착용감': '아주 좋아요',
                        '음질': '아주 만족해요',
                        '사용 시간': '아주길어요',
                        '가성비': '성능에 비해 저렴해요',
                      },
                      aspectPercents: const {
                        '디자인': 86,
                        '착용감': 84,
                        '음질': 82,
                        '사용 시간': 64,
                        '가성비': 82,
                      },
                    ),
                    const Divider(height: 1, color: CpColors.divider),
                    CpReviewGallery(
                      imageUrls: [
                        'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202604/9/2785347277757081548/be51d9a2-8ac0-47db-9200-c2e2d283692a.jpg',
                        'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202604/9/2785347277757081548/a21b9e6d-b3d2-4b45-9d38-a6300aee1aeb.jpg',
                        'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202604/9/2785347277757081548/1e2d901d-942e-41c8-9489-ca40e4d6fc0b.jpg',
                        'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202604/9/2785347277757081548/e3117059-de7d-40b8-8c71-1b130fc3c75b.jpg',
                        'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202604/9/2785347277757081548/5dbb54f5-2937-4c87-89d7-89e48f47de09.jpg',
                        'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202604/9/2785347277757081548/72375519-3476-4bee-bc3f-64bb7e2dbeba.jpg',
                        'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202604/9/2785347277757081548/0bea56f0-6c01-462b-adc9-75a2ee2eb30e.jpg',
                      ],
                      totalCount: 246,
                    ),
                    const Divider(height: 1, color: CpColors.divider),
                    const CpReviewFilterBar(),
                    const Divider(height: 1, color: CpColors.divider),
                    CpReviewCard(
                      review: Review(
                        userName: '안*윤',
                        rating: 5,
                        date: '2026.07.18',
                        sellerName: '신이트레이딩 유한회사',
                        productOption:
                            'KONLI 커널형 무선 블루투스 이어폰 ACC ENC 노이즈 캔슬링 HiFi 고음질 C타입 이어폰, 블랙, T16',
                        images: [
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/18/6819185287374588889/6f608ddc-60d4-47e7-af40-6895842be357.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/18/6819185287374588889/20450cad-6ed2-4153-beda-b71cccdd4311.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/18/6819185287374588889/2f1d347f-004f-4a0b-854d-ec10d1fedfe6.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/18/6819185287374588889/08c57bb0-ac5e-4712-b0e6-31af28c447ae.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/18/6819185287374588889/be78126b-3a58-4408-b650-0dd2df29fd05.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/18/6819185287374588889/87aa5090-0548-4f37-b7d2-33b9d23ad8fe.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/18/6819185287374588889/1f8f2065-3b1c-4815-924a-d7292b842b51.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/18/6819185287374588889/3c32976a-005d-4bfd-8cbc-81e02e9b8e31.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/18/6819185287374588889/36955575-16c4-4bba-af83-0cdcb1aa789d.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/18/6819185287374588889/5f3b695b-74c7-4ff7-a4e2-84ebe13fd055.jpg',
                        ],
                        content:
                            '처음 연결할 때 블루투스 페어링이 빠르고 간편해서 사용하기 편했습니다. 한 번 연결해 두니 이후에는 케이스에서 이어폰을 꺼내기만 해도 자동으로 연결되어 번거로움이 없었습니다. 연결도 안정적이라 음악을 듣거나 영상을 볼 때 끊김 없이 사용할 수 있었습니다.\n\n커널형이라 귀에 안정적으로 밀착되어 외부 소음이 자연스럽게 차단되는 점이 좋았습니다. ENC 노이즈 캔슬링 기능 덕분에 주변 소음이 많은 곳에서도 음악이나 통화에 집중하기 쉬웠고, 통화할 때도 상대방 목소리가 또렷하게 들렸습니다. 상대방도 제 목소리가 선명하게 들린다고 해서 통화 품질에도 만족했습니다.\n\n음질도 기대 이상이었습니다. 저음은 묵직하고 탄탄하게 표현되며, 중음과 고음도 깨끗하게 들려 다양한 장르의 음악을 듣기에 좋았습니다. 유튜브나 영화 감상 시에도 소리가 선명해 몰입감이 높았고, 작은 소리까지 잘 표현되어 만족스러웠습니다.\n\n착용감도 편안한 편이었습니다. 귀에 안정적으로 고정되어 걷거나 가볍게 운동할 때도 쉽게 빠지지 않았고, 무게가 가벼워 장시간 착용해도 큰 부담이 없었습니다.',
                        subRatings: const {
                          '디자인': '아주 마음에 들어요',
                          '착용감': '아주 좋아요',
                          '음질': '아주 만족해요',
                          '가성비': '성능에 비해 저렴해요',
                          '사용 시간': '아주길어요',
                        },
                        likeCount: 1,
                      ),
                    ),
                    const Divider(height: 1, color: CpColors.divider),
                    CpReviewCard(
                      review: Review(
                        userName: '10181222',
                        rating: 5,
                        date: '2026.06.09',
                        sellerName: '왕샤오화이커머스 유한회사',
                        productOption:
                            'KONLI 커널형 무선 블루투스 이어폰 ACC ENC 노이즈 캔슬링 HiFi 고음질 C타입 이어폰, 화이트, T16',
                        title: '디자인 만족,배터리잔량 표시 만족!',
                        images: [
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202606/9/5605108580176584968/8ee1fbec-fb31-4a28-af78-ae91202baa41.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202606/9/5605108580176584968/c3577e97-f1bf-4879-b559-cbc259d7aa7f.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202606/9/5605108580176584968/674b9838-0448-4b17-a1f6-e1a7f49740e1.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202606/9/5605108580176584968/0f6e65e3-82ad-4eec-9bb9-5cda026ff7cb.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202606/9/5605108580176584968/71dd297d-2feb-4d36-9eb1-d6be1e8a3bf2.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202606/9/5605108580176584968/aea7163e-b212-4888-8ef4-84e0b41f0b0f.jpg',
                        ],
                        content:
                            '기존에 쓰던 블루투스 이어폰이 배터리가 너무 빨리 닳아서 가성비 좋은 제품 하나 찾다가 구매했어요. 평소 충전을 자주 깜빡하는 편이라 배터리 잔량이 바로 보이는 제품이면 좋겠다고 생각했는데 이 제품이 딱이더라고요.\n\n사용해보니 가장 만족스러운 건 전면 배터리 표시창이에요. 케이스를 열지 않아도 남은 배터리를 바로 확인할 수 있어서 충전 시기를 놓치는 일이 거의 없어졌어요. 저처럼 충전 맨날 까먹는 사람한테는 정말 편한 기능입니다.\n\n디자인도 깔끔하고 생각보다 블루투스 연결이 안정적이에요. 연결도 빠르게 잘 되고 끊김 없이 사용하고 있습니다. 이어폰 자체 크기도 크지 않아서 귀에 부담이 적은 편이에요. 저는 귓구멍이 작은 편이라 이어폰 잘못 사면 금방 귀가 아픈데, 이건 오래 착용해도 불편함이 적었어요.\n\n음질은 솔직히 몇 만 원대 제품 가격을 생각하면 충분히 만족스러운 수준이에요. 고가의 프리미엄 이어폰처럼 엄청난 음질을 기대하는 건 욕심일 것 같고, 음악 듣거나 영상 시청하는 용도로는 전혀 부족함 없이 사용하고 있습니다.\n\n굳이 아쉬운 점을 꼽자면 외부 소음 차단 기능은 거의 없는 편이에요. 조용한 실내에서는 괜찮지만 시끄러운 곳에서는 주변 소리가 꽤 들리는 편입니다. 다만 이 가격대 제품이라는 점을 생각하면 충분히 납득 가능한 수준이었어요.\n\n전체적으로 디자인, 착용감, 배터리 확인 기능까지 만족도가 높아서 가성비 이어폰 찾는 분들께 추천하고 싶어요. 특히 저처럼 충전을 자주 깜빡하는 분들이라면 정말 편하게 사용할 수 있을 것 같습니다.',
                        subRatings: const {
                          '디자인': '아주 마음에 들어요',
                          '착용감': '아주 좋아요',
                          '음질': '보통이에요',
                          '가성비': '적당한 편이에요',
                          '사용 시간': '아주길어요',
                        },
                        likeCount: 1,
                      ),
                    ),
                    const Divider(height: 1, color: CpColors.divider),
                    CpReviewCard(
                      review: Review(
                        userName: '지*린',
                        rating: 5,
                        date: '2026.08.06',
                        sellerName: '신이트레이딩 유한회사',
                        productOption:
                            'KONLI 커널형 무선 블루투스 이어폰 ACC ENC 노이즈 캔슬링 HiFi 고음질 C타입 이어폰, 블랙, T16',
                        title: '이어폰 진짜 잘 샀어요!!',
                        images: [
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202608/7/3354151274805258064/1870b9c5-1c72-480f-9f66-da9532b79c96.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202608/7/3354151274805258064/11e31623-ae4a-4b2d-b3f8-45d3a9e9cd5d.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202608/7/3354151274805258064/3b83a00d-d06e-4742-8a2c-90279a8a5489.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202608/7/3354151274805258064/50cb2e86-5663-4dac-8140-a3c514f13f6a.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202608/7/3354151274805258064/407ff04d-cca6-4157-8052-8200804a5cbf.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202608/7/3354151274805258064/1f0b90ea-f4d2-4358-9ac4-d02607a25528.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202608/7/3354151274805258064/8d450bf5-9314-462d-8d52-e38abea0a190.jpg',
                        ],
                        content:
                            '일단 디자인이 엄청 세련되고 고급스러워서 꺼낼 때부터 기분이 좋았어요.\n\nACC ENC 노이즈 캔슬링이 생각보다 너무 좋아서 놀랐어요. 지하철에서도 카페에서도 주변 소음이 확 줄어드니까 음악에 온전히 집중할 수 있어서 진짜 행복해요 ㅋㅋ\n\n음질도 HiFi 고음질답게 맑고 풍성해요. 보컬도 또렷하고 베이스도 적당히 묵직해서 장르 가리지 않고 다 잘 들려요. 통화할 때도 상대방 목소리가 선명하게 들리고 제 목소리도 잘 전달된다고 상대방이 말하더라고요.\n\n커널형이라 귀에 쏙 들어가고 착용감도 편안해요. 오래 껴도 귀가 아프지 않고 가벼워서 출퇴근길에 매일 사용 중이에요. C타입 충전이라 충전도 빠르고 배터리도 오래가서 더 좋아요.\n\n가격 대비 성능이 이 정도면 완전 혜자템이에요! 주변에 추천해줬더니 다들 만족스러워하네요. 이어폰 찾으시는 분들께 강력 추천합니다!!',
                        subRatings: const {
                          '디자인': '아주 마음에 들어요',
                          '착용감': '아주 좋아요',
                          '음질': '아주 만족해요',
                          '가성비': '성능에 비해 저렴해요',
                          '사용 시간': '아주길어요',
                        },
                        likeCount: 0,
                      ),
                    ),
                    const Divider(height: 1, color: CpColors.divider),
                    CpReviewCard(
                      review: Review(
                        userName: '민지',
                        rating: 5,
                        date: '2026.07.20',
                        sellerName: '신이트레이딩 유한회사',
                        productOption:
                            'KONLI 커널형 무선 블루투스 이어폰 ACC ENC 노이즈 캔슬링 HiFi 고음질 C타입 이어폰, 블랙, T16',
                        images: [
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/20/4524668593212029811/4fe572b0-e7e9-4f82-a008-84077a033a20.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/20/4524668593212029811/cddd1afb-ac7e-4c80-90f7-f22b310c19ac.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/20/4524668593212029811/c80ad3c8-799f-46a3-b9ae-2e422d34d884.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/20/4524668593212029811/5d3fb669-826f-42ae-82ed-de5ce95dd5cb.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/20/4524668593212029811/d1dcc0bb-bd1e-47ff-94ba-3c08401aa1f6.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/20/4524668593212029811/602ecc58-2231-42a6-96fe-5c6b5bfa8a98.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/20/4524668593212029811/957af6b9-1dc4-4687-93e7-34c39c84e6a5.jpg',
                        ],
                        content:
                            '출퇴근과 운동할 때 사용할 무선 이어폰을 찾다가 KONLI 커널형 블루투스 이어폰을 구매했습니다. 처음 연결할 때 페어링이 빠르고 간편해서 바로 사용할 수 있었고, 스마트폰과 연결도 안정적으로 유지되었습니다. 커널형이라 귀에 편안하게 밀착되어 움직일 때도 쉽게 빠지지 않아 만족스러웠습니다.\n\n음질은 저음과 고음의 균형이 좋아 음악을 듣거나 영상을 볼 때 소리가 선명하게 들렸고, HiFi 사운드답게 몰입감도 괜찮았습니다. ENC 노이즈 캔슬링 기능 덕분에 통화할 때 주변 소음이 어느 정도 줄어들어 상대방과 대화하기도 편했습니다. 터치 조작도 민감하게 잘 반응해 음악 재생과 통화 전환을 손쉽게 할 수 있었고, C타입 충전이라 충전도 간편했습니다.\n\n배터리도 한 번 충전하면 꽤 오래 사용할 수 있어 외출 시 충전 걱정이 적었습니다. 디자인도 깔끔하고 휴대성이 좋아 가방이나 주머니에 넣고 다니기 편했으며, 가격 대비 성능이 만족스러운 제품이라 일상에서 부담 없이 사용할 무선 이어폰을 찾는 분들에게 추천하고 싶습니다.',
                        subRatings: const {
                          '디자인': '아주 마음에 들어요',
                          '착용감': '아주 좋아요',
                          '음질': '아주 만족해요',
                          '가성비': '성능에 비해 저렴해요',
                          '사용 시간': '적당해요',
                        },
                        likeCount: 0,
                      ),
                    ),
                    const Divider(height: 1, color: CpColors.divider),
                    CpReviewCard(
                      review: Review(
                        userName: '담담',
                        rating: 5,
                        date: '2026.07.28',
                        sellerName: '신이트레이딩 유한회사',
                        productOption:
                            'KONLI 커널형 무선 블루투스 이어폰 ACC ENC 노이즈 캔슬링 HiFi 고음질 C타입 이어폰, 블랙, T16',
                        images: [
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/28/737149319306324902/6772723d-d3a6-492d-9b4a-1017c3322c77.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/28/737149319306324902/c3679398-8fe4-4497-abce-f9cf116aa2b6.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/28/737149319306324902/8cfd1ad8-a2e6-4109-920e-b3511b788f01.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/28/737149319306324902/9dffdec2-2714-4612-a935-e99d9631f43d.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/28/737149319306324902/c3d782bd-ef66-492c-aa8d-81108f49f001.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/28/737149319306324902/e8b19a39-dff8-4da5-89d4-c4bf802d28fc.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/28/737149319306324902/7652a97a-b2de-4d0f-b9de-12991ab6b100.jpg',
                        ],
                        content:
                            '오랫동안 착용해도 귀가 아프거나 불편하지 않았습니다. 귀에 잘 밀착되는 디자인이라 착용감이 좋았어요. 평소 밖에서 일할 때, 걸어 다니거나 계단을 오르내리고, 허리를 숙여 물건을 옮길 때도 착용했는데 쉽게 빠지지 않아 안정감이 있었습니다.\n\n음질도 기대 이상으로 만족스러웠습니다. 소리가 선명하고 고음이 깨끗하며, 보컬도 자연스럽게 들립니다. 음악을 듣거나 영상을 볼 때, 통화를 할 때 모두 편안하게 사용할 수 있었습니다. 노이즈 캔슬링 성능도 괜찮아서 길거리나 조금 시끄러운 환경에서도 주변 소음을 줄여 주어 통화가 더욱 또렷하게 들렸습니다.\n\n블루투스 연결도 빠른 편이라 이어폰을 꺼내면 거의 바로 연결되었고, 사용하면서 끊김이나 지연도 거의 없었습니다. 배터리도 오래가서 한 번 충전하면 충분히 사용할 수 있었고, C타입 충전이라 더욱 편리했습니다. 가격 대비 성능이 뛰어나 일상에서 사용하기에 매우 만족스러운 제품입니다.',
                        subRatings: const {
                          '디자인': '아주 마음에 들어요',
                          '착용감': '아주 좋아요',
                          '음질': '아주 만족해요',
                          '가성비': '적당한 편이에요',
                          '사용 시간': '아주길어요',
                        },
                        likeCount: 0,
                      ),
                    ),
                    const Divider(height: 1, color: CpColors.divider),
                    CpReviewCard(
                      review: Review(
                        userName: '꽁이',
                        rating: 5,
                        date: '2026.07.18',
                        sellerName: '신이트레이딩 유한회사',
                        productOption:
                            'KONLI 커널형 무선 블루투스 이어폰 ACC ENC 노이즈 캔슬링 HiFi 고음질 C타입 이어폰, 블랙, T16',
                        images: [
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/18/9171784280630219310/299317df-6dec-487b-bc0a-a9d2b59f5a19.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/18/9171784280630219310/e0eb9b30-a9f3-4606-af09-0d1f653c3f71.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/18/9171784280630219310/3edeab85-dc0b-4f1a-872b-881e14892ea4.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/18/9171784280630219310/5dc2ae12-6bc2-40ac-a075-a3835f0d3919.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/18/9171784280630219310/ac8a62ab-177a-4897-a2f1-5d08b6fce09f.jpg',
                        ],
                        content:
                            '무선 이어폰이 필요해서 구매했는데 기대보다 만족도가 높았어요 :)\n\n처음 연결도 어렵지 않았고 블루투스 페어링이 빠르게 돼서 바로 사용할 수 있었네요 ^^ 출퇴근할 때 음악도 듣고 통화도 자주 하는데 소리가 깔끔하게 들려서 만족하고 있어요 ㅎ\n\n착용감도 편안해서 오래 끼고 있어도 귀가 크게 불편하지 않았고 움직일 때도 잘 빠지지 않아서 좋았어요 ㅋ 노이즈 캔슬링 기능 덕분에 주변 소음이 줄어들어 음악에 더 집중할 수 있었고 통화할 때도 목소리가 또렷하게 전달되는 느낌이었어요\n\n배터리도 넉넉해서 자주 충전하지 않아도 사용할 수 있었고 케이스 크기도 적당해서 가방이나 주머니에 넣고 다니기 편했어요 디자인도 깔끔한 블랙이라 어디서 사용해도 무난하고 고급스러운 느낌이 들어 마음에 들었네요 ^^\n\n가격 대비 전체적인 완성도가 좋아서 만족스러운 구매였어요 앞으로도 매일 사용할 것 같아요 :)',
                        likeCount: 0,
                      ),
                    ),
                    const Divider(height: 1, color: CpColors.divider),
                    CpReviewCard(
                      review: Review(
                        userName: '버거왕',
                        rating: 5,
                        date: '2026.04.28',
                        sellerName: '바이라노 유한회사',
                        productOption:
                            'KONLI 커널형 무선 블루투스 이어폰 ACC ENC 노이즈 캔슬링 HiFi 고음질 C타입 이어폰, 블랙, T16',
                        title: '아주 좋아요!!',
                        images: [
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202604/28/5409278570015004271/4f88ece1-4c0a-4657-8b80-b6e5b70b6e46.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202604/28/5409278570015004271/ab751cb0-ca72-4b0e-aa56-83b004f25609.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202604/28/5409278570015004271/45b63c13-04b5-4bce-b7b5-eb97448bb984.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202604/28/5409278570015004271/cca88a10-5fd0-4ebf-8950-87724db26e6a.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202604/28/5409278570015004271/bc653983-a9d1-4b40-ac97-945af61e970b.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202604/28/5409278570015004271/633cd672-514e-43c5-89d2-0fd6ed491344.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202604/28/5409278570015004271/545a6612-d529-4e8f-90f2-524a84555308.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202604/28/5409278570015004271/01655215-3313-4c7f-96f2-0bd01cbeadf9.jpg',
                        ],
                        content:
                            '큰 기대없이 사긴 했는데 생각보다 너무 좋네요\n\n이어폰을 자주쓰진않고 그냥 걸을때 잠깐씩 쓰긴하는데 그래서 비싼건 그닥 생각하고 있지않아서 항상 저렴이로 사거든요\n\n근데 유선이어폰은 수명이 너무 짧더라구요 무선도 좋은건 안사다보니 수명이 길진않지만ㅠ 암튼 작년여름에 산 이어폰이 한쪽이 지지직 거리면서 소리가 안들리기 시작하더라구요\n\n급히 무선을 알아보던중 발견 일단 좀 제가 귓구멍이 작아서 크기도 좀 작은걸살까했는데 받고보니 뭐 그닥작지는 않아요 귀에꼽는 실리콘마개를 아무래도 더 작은걸로 바꿔야겠네요\n\n음질이 생각보다 너무 좋아요!!!! 유선쓸때는 그냥 그런가보다하고 썼는데 이게 듣고보니 확실히 비교가되네요 이게 그 소음을줄여주는 기능이 있다던데 확실히 있나봐요 음질이 좋더라구요 잘산거같아요♡♡♡♡♡',
                        subRatings: const {
                          '디자인': '아주 마음에 들어요',
                          '착용감': '아주 좋아요',
                          '음질': '아주 만족해요',
                          '가성비': '성능에 비해 저렴해요',
                          '사용 시간': '아주길어요',
                        },
                        likeCount: 4,
                      ),
                    ),
                    const Divider(height: 1, color: CpColors.divider),
                    CpReviewCard(
                      review: Review(
                        userName: '임*미',
                        rating: 5,
                        date: '2026.04.09',
                        sellerName: '바이라노 유한회사',
                        productOption:
                            'KONLI 커널형 무선 블루투스 이어폰 ACC ENC 노이즈 캔슬링 HiFi 고음질 C타입 이어폰, 블랙, T16',
                        title: '#안정적#실용성#사용간편의#커널형#고성능#C타입충전#고',
                        images: [
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202604/9/2785347277757081548/72375519-3476-4bee-bc3f-64bb7e2dbeba.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202604/9/2785347277757081548/be51d9a2-8ac0-47db-9200-c2e2d283692a.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202604/9/2785347277757081548/728981de-c93f-4f64-b754-2693e131beb0.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202604/9/2785347277757081548/0bea56f0-6c01-462b-adc9-75a2ee2eb30e.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202604/9/2785347277757081548/5dbb54f5-2937-4c87-89d7-89e48f47de09.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202604/9/2785347277757081548/1e2d901d-942e-41c8-9489-ca40e4d6fc0b.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202604/9/2785347277757081548/e3117059-de7d-40b8-8c71-1b130fc3c75b.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202604/9/2785347277757081548/a21b9e6d-b3d2-4b45-9d38-a6300aee1aeb.jpg',
                        ],
                        content:
                            '✅️KONLI 커널형 무선 블루투스 이어폰 ACC ENC 노이즈 캔슬링 HiFi 고음질 C타입 이어폰\n\n- 현재 사용하고 있던 이어폰이 통화할 때 상대방 목소리가 잘 들리지 않고, 블루투스 연결도 자주 끊겨 일상적인 사용에 불편함을 느끼고 있었어요. 특히 통화나 음악 감상 중에 끊김이 반복되다 보니 스트레스가 쌓여 빠르게 대체할 제품이 필요했어요.\n\n그래서 여러 제품을 비교하며 후기와 평점을 꼼꼼히 살펴봤고, 실제 사용자들의 만족도가 높고 가성비가 좋다는 평가가 많은 제품이 눈에 띄었어요. 성능과 가격 모두 괜찮다고 판단되어 믿고 구매하게 되었어요.\n\n⭕️특징\n* ACC + ENC 노이즈 캔슬링 -> 외부 소음을 줄이고 통화 음성을 또렷하게 전달합니다.\n* HiFi 고음질 -> 저음과 고음을 비교적 선명하게 들을 수 있어요\n* 커널형 디자인 -> 귀에 밀착되어 착용감과 차음성이 좋아요\n* 충전 -> C타입 충전의 편리함\n* 최신 블루투스 5.3 -> 전력 소모는 줄이고 연결 안정성은 높여 끊김 현상을 최소화\n\n✌️이런 분들께 추천드립니다.\n✔ 소음이 있는 환경에서 또렷한 통화와 음악 감상을 원하는 분\n✔ 가성비 좋은 무선 이어폰을 찾는 분\n✔ C타입 충전의 편리함을 선호하는 분\n✔ 커널형으로 착용감과 차음성을 중요하게 생각하는 분\n\n✌️총평 : KONLI(콘리) 커널형 무선 블루투스 이어폰은 통화 시 주변 소음을 효과적으로 줄여주면서 내 목소리를 또렷하게 전달해줘서 실사용에서 만족도가 높은 편이에요. 음악 감상에서도 전반적으로 깔끔하고 균형 잡힌 사운드를 들려줘서 일상용으로 부담 없이 사용하기 좋아요.\n\n귀에 밀착되는 커널형 구조라 착용감이 안정적이고 외부 소음 차단에도 도움을 줘서, 이동 중이나 야외에서도 몰입감 있게 사용할 수 있어요. 장시간 착용에도 큰 불편함이 없어서 편의성 면에서도 괜찮은 느낌이에요.\n\n배터리 성능도 충분히 여유 있는 편이라 이어폰 단독으로 약 7~8시간 사용이 가능하고, 충전 케이스까지 함께 활용하면 최대 40~88시간까지 사용할 수 있어 실사용에서 충전 부담이 적어요.\n\n전체적으로 가격 대비 성능과 편의성을 고루 갖춘 제품이라 데일리용 무선 이어폰을 찾는 분들께 무난하게 추천할 수 있고, 사용 환경이나 취향에 따라 만족도는 조금 달라질 수 있지만 가성비 측면에서는 충분히 고려해볼 만한 제품이에요.\n\n✔저는 물건이나 식품 구매할때 후기를 많이 보는 편이에요 제품사진만 보고 구매를 하기 때문에 이렇게 비교해서 보면 확실히 도움이 많이 되더라구요 여러 후기꼼꼼하게 읽어보시고 후회없는 구매하세요.\n\n✔가격대비 훌륭한 제품 이라고 생각합니다. 저는요 만족하면서 쓰고 있어요. 재구매 100% 입니다.\n\n✔바쁜시간 긴 글읽어주셔서 감사드립니다☺️☺️ 내돈내산 실제사용후기이며 구매하신분들 제가쓴글이 도움되길바래요. 좋은하루 되세요^^\n\n✨️ "도움이 돼요" 한번만 눌러주시면 감사합니다^^',
                        subRatings: const {
                          '디자인': '아주 마음에 들어요',
                          '착용감': '아주 좋아요',
                          '음질': '아주 만족해요',
                          '가성비': '성능에 비해 저렴해요',
                          '사용 시간': '적당해요',
                        },
                        likeCount: 13,
                      ),
                    ),
                    const Divider(height: 1, color: CpColors.divider),
                    CpReviewCard(
                      review: Review(
                        userName: '정*훈',
                        rating: 5,
                        date: '2026.03.14',
                        sellerName: '왕샤오화이커머스 유한회사',
                        productOption:
                            'KONLI 커널형 무선 블루투스 이어폰 ACC ENC 노이즈 캔슬링 HiFi 고음질 C타입 이어폰, 블랙, T16',
                        images: [
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202603/14/2821803541380697938/8834150d-2072-41b3-af43-0e6f942ace92.jpeg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202603/14/2821803541380697938/943f91f3-b205-4506-8ebe-3bf0ae1f4be2.jpeg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202603/14/2821803541380697938/e5cffd3f-baf3-491e-bd3b-91984cc6880c.jpeg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202603/14/2821803541380697938/2dd78333-5838-4944-a500-a0d83fe4949d.jpeg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202603/14/2821803541380697938/9b184e06-21bd-418c-a1d9-6960bbc07294.jpeg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202603/14/2821803541380697938/501de762-d552-4a39-aa48-f9009abbde99.jpeg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202603/14/2821803541380697938/3abac538-3e1d-4c89-b3ef-e8e5d5836592.jpeg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202603/14/2821803541380697938/a3a415b8-156d-4797-b335-71f23a8dff96.jpeg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202603/14/2821803541380697938/fa941ac8-2b03-46b8-8fa8-cd2034870144.jpeg',
                        ],
                        content:
                            '안녕하세요 30대 독신남 입니다. 오늘은 KONLI T16 커널형 무선 블루투스 이어폰 ACC ENC 노이즈 캔슬링 HiFi 고음질 C타입 이어폰 제품 리뷰를 작성해보겠습니다.\n\n저렴한 가격대의 무선 이어폰이 필요해서 구매했습니다. 커널형이라 귀에 꽂았을 때 차음이 어느 정도 되는 편이고, 블루투스 연결도 비교적 안정적으로 잡혔습니다. 일상적으로 음악 듣거나 영상 볼 때 쓰기에는 크게 불편함 없는 수준이었습니다.\n\n음질은 가격을 생각하면 무난한 편입니다. 저음이 아주 강한 스타일은 아니지만 고음과 저음 밸런스는 괜찮은 편이라 가볍게 듣기 좋았습니다. ENC 방식의 노이즈 캔슬링은 통화 시 주변 소음을 줄여주는 정도의 기능이라 완전히 소음을 차단하는 타입은 아닙니다.\n\n배터리는 한 번 충전하면 몇 시간 정도는 무난하게 사용할 수 있었고, C타입 충전이라 충전도 편했습니다. 가격대가 저렴한 가성비 제품이라 큰 기대만 하지 않으면 일상용으로는 충분한 느낌입니다.\n\n장점: 가격 대비 음질이 무난합니다. 블루투스 연결이 안정적인 편입니다. C타입 충전이라 편합니다. 가볍게 쓰기 좋은 가성비 이어폰입니다.\n단점: 고가 이어폰 수준의 노이즈 캔슬링은 아닙니다. 앱 지원이나 세밀한 설정 기능은 없는 편입니다. 음질도 하이엔드 수준은 아닙니다.\n\n전체적으로 큰 기대 없이 가성비 무선 이어폰을 찾는다면 무난하게 사용할 수 있는 제품이라고 느꼈습니다.',
                        subRatings: const {
                          '디자인': '보통이에요',
                          '착용감': '보통이에요',
                          '음질': '보통이에요',
                          '가성비': '성능에 비해 저렴해요',
                          '사용 시간': '적당해요',
                        },
                        likeCount: 6,
                      ),
                    ),
                    const Divider(height: 1, color: CpColors.divider),
                    CpReviewCard(
                      review: Review(
                        userName: '디궁다궁당',
                        rating: 5,
                        date: '2026.07.18',
                        sellerName: '신이트레이딩 유한회사',
                        productOption:
                            'KONLI 커널형 무선 블루투스 이어폰 ACC ENC 노이즈 캔슬링 HiFi 고음질 C타입 이어폰, 블랙, T16',
                        images: [
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/18/41874241845002468/db9ec8c5-c2bc-4b08-9d31-63ebfd4f1caa.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/18/41874241845002468/fc481b61-a2a9-4d80-9cb9-97d7e2d210f8.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/18/41874241845002468/ce7b92ab-e639-4151-a7f9-7ca0777c01a2.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/18/41874241845002468/0f515454-5b9f-4f61-889f-9a8237775e69.jpg',
                          'https://thumbnail.coupangcdn.com/thumbnails/local/320/image2/PRODUCTREVIEW/202607/18/41874241845002468/80affbfc-96d1-420e-91c6-76ffb9d49e9b.jpg',
                        ],
                        content:
                            '평소 음악을 자주 듣는 편이라 무선 이어폰을 찾다가 구매했는데 기대 이상으로 만족스럽네요 :)\n\n블랙 색상이 깔끔하고 케이스 디자인도 세련돼서 휴대하기 좋았어요. 크기도 부담스럽지 않아 가방이나 주머니에 넣고 다니기 편하더라고요 ^^\n\n착용감이 안정적이라 움직일 때도 쉽게 빠지지 않았고 귀에 부담이 적어서 장시간 사용하기 괜찮았어요. 음악을 들을 때 소리도 깔끔하게 들려서 만족스러웠답니다 ㅎ\n\n통화할 때 상대방 목소리가 선명하게 들리고 연결도 안정적인 편이라 일상생활에서 사용하기 좋았어요. 충전도 간편해서 자주 손이 가는 제품이에요 :)\n\n가성비 좋은 무선 이어폰을 찾고 계신다면 만족스럽게 사용할 수 있을 것 같아요 ^^',
                        likeCount: 0,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
            ),

            // Q&A
            _CpDetailTabBody(
              child: Container(
                  color: CpColors.white,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.help_outline,
                        size: 48,
                        color: CpColors.textMuted,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        '질문을 등록하세요',
                        style: TextStyle(
                          color: CpColors.textMuted,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: CpColors.blue,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          '질문 작성하기',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ListenableBuilder(
        listenable: DemoWishlistRepository.instance,
        builder: (context, _) {
          return CpActionBar(
            isWishlisted: DemoWishlistRepository.instance.isWishlisted(p.id),
            onWishlistTap: () =>
                DemoWishlistRepository.instance.toggle(p),
            onAddToCart: () {
              DemoCartRepository.instance.addItem(p, quantity: _quantity);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('장바구니에 담았습니다'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            onBuyNow: () {
              DemoCartRepository.instance.addItem(p, quantity: _quantity);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CpCartPage()),
              );
            },
          );
        },
      ),
    );
  }

  String _fmtCount(int c) {
    if (c >= 10000) return '${(c / 10000).toStringAsFixed(1)}만';
    if (c >= 1000) return '${(c / 1000).toStringAsFixed(1)}천';
    return c.toString();
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  _SliverTabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: CpColors.white, child: tabBar);
  }

  @override
  bool shouldRebuild(covariant _SliverTabBarDelegate oldDelegate) {
    return oldDelegate.tabBar != tabBar;
  }
}

/// Wraps one tab's content so it scrolls independently of the other tabs,
/// while staying vertically linked to the collapsible header above via
/// [NestedScrollView]'s overlap handle (see [NestedScrollView.headerSliverBuilder]).
class _CpDetailTabBody extends StatelessWidget {
  final Widget child;
  const _CpDetailTabBody({required this.child});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return CustomScrollView(
          key: PageStorageKey(child.hashCode),
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverToBoxAdapter(child: child),
          ],
        );
      },
    );
  }
}
