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
  return index == target ? Colors.blue : Colors.black;
}

Drawer navigationbar(BuildContext context, selectedIndex,
    Function(int) onTapped, Function() onLoggedOut) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        ListTile(
          title: Row(
            children: [
              Icon(
                Icons.home,
                color: highlightLink(selectedIndex, 0),
              ),
              const SizedBox(
                width: 12,
              ),
              Text("Home",
                  style: TextStyle(
                    color: highlightLink(selectedIndex, 0),
                  ))
            ],
          ),
          onTap: () {
            onTapped(0);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Row(
            children: [
              Icon(
                Icons.list_alt,
                color: highlightLink(selectedIndex, 1),
              ),
              const SizedBox(
                width: 12,
              ),
              Text("Todos",
                  style: TextStyle(
                    color: highlightLink(selectedIndex, 1),
                  ))
            ],
          ),
          onTap: () {
            onTapped(1);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Row(
            children: [
              Icon(
                Icons.task,
                color: highlightLink(selectedIndex, 2),
              ),
              const SizedBox(
                width: 12,
              ),
              Text("Completed Todos",
                  style: TextStyle(
                    color: highlightLink(selectedIndex, 2),
                  ))
            ],
          ),
          onTap: () {
            onTapped(2);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Row(
            children: [
              Icon(
                Icons.description,
                color: highlightLink(selectedIndex, 3),
              ),
              const SizedBox(
                width: 12,
              ),
              Text("Incomplete todos",
                  style: TextStyle(
                    color: highlightLink(selectedIndex, 3),
                  ))
            ],
          ),
          onTap: () {
            onTapped(3);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Row(
            children: [
              const Icon(Icons.logout),
              const SizedBox(
                width: 12,
              ),
              Text("Logout",
                  style: TextStyle(
                    color: highlightLink(selectedIndex, 3),
                  ))
            ],
          ),
          onTap: () {
            onLoggedOut();
            Navigator.pop(context);
          },
        ),
      ],
    ),
    // items: nav
    //     .map((item) =>
    //         BottomNavigationBarItem(icon: Icon(item.icon), label: item.label))
    //     .toList(),
    // unselectedItemColor: Colors.grey,
    // selectedItemColor: Colors.blue,
    // currentIndex: selectedIndex,
    // onTap: (index) {
    //   index == 4 ? onLoggedOut() : onTapped(index);
    // },
  );
}
