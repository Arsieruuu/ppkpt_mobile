import 'package:flutter/material.dart';

// Segmented Control Component untuk tab switching
class SegmentedControl extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onChanged;

  const SegmentedControl({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTab(
              context,
              0,
              'Selesai',
              selectedIndex == 0,
            ),
          ),
          Expanded(
            child: _buildTab(
              context,
              1,
              'Ditolak',
              selectedIndex == 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(BuildContext context, int index, String title, bool isSelected) {
    return GestureDetector(
      onTap: () => onChanged(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? const Color(0xFF1683FF) : Colors.white,
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF6D6D6D),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}