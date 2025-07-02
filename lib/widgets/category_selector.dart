// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class CategorySelector extends StatefulWidget {
//   final Function(String) onCategorySelected;
//
//   const CategorySelector({Key? key, required this.onCategorySelected}) : super(key: key);
//
//   @override
//   _CategorySelectorState createState() => _CategorySelectorState();
// }
//
// class _CategorySelectorState extends State<CategorySelector> {
//   String _selectedCategory = 'Food';
//
//   @override
//   Widget build(BuildContext context) {
//     List<String> categories = ['Food', 'Transport', 'Entertainment', 'Education', 'Other'];
//
//     return Wrap(
//       spacing: 8.0,
//       children: categories.map((category) {
//         bool isSelected = category == _selectedCategory;
//         return GestureDetector(
//           onTap: () {
//             setState(() => _selectedCategory = category);
//             widget.onCategorySelected(category);
//           },
//           child: AnimatedContainer(
//             duration: Duration(milliseconds: 300),
//             curve: Curves.easeInOut,
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             decoration: BoxDecoration(
//               color: isSelected ? Theme.of(context).primaryColor : Colors.grey[200],
//               borderRadius: BorderRadius.circular(20),
//               border: isSelected
//                   ? Border.all(color: Colors.deepPurple, width: 2)
//                   : null,
//             ),
//             child: Text(
//               category,
//               style: TextStyle(
//                   color: isSelected ? Colors.white : Colors.black,
//                   fontWeight: isSelected ? FontWeight.bold : FontWeight.normal
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;
  final Map<String, IconData> categoryIcons;

  const CategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.categoryIcons,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: categoryIcons.keys.map((category) {
        final isSelected = category == selectedCategory;
        return ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                categoryIcons[category],
                size: 18,
                color: isSelected ? Colors.white : const Color(0xFF2E5A88), // Grey-blue
              ),
              const SizedBox(width: 6),
              Text(category),
            ],
          ),
          selected: isSelected,
          onSelected: (selected) {
            if (selected) onCategorySelected(category);
          },
          selectedColor: const Color(0xFF1B4D3E), // Jungle green
          backgroundColor: const Color(0xFFF5F7FA), // Light grey-blue background
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isSelected
                  ? const Color(0xFF1B4D3E) // Jungle green
                  : const Color(0xFFB8C5D1), // Light grey-blue border
              width: 1.5,
            ),
          ),
          elevation: isSelected ? 3 : 1,
        );
      }).toList(),
    );
  }
}