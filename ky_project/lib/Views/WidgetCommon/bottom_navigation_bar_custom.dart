import 'package:flutter/material.dart';

class BottomNavigationBarCustom extends StatefulWidget {
  final List<BottomNavigationBarItemCustom> children;
  late int currentIndex;
  final ValueChanged<int>? onTap;

  BottomNavigationBarCustom(
      {super.key, required this.children, this.currentIndex = 0, this.onTap});

  @override
  State<StatefulWidget> createState() => _BottomNavigationBarCustomState();
}

class _BottomNavigationBarCustomState extends State<BottomNavigationBarCustom> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
      child: BottomNavigationBar(
        items: widget.children,
        currentIndex: widget.currentIndex,
        onTap: (index) {
          setState(() {
            widget.currentIndex = index;
          });
          widget.onTap?.call(index);
        },
      ),
    );
  }
}

class BottomNavigationBarItemCustom extends BottomNavigationBarItem {
  BottomNavigationBarItemCustom(
      {required super.icon, super.activeIcon, super.label});

  factory BottomNavigationBarItemCustom.create(
      {required String icon, required String label}) {
    return BottomNavigationBarItemCustom(
        icon: _IconCustom(icon: icon),
        activeIcon: _IconCustom(icon: icon, isActive: true),
        label: label);
  }
}

class _IconCustom extends StatelessWidget {
  _IconCustom({required this.icon, this.isActive = false});

  final String icon;
  late bool isActive;

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      Theme.of(context).bottomNavigationBarTheme.selectedIconTheme;
      var selectedIconTheme =
          Theme.of(context).bottomNavigationBarTheme.selectedIconTheme;
      return Image.asset(icon,
          width: selectedIconTheme?.size,
          height: selectedIconTheme?.size,
          color: selectedIconTheme?.color);
    }

    var unselectedIconTheme =
        Theme.of(context).bottomNavigationBarTheme.unselectedIconTheme;
    return Image.asset(icon,
        width: unselectedIconTheme?.size,
        height: unselectedIconTheme?.size,
        color: unselectedIconTheme?.color);
  }
}
