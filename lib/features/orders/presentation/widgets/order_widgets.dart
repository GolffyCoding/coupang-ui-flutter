import 'package:flutter/material.dart';
import '../../../../core/theme/cp_theme.dart';
import '../../domain/entities/order.dart';

class CpOrderStatusChip extends StatelessWidget {
  final OrderStatus status;
  const CpOrderStatusChip({super.key, required this.status});

  Color get _color {
    switch (status) {
      case OrderStatus.paid:
        return CpColors.blue;
      case OrderStatus.preparing:
        return CpColors.orange;
      case OrderStatus.shipping:
        return CpColors.rocketBlue;
      case OrderStatus.delivered:
        return CpColors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: _color,
        ),
      ),
    );
  }
}

class CpDeliveryStepper extends StatelessWidget {
  final List<OrderStatus> steps;
  final int currentIndex;
  const CpDeliveryStepper({
    super.key,
    required this.steps,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(steps.length, (i) {
        final isDone = i <= currentIndex;
        final isLast = i == steps.length - 1;
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: isDone ? CpColors.blue : CpColors.bgGray,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isDone ? Icons.check : Icons.circle,
                      size: isDone ? 13 : 6,
                      color: isDone ? Colors.white : CpColors.textMuted,
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: i < currentIndex
                            ? CpColors.blue
                            : CpColors.bgGray,
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Padding(
                padding: const EdgeInsets.only(bottom: 24, top: 1),
                child: Text(
                  steps[i].label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isDone ? FontWeight.w700 : FontWeight.w400,
                    color: isDone ? CpColors.textMain : CpColors.textMuted,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
