import 'package:flutter/material.dart';
import 'hover_widgets.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isSolid;

  const CustomButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isSolid = true,
  });

  @override
  Widget build(BuildContext context) {
    return HoverScale(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 55,
          width: 200, // Fixed width as per design intent
          decoration: BoxDecoration(
            color: isSolid ? const Color(0xFF0089D0) : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            border: isSolid
                ? null
                : Border.all(color: const Color(0xFF0089D0), width: 2),
          ),
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      label.toUpperCase(),
                      style: TextStyle(
                        color: isSolid ? Colors.white : const Color(0xFF0089D0),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: const Color(
                    0xFF00A3E0,
                  ), // Slightly lighter blue for the circle
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
