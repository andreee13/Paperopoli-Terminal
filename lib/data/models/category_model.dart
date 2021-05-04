import 'package:flutter/material.dart';

class CategoryModel {
  final String name;
  final IconData mainIcon;
  final List<IconData> icons;

  const CategoryModel({
    required this.name,
    required this.mainIcon,
    required this.icons,
  });
}
