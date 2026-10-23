import 'package:flutter/material.dart';
import 'package:todo/notes.dart';
import 'package:todo/tasks.dart';

class Bottomdashpage extends StatefulWidget {
  const Bottomdashpage({super.key});

  @override
  State<Bottomdashpage> createState() => _BottomdashpageState();
}

class _BottomdashpageState extends State<Bottomdashpage> {
  int currentindex = 0;

  static const primaryColor = Color(0xFFFFB703);
  static const bgcolor = Color(0xFF302318);

  final List<Widget> pages = const [Notes(), TasksScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF090B10),

      // Page
      body: pages[currentindex],

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentindex,

        onTap: (index) {
          setState(() {
            currentindex = index;
          });
        },

        backgroundColor: bgcolor,

        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.black,

        selectedFontSize: 11,
        unselectedFontSize: 11,

        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.note_add_outlined),
            activeIcon: Icon(Icons.note_add),
            label: "Notepad",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.task_outlined),
            activeIcon: Icon(Icons.task_rounded),
            label: "Tasks",
          ),
        ],
      ),
    );
  }
}
