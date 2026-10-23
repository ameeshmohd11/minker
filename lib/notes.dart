import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  static const Color backgroundColor = Color(0xFF090B10);
  static const Color cardColor = Color(0xFF17130F);
  static const Color dialogColor = Color(0xFF211910);
  static const Color inputColor = Color(0xFF302318);
  static const Color borderColor = Color(0xFF49321D);
  static const Color primaryColor = Color(0xFFFFB703);
  static const Color textColor = Color(0xFFF5F0E8);
  static const Color mutedTextColor = Color(0xFFB8AA98);

  final titleController = TextEditingController();
  final noteController = TextEditingController();
  final searchController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  List<Map<String, dynamic>> Notes = [
    {
      'header': 'Grocery Shopping',
      'body':
          'Buy milk, eggs, bread, and fresh vegetables from the supermarket.',
    },
    {
      'header': 'Meeting Notes',
      'body': 'Discuss the Q3 project timeline with the development team at 3:00 PM.',
    },
    {
      'header': 'Book Ideas',
      'body': 'Outline chapter one focusing on the protagonist\'s background and setting.',
    },
  ];

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    searchController.dispose();
    super.dispose();
  }

  // ADD NOTE
  void showAddNoteDialog() {
    titleController.clear();
    noteController.clear();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: dialogColor,
          title: const Text(
            'Add Note',
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
          content: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: titleController,
                    style: const TextStyle(color: textColor),
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(color: mutedTextColor),
                      filled: true,
                      fillColor: inputColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: noteController,
                    maxLines: 4,
                    style: const TextStyle(color: textColor),
                    decoration: const InputDecoration(
                      labelText: 'Write your note',
                      labelStyle: TextStyle(color: mutedTextColor),
                      filled: true,
                      fillColor: inputColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a note';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!formkey.currentState!.validate()) {
                          return;
                        }

                        setState(() {
                          Notes.add({
                            'header': titleController.text.trim(),
                            'body': noteController.text.trim(),
                          });
                        });

                        Navigator.pop(dialogContext);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: backgroundColor,
                      ),
                      child: const Text('Add Note'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // EDIT NOTE
  void showEditTaskDialog(int index) {
    titleController.text = Notes[index]['header']?.toString() ?? '';
    noteController.text = Notes[index]['body']?.toString() ?? '';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          title: const Text(
            'Edit Note',
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
          content: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: titleController,
                    style: const TextStyle(color: textColor),
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(color: mutedTextColor),
                      filled: true,
                      fillColor: inputColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: noteController,
                    maxLines: 4,
                    style: const TextStyle(color: textColor),
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: mutedTextColor),
                      filled: true,
                      fillColor: inputColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a note';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!formkey.currentState!.validate()) {
                          return;
                        }

                        setState(() {
                          Notes[index]['header'] = titleController.text.trim();
                          Notes[index]['body'] = noteController.text.trim();
                        });

                        Navigator.pop(dialogContext);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: backgroundColor,
                      ),
                      child: const Text('Save Changes'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // DELETE NOTE
  void deleteNote(int index) {
    setState(() {
      Notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final querysearched = searchController.text.trim().toLowerCase();

    final filteredtasks = Notes.where((note) {
      final header = note['header']?.toString().toLowerCase() ?? '';
      final body = note['body']?.toString().toLowerCase() ?? '';

      return header.contains(querysearched);
    }).toList();

    return Scaffold(
      backgroundColor: backgroundColor,

      // ADD NOTE BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: showAddNoteDialog,
        backgroundColor: primaryColor,
        shape: const CircleBorder(),
        child: const Icon(CupertinoIcons.add, color: textColor),
      ),

      // APP BAR
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Notes',
              style: TextStyle(color: mutedTextColor, fontSize: 12),
            ),
            Text(
              'Notepad',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
                color: textColor,
              ),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SEARCH BAR
            TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              style: const TextStyle(color: textColor),
              decoration: InputDecoration(
                hintText: 'Search notes',
                hintStyle: const TextStyle(color: mutedTextColor),
                prefixIcon: const Icon(Icons.search, color: primaryColor),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          searchController.clear();
                          setState(() {});
                        },
                        icon: const Icon(
                          CupertinoIcons.xmark,
                          color: primaryColor,
                        ),
                      )
                    : null,
                filled: true,
                fillColor: inputColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // TOTAL NOTES
            Row(
              children: [
                const Text(
                  'Total Notes: ',
                  style: TextStyle(color: textColor, fontSize: 15),
                ),
                Text(
                  Notes.length.toString(),
                  style: const TextStyle(color: textColor, fontSize: 15),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // NOTES LIST
            Expanded(
              child: filteredtasks.isEmpty
                  ? Center(
                      child: Text(
                        querysearched.isEmpty
                            ? 'No Notes Found'
                            : 'No Matching Notes Found',
                        style: const TextStyle(
                          color: mutedTextColor,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: filteredtasks.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final item = filteredtasks[index];

                        return ListTile(
                          tileColor: cardColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),

                          // TITLE
                          title: Text(
                            item['header'] ?? '',
                            style: const TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          // DESCRIPTION
                          subtitle: Text(
                            item['body'] ?? '',
                            style: const TextStyle(color: mutedTextColor),
                          ),

                          // EDIT AND DELETE
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  showEditTaskDialog(index);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: mutedTextColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  deleteNote(index);
                                },
                                icon: const Icon(
                                  CupertinoIcons.trash,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
