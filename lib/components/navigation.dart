import 'package:flutter/material.dart';

class Nav {
  String label;
  IconData icon;
  Nav(this.label, this.icon);
}

List<Nav> nav = [
  Nav("Home", Icons.home),
  Nav("Todos", Icons.list_alt),
  Nav("Complete Todos", Icons.task),
  Nav("Incomplete Todos", Icons.description),
  Nav("Logout", Icons.logout),
];

BottomNavigationBar navigationbar(
    int selectedIndex, Function(int) onTapped, Function() onLoggedOut) {
  return BottomNavigationBar(
    items: nav
        .map((item) =>
            BottomNavigationBarItem(icon: Icon(item.icon), label: item.label))
        .toList(),
    unselectedItemColor: Colors.grey,
    selectedItemColor: Colors.blue,
    currentIndex: selectedIndex,
    onTap: (index) {
      index == 4 ? onLoggedOut() : onTapped(index);
    },
  );
}
