import 'package:flutter/material.dart';

class VerticalIconButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const VerticalIconButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: Colors.transparent, // Màu nền của Ink
        shape: BoxShape.circle, // Hình dạng của Ink là hình tròn
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50.0), // Độ cong của hình tròn
        splashColor: Colors.grey.withOpacity(0.5), // Màu sắc của hiệu ứng khi nhấn
        child: SizedBox(
          width: 56, // Đường kính của hình tròn
          height: 56, // Đường kính của hình tròn
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(height: 2.0),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
