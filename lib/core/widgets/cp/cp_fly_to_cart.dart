import 'package:flutter/material.dart';
import 'cp_image.dart';

/// Plays a short "fly to cart" micro-interaction: a small copy of
/// [imageUrl] animates from the on-screen position of [fromKey] to the
/// on-screen position of [toKey], shrinking and fading out as it lands.
///
/// Call [onLanded] when the flying thumbnail reaches the cart icon so the
/// caller can pop/scale the cart badge at the right moment.
void flyToCart({
  required BuildContext context,
  required GlobalKey fromKey,
  required GlobalKey toKey,
  required String imageUrl,
  VoidCallback? onLanded,
}) {
  final overlay = Overlay.of(context, rootOverlay: true);

  final fromBox = fromKey.currentContext?.findRenderObject() as RenderBox?;
  final toBox = toKey.currentContext?.findRenderObject() as RenderBox?;
  if (fromBox == null || toBox == null || !fromBox.attached || !toBox.attached) {
    onLanded?.call();
    return;
  }

  const size = 44.0;
  final startCenter = fromBox.localToGlobal(
    fromBox.size.center(Offset.zero),
  );
  final endCenter = toBox.localToGlobal(toBox.size.center(Offset.zero));

  final startOffset = startCenter - const Offset(size / 2, size / 2);
  final endOffset = endCenter - const Offset(size / 2, size / 2);

  late OverlayEntry entry;
  entry = OverlayEntry(
    builder: (context) {
      return TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeInCubic,
        onEnd: () {
          entry.remove();
          onLanded?.call();
        },
        builder: (context, t, child) {
          // Slight arc: rise then fall toward the cart icon.
          final dx = startOffset.dx + (endOffset.dx - startOffset.dx) * t;
          final arc = -60 * (t < 0.5 ? t * 2 : (1 - t) * 2);
          final dy = startOffset.dy + (endOffset.dy - startOffset.dy) * t + arc;
          final scale = 1.0 - 0.55 * t;
          return Positioned(
            left: dx,
            top: dy,
            width: size,
            height: size,
            child: Opacity(
              opacity: t > 0.85 ? (1 - t) / 0.15 : 1.0,
              child: Transform.scale(
                scale: scale,
                child: Material(
                  elevation: 4,
                  shape: const CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  child: CpImage(imageUrl, fit: BoxFit.cover),
                ),
              ),
            ),
          );
        },
      );
    },
  );

  overlay.insert(entry);
}

/// Wraps [child] so it briefly "pops" (scale bounce) whenever [trigger]
/// changes value. Useful for badge counters that should animate when the
/// underlying count changes, e.g. a cart badge.
class CpBadgePop extends StatefulWidget {
  final Object? trigger;
  final Widget child;

  const CpBadgePop({super.key, required this.trigger, required this.child});

  @override
  State<CpBadgePop> createState() => _CpBadgePopState();
}

class _CpBadgePopState extends State<CpBadgePop> {
  int _bumpCount = 0;

  @override
  void didUpdateWidget(covariant CpBadgePop oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.trigger != widget.trigger) {
      setState(() => _bumpCount++);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: ValueKey(_bumpCount),
      tween: Tween(begin: _bumpCount == 0 ? 1.0 : 1.5, end: 1.0),
      duration: const Duration(milliseconds: 300),
      curve: Curves.elasticOut,
      builder: (context, scale, child) {
        return Transform.scale(scale: scale, child: child);
      },
      child: widget.child,
    );
  }
}
