import 'package:flutter/material.dart';
import 'package:braip_clone/features/home/widgets/icon_card_widget.dart';
import 'package:braip_clone/features/home/widgets/product_header_widget.dart';
import 'package:braip_clone/features/home/widgets/progress_bar_widget.dart';
import 'package:braip_clone/features/home/widgets/product_info_widget.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
      child: Column(
        children: [
          const IconCardWidget(),

          const ProductHeaderWidget(),

          const ProgressBarWidget(),
          const ProductInfoWidget(),
        ],
      ),
    );
  }
}
