import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackbuddy/models/Task.dart';
import 'package:trackbuddy/services/task_services.dart';
import 'package:trackbuddy/widgets/bottomNav.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  TaskService taskService = TaskService();

  Future<void> _addTask() async {
    final String title = _titleController.text;
    final String description = _descriptionController.text;
    final DateTime dueDate = DateTime.parse(_dateController.text); 

    if (title.isEmpty || description.isEmpty || _dateController.text.isEmpty) {
      // Show an error if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final newTask = Tasks(
      title: title,
      description: description,
      dueDate: dueDate,
      creator: '6659f8a38c3d7d2a1585a21c'
    );

    try {
      await taskService.addTask(newTask);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BottomNav()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add task: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: ListView(
          children: [
            /* appBar(context),
            const SizedBox(
              height: 30,
            ), */
            textFields(),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                _addTask();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                decoration: BoxDecoration(
                    color: const Color(0xffF26E56),
                    borderRadius: BorderRadius.circular(15)),
                child: const Center(
                  child: Text(
                    'Create Task',
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column textFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'New Task',
          style: TextStyle(
              color: Color(0xff000000),
              fontSize: 28,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        createTextField('Task title'),
        const SizedBox(
          height: 15,
        ),
        TextField(
          controller: _dateController,
          readOnly: true,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.date_range),
            hintText: 'Deadline',
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: Colors.black, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: Colors.black, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: Colors.black, width: 2),
            ),
          ),
          cursorColor: const Color(0xffF26E56),
          onTap: _selectDate,
        ),
        const SizedBox(
          height: 15,
        ),
        TextField(
          controller: _descriptionController,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: 'Description',
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: Colors.black, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: Colors.black, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: Colors.black, width: 2),
            ),
          ),
          cursorColor: const Color(0xffF26E56),
        )
      ],
    );
  }

  Row appBar(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15)),
            child: const Icon(
              CupertinoIcons.xmark,
              color: Colors.black,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15)),
            child: const Icon(
              CupertinoIcons.search,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  TextField createTextField(hint) {
    return TextField(
      controller: _titleController,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
      ),
      cursorColor: const Color(0xffF26E56),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        _dateController.text = picked.toString().split(" ")[0];
      });
    }
  }
}
