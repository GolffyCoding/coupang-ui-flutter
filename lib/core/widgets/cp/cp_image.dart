import 'package:flutter/material.dart';
import '../../theme/cp_theme.dart';

/// Renders [path] as a bundled asset when it points into `assets/images/`,
/// otherwise falls back to loading it from the network. Lets product/demo
/// data mix locally-bundled images with real remote URLs (e.g. review
/// photos) without call sites needing to care which is which.
class CpImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  const CpImage(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.errorBuilder,
  });

  Widget _fallback(BuildContext context) =>
      errorBuilder?.call(context, 'load-error', null) ??
      Container(
        width: width,
        height: height,
        color: CpColors.bg,
        alignment: Alignment.center,
        child: const Icon(Icons.image, color: CpColors.textMuted),
      );

  @override
  Widget build(BuildContext context) {
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stack) => _fallback(context),
      );
    }
    return Image.network(
      path,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stack) => _fallback(context),
    );
  }
}
