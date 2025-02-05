// task_widgets.dart
import 'package:flutter/material.dart';
import 'package:flutter_todo_list/const/colors.dart';
import 'package:flutter_todo_list/data/firestor.dart';
import 'package:flutter_todo_list/model/notes_model.dart';
import 'package:flutter_todo_list/screen/edit_screen.dart';

class Task_Widget extends StatefulWidget {
  final Note _note;
  final bool isOld;
  Task_Widget(this._note, {super.key, this.isOld = false});

  @override
  State<Task_Widget> createState() => _Task_WidgetState();
}

class _Task_WidgetState extends State<Task_Widget> {
  @override
  Widget build(BuildContext context) {
    bool isDone = widget._note.isDon;

    // Use a beautiful red gradient when the task is older than 24 hours and not done.
    final BoxDecoration containerDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: (isDone)
          ? const LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 0, 128, 0) // Green gradient
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
          : (widget.isOld && !isDone)
              ? const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 255, 255, 255),
                    Color.fromARGB(255, 255, 0, 0) // Red gradient
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
      color: (widget.isOld && !isDone) ? null : Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 2),
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        width: double.infinity,
        height: 130,
        decoration: containerDecoration,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              imageee(),
              const SizedBox(width: 25),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget._note.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Checkbox(
                          activeColor: custom_green,
                          value: isDone,
                          onChanged: (value) {
                            setState(() {
                              isDone = !isDone;
                            });
                            Firestore_Datasource()
                                .isdone(widget._note.id, isDone);
                          },
                        )
                      ],
                    ),
                    Text(
                      widget._note.subtitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 81, 80, 80),
                      ),
                    ),
                    const Spacer(),
                    edit_time()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget edit_time() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 90,
            height: 28,
            decoration: BoxDecoration(
              color: custom_green,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  Image.asset('images/icon_time.png'),
                  const SizedBox(width: 10),
                  Text(
                    widget._note.time,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Edit_Screen(widget._note),
              ));
            },
            child: Container(
              width: 90,
              height: 28,
              decoration: BoxDecoration(
                color: const Color(0xffE2F6F1),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  children: [
                    Image.asset('images/icon_edit.png'),
                    const SizedBox(width: 10),
                    const Text(
                      'edit',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget imageee() {
    return Container(
      height: 130,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('images/${widget._note.image}.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
