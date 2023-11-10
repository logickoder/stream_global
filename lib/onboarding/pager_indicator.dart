import 'package:flutter/material.dart';
import 'package:stream_global/app/dimens.dart';

class PagerIndicator extends StatelessWidget {
  final int currentPage;
  final int pageCount;

  const PagerIndicator({
    super.key,
    required this.currentPage,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => Container(
          width: AppDimens.padding / 2,
          height: AppDimens.padding / 2,
          margin: const EdgeInsets.symmetric(horizontal: AppDimens.padding / 4),
          decoration: BoxDecoration(
            color: index == currentPage
                ? Theme.of(context).colorScheme.primary
                : const Color(0xFFD9D9D9),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
