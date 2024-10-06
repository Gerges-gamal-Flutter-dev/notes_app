import 'package:flutter/material.dart';
import 'package:flutter_sqflite_app/database/Sqldb.dart';
import 'package:flutter_sqflite_app/models/edit_notes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Sqldb sqldb = Sqldb();
  bool isLoaded = true;
  List<Map<String, dynamic>> notes = [];

  Future<void> readData() async {
    List<Map> response = await sqldb.readData("SELECT * FROM notes");
    setState(() {
      notes.addAll(response as Iterable<Map<String, dynamic>>);
      isLoaded = false;
    });
  }

  @override
  void initState() {
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notes, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Notes App',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ],
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF80C3F3), Color(0xFF507684)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: const Color(0xFF80C3F3),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      body: isLoaded
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    title: Text(
                      notes[index]['title'],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(notes[index]['note']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            int response = await sqldb.deleteData(
                                "DELETE FROM notes WHERE id = ${notes[index]['id']}");
                            if (response > 0) {
                              setState(() {
                                notes.removeAt(index);
                              });
                            }
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                              return EditNotes(
                                title: notes[index]['title'],
                                note: notes[index]['note'],
                                color: notes[index]['color'],
                                id: notes[index]['id'],
                              );
                            }));
                          },
                          icon: const Icon(Icons.edit, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                );
              }),
      bottomNavigationBar: MaterialButton(
        onPressed: () async {
          await sqldb.mydeleteDatabese();
          setState(() {
            notes.clear();
          });
        },
        color: const Color(0xFF507684),
        textColor: Colors.white,
        height: 60,
        child: const Text(
          "Delete All Notes",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
