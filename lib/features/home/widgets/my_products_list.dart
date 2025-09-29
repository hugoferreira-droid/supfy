import 'package:braip_clone/config/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:braip_clone/features/home/widgets/icon_card_widget.dart';
import 'package:braip_clone/features/home/widgets/product_header_widget.dart';

class MyProductsList extends StatelessWidget {
  const MyProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
      child: Column(
        children: [
          const IconCardWidget(),

          const ProductHeaderWidget(),
          Center(
            child: SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implementar ação do botão
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Ver Informações',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
