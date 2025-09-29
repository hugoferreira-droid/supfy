import 'package:flutter/material.dart';

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Stack(
        children: [
          Positioned(
            left: 20,
            right: 20,
            top: 30,
            child: Container(
              height: 25,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFFD700),
                    Color(0xFFFF8C00),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          
          Positioned(
            left: 5,
            top: 15,
            child: Image.asset('assets/light.png', fit: BoxFit.cover, height: 50, width: 50,),
            
          ),
          
          Positioned(
            right: 15,
            top: -5,
            child: Text(
              '150',
              style: TextStyle(
                color: const Color(0xFF6B46C1),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          Positioned(
            right: 0,
            top: 15,
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFFFF8C00),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  "Watt's",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
