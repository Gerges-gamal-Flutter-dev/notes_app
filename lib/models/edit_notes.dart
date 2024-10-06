// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_sqflite_app/database/Sqldb.dart';
import 'package:flutter_sqflite_app/models/home_screen.dart';

class EditNotes extends StatefulWidget {
  final note;
  final title;
  final color;
  final id;
  const EditNotes({super.key, this.note, this.title, this.id, this.color});
  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  Sqldb sqldb = Sqldb();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController noteController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController colorController = TextEditingController();

  @override
  void initState() {
    noteController.text = widget.note;
    titleController.text = widget.title;
    colorController.text = widget.color;
    super.initState();
  }
  Color getColorFromHex(String hexColor) {
    return Color(int.parse(hexColor, radix: 16));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Notes'),
      ),
       body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: noteController,
                      decoration: const InputDecoration(
                        labelText: 'Note',
                        border: InputBorder.none,
                      ),
                      maxLines: 6,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a note';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: colorController,
                      decoration: const InputDecoration(
                        labelText: 'Color',
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a color';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      int response = await sqldb.updateData('''
                          UPDATE notes SET
                          title = '${titleController.text}',
                          note = '${noteController.text}', 
                          color = '${colorController.text}'
                          WHERE id = ${widget.id} 
                          ''');
            
                      if (response > 0) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Error: unable to update note!')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 12.0),
                    backgroundColor: const Color(0xFF507684),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text(
                    'Update Note',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    noteController.dispose();
    titleController.dispose();
    colorController.dispose();
    super.dispose();
  }
}
