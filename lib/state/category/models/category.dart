import 'package:flutter/material.dart';

class Category {
  final String name;
  final Color color;
  final Icon icon;
  final bool isSelected;

  const Category({
    required this.name,
    required this.color,
    required this.icon,
    this.isSelected = false,
  });

// todo : this is not used yet, should it be for CRUD Category?
// todo : is the isSelected property needed?
  Category copyWith({
    required bool isSelected,
  }) =>
      Category(
        name: name,
        color: color,
        icon: icon,
        // isSelected: isSelected,
      );

  @override
  bool operator ==(covariant Category other) =>
      name == other.name && isSelected == other.isSelected;

  @override
  int get hashCode => Object.hashAll([
        name,
        isSelected,
      ]);
}
