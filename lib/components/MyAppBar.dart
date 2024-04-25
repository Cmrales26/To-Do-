// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  const MyAppBar({
    super.key,
    required this.title,
    required this.centerTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      toolbarHeight: 90,
      title: centerTitle // Verificar si el título debe estar centrado
          ? Center(child: Text(title)) // Si es verdadero, centrar el título
          : Text(title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
