import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: NotesPage(),
  ));
}

class NotesPage extends StatefulWidget {
  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  TextEditingController controller = TextEditingController();

  List<String> notes = [];
  int? editIndex;

  void saveNote() {
    if (controller.text.isEmpty) return;

    setState(() {
      if (editIndex == null) {
        notes.add(controller.text);
      } else {
        notes[editIndex!] = controller.text;
      }

      controller.clear();
      editIndex = null;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Заметки'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
            ),

            ElevatedButton(
              onPressed: saveNote,
              child: Text(
                editIndex == null ? 'Сохранить' : 'Изменить',
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(notes[index]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            setState(() {
                              controller.text = notes[index];
                              editIndex = index;
                            });
                          },
                        ),

                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              notes.removeAt(index);

                              if (editIndex != null) {
                                controller.clear();
                                editIndex = null;
                              }
                            });
                          },
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
