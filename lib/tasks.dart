import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  static const Color backgroundColor = Color(0xFF090B10);
  static const Color cardColor = Color(0xFF17130F);
  static const Color dialogColor = Color(0xFF211910);
  static const Color inputColor = Color(0xFF302318);
  static const Color borderColor = Color(0xFF49321D);
  static const Color primaryColor = Color(0xFFFFB703);
  static const Color secondaryColor = Color(0xFFFF8500);
  static const Color textColor = Color(0xFFF5F0E8);
  static const Color mutedTextColor = Color(0xFFB8AA98);

  bool _isClicked = false;
  String? filterselected;

  final taskhController = TextEditingController();
  final taskbController = TextEditingController();
  final searchbController = TextEditingController();
  final taskPriorityController = TextEditingController(text: 'low');

  final formkey = GlobalKey<FormState>();
  final editkey = GlobalKey<FormState>();

  final edittaskscntrl = TextEditingController();
  final edittaskhcntrl = TextEditingController();

  final List<Map<String, dynamic>> tasks = [
    {
      'header': 'Update Privacy Policy',
      'body': 'Review the updated data ',
      'isCompleted': false,
      'priority': 'medium',
    },
    {
      'header': 'Organize Desktop Files',
      'body': 'Sort through old screenshots.',
      'isCompleted': false,
      'priority': 'low',
    },
    {
      'header': 'Prepare Q3 Budget Report',
      'body': 'Compile software subscription costs ',
      'isCompleted': false,
      'priority': 'high',
    },
  ];

  Color checkcolor(String? priority) {
    switch (priority) {
      case 'high':
        return Colors.red; // Red
      case 'medium':
        return Colors.yellowAccent; // Yellow/Gold
      default:
        return Colors.transparent;
    }
  }

  @override
  void dispose() {
    taskhController.dispose();
    taskbController.dispose();
    searchbController.dispose();
    taskPriorityController.dispose();
    edittaskscntrl.dispose();
    edittaskhcntrl.dispose();
    super.dispose();
  }

  void showAddTaskDialog() {
    taskhController.clear();
    taskbController.clear();
    taskPriorityController.text = 'low';
    String? selectedPriority = 'low';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: dialogColor, // Dark container background
          title: const Text(
            'Add Task',
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
          content: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Title:', style: TextStyle(color: mutedTextColor)),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: taskhController,
                    style: const TextStyle(color: textColor),
                    decoration: InputDecoration(
                      hintText: 'Enter the title',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: inputColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Write your note:',
                    style: TextStyle(color: mutedTextColor),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: taskbController,
                    style: const TextStyle(color: textColor),
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Enter Details',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: inputColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Field cannot be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Priority',
                    style: TextStyle(color: mutedTextColor),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    initialValue: selectedPriority,
                    dropdownColor: inputColor,
                    style: const TextStyle(color: textColor),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: inputColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'high',
                        child: Text('High', style: TextStyle(color: textColor)),
                      ),
                      DropdownMenuItem(
                        value: 'medium',
                        child: Text(
                          'Medium',
                          style: TextStyle(color: textColor),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'low',
                        child: Text('Low', style: TextStyle(color: textColor)),
                      ),
                    ],
                    onChanged: (value) {
                      selectedPriority = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor,
                      ),
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          setState(() {
                            tasks.add({
                              'header': taskhController.text.trim(),
                              'body': taskbController.text.trim(),
                              'isCompleted': false,
                              'priority': selectedPriority,
                            });
                          });
                          Navigator.pop(dialogContext);
                        }
                      },
                      child: const Text(
                        'Add Task',
                        style: TextStyle(color: textColor),
                      ),
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

  void showEditTaskDialog(Map<String, dynamic> taskItem) {
    edittaskscntrl.text = taskItem['header']?.toString() ?? '';
    edittaskhcntrl.text = taskItem['body']?.toString() ?? '';
    String? editpriority = taskItem['priority'] ?? 'low';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: dialogColor,
          title: const Text(
            'Edit The Task',
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
          content: Form(
            key: editkey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: edittaskscntrl,
                    style: const TextStyle(color: textColor),
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: inputColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
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
                    controller: edittaskhcntrl,
                    maxLines: 3,
                    style: const TextStyle(color: textColor),
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: inputColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Priority',
                      style: TextStyle(color: mutedTextColor),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: editpriority,
                    dropdownColor: inputColor,
                    style: const TextStyle(color: textColor),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: inputColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'high',
                        child: Text('High', style: TextStyle(color: textColor)),
                      ),
                      DropdownMenuItem(
                        value: 'medium',
                        child: Text(
                          'Medium',
                          style: TextStyle(color: textColor),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'low',
                        child: Text('Low', style: TextStyle(color: textColor)),
                      ),
                    ],
                    onChanged: (value) {
                      editpriority = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor,
                      ),
                      onPressed: () {
                        if (!editkey.currentState!.validate()) {
                          return;
                        }

                        setState(() {
                          taskItem['header'] = edittaskscntrl.text.trim();
                          taskItem['body'] = edittaskhcntrl.text.trim();
                          taskItem['priority'] = editpriority;
                        });

                        Navigator.pop(dialogContext);
                      },
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(color: textColor),
                      ),
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

  @override
  Widget build(BuildContext context) {
    final query = searchbController.text.trim().toLowerCase();

    final filteredTasks = tasks.where((task) {
      final header = task['header']?.toString().toLowerCase() ?? '';
      final body = task['body']?.toString().toLowerCase() ?? '';
      final priority = task['priority']?.toString().toLowerCase();

      final matchesQuery = header.contains(query) || body.contains(query);
      final matchesPriority =
          filterselected == null || priority == filterselected;

      return matchesQuery && matchesPriority;
    }).toList();

    final completedCount = tasks.where((t) => t['isCompleted'] == true).length;
    final double progressValue = tasks.isEmpty
        ? 0.0
        : completedCount / tasks.length;

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor, // Deep dark background matching theme
        floatingActionButton: FloatingActionButton(
          onPressed: showAddTaskDialog,
          backgroundColor: secondaryColor, // Vibrant coral red
          shape: const CircleBorder(),
          child: const Icon(CupertinoIcons.add, color: textColor),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Tasks',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 34,
              color: textColor,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Row(
                children: [
                  DropdownButton<String?>(
                    value: filterselected,
                    dropdownColor: cardColor,
                    icon: const Icon(Icons.filter_alt, color: textColor),
                    underline: const SizedBox(),
                    style: const TextStyle(color: textColor, fontSize: 13),
                    hint: const Text(
                      'Filter',
                      style: TextStyle(color: mutedTextColor),
                    ),
                    items: const [
                      DropdownMenuItem(value: null, child: Text('All')),
                      DropdownMenuItem(value: 'high', child: Text('High')),
                      DropdownMenuItem(value: 'medium', child: Text('Medium')),
                      DropdownMenuItem(value: 'low', child: Text('Low')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        filterselected = value;
                      });
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isClicked = !_isClicked;
                        if (!_isClicked) {
                          searchbController.clear();
                        }
                      });
                    },
                    icon: const Icon(CupertinoIcons.search, color: textColor),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              if (_isClicked)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: searchbController,
                    autofocus: true,
                    onChanged: (_) => setState(() {}),
                    style: const TextStyle(color: textColor),
                    decoration: InputDecoration(
                      hintText: 'Search tasks...',
                      hintStyle: const TextStyle(color: mutedTextColor),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: secondaryColor,
                      ),
                      suffixIcon: searchbController.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                searchbController.clear();
                                setState(() {});
                              },
                              icon: const Icon(
                                CupertinoIcons.xmark,
                                color: mutedTextColor,
                              ),
                            )
                          : null,
                      filled: true,
                      fillColor: cardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              // Overview Dashboard Card
              SizedBox(
                height: 160,
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    color: cardColor, // Dark teal card background
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderColor, width: 1.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Total Tasks: ",
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  tasks.length.toString(),
                                  style: const TextStyle(
                                    color: textColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text(
                                  "Completed: ",
                                  style: TextStyle(
                                    color: mutedTextColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  completedCount.toString(),
                                  style: const TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: progressValue,
                              color: primaryColor, // Bright cyan progress
                              backgroundColor: borderColor,
                              strokeWidth: 10,
                              strokeAlign: 6,
                            ),
                            Text(
                              "${(progressValue * 100).toStringAsFixed(0)}%",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: textColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 40),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Task List
              Expanded(
                child: filteredTasks.isEmpty
                    ? const Center(
                        child: Text(
                          'No tasks found',
                          style: TextStyle(color: mutedTextColor),
                        ),
                      )
                    : ListView.separated(
                        itemCount: filteredTasks.length,
                        itemBuilder: (context, index) {
                          final item = filteredTasks[index];
                          final completed = item['isCompleted'] == true;
                          final priority = item['priority']?.toString();

                          return Container(
                            decoration: BoxDecoration(
                              color: cardColor, // Task tile dark background
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: borderColor),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              title: Text(
                                item['header'] ?? "",
                                style: TextStyle(
                                  color: completed ? mutedTextColor : textColor,
                                  fontWeight: FontWeight.w500,
                                  decoration: completed
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                              subtitle: Text(
                                item['body'] ?? '',
                                style: const TextStyle(color: mutedTextColor),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    constraints: const BoxConstraints(),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    onPressed: () => showEditTaskDialog(item),
                                    icon: const Icon(
                                      Icons.edit,
                                      color: mutedTextColor,
                                      size: 18,
                                    ),
                                  ),
                                  IconButton(
                                    constraints: const BoxConstraints(),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        tasks.remove(item);
                                      });
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.trash,
                                      color: mutedTextColor,
                                      size: 18,
                                    ),
                                  ),
                                  IconButton(
                                    constraints: const BoxConstraints(),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        item['isCompleted'] = !completed;
                                      });
                                    },
                                    icon: Icon(
                                      completed
                                          ? CupertinoIcons.checkmark_square_fill
                                          : CupertinoIcons.square,
                                      color: completed
                                          ? secondaryColor
                                          : mutedTextColor,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: checkcolor(priority),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    height: 32,
                                    width: 4,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                      ),
              ),
              const SizedBox(height: 10),
              // Footer Legend
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    CircleAvatar(backgroundColor: Colors.red, radius: 5),
                    SizedBox(width: 6),
                    Text(
                      'High',
                      style: TextStyle(color: mutedTextColor, fontSize: 12),
                    ),
                    SizedBox(width: 16),
                    CircleAvatar(backgroundColor: Colors.yellow, radius: 5),
                    SizedBox(width: 6),
                    Text(
                      'Medium',
                      style: TextStyle(color: mutedTextColor, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
