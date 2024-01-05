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

Color highlightLink(int index, int target) {
  return index == target ? const Color(0xFFe74c3c) : Colors.black;
}

Drawer navigationbar(BuildContext context, selectedIndex,
    Function(int) onTapped, Function() onLoggedOut) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        ListTile(
          title: Text("Home",
              style: TextStyle(
                color: highlightLink(selectedIndex, 0),
              )),
          onTap: () {
            onTapped(0);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text("Todos",
              style: TextStyle(
                color: highlightLink(selectedIndex, 1),
              )),
          onTap: () {
            onTapped(1);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text("Completed Todos",
              style: TextStyle(
                color: highlightLink(selectedIndex, 2),
              )),
          onTap: () {
            onTapped(2);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text("Incomplete todos",
              style: TextStyle(
                color: highlightLink(selectedIndex, 3),
              )),
          onTap: () {
            onTapped(3);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text("Logout",
              style: TextStyle(
                color: highlightLink(selectedIndex, 3),
              )),
          onTap: () {
            onLoggedOut();
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
