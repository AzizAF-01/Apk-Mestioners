import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:mentioners/SQLite/db_helper.dart';
import 'package:mentioners/selfCare_schedule/quote.dart';

class SelfCareSchedule extends StatefulWidget {
  const SelfCareSchedule({super.key});

  @override
  State<SelfCareSchedule> createState() => _SelfCareScheduleState();
}

class _SelfCareScheduleState extends State<SelfCareSchedule> {
  DateTime _selectedDay = DateTime.now();
  Map<DateTime, List<Event>> _events = {};

  @override
  void initState() {
    super.initState();
    _loadEventsForDay(_selectedDay);
  }

  Future<void> _loadEventsForDay(DateTime date) async {
    List<Event> events = await DatabaseHelper().fetchEventsByDate(date);
    setState(() {
      _events[date] = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/bg_mentioners.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.275,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(60, 135, 124, 1),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/Menu2.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'SelfCare-\nSchedule',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 36.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(60, 135, 124, 1),
                          ),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              List<Event> events = _getEventsForDay(_selectedDay);
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: constraints.maxWidth * 0.05),
                                      Text(
                                        'JADWAL HARIAN',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Spacer(),
                                      IconButton(
                                        icon: Icon(Icons.visibility, color: Colors.white), // Read
                                        onPressed: () {
                                          _selectDate(context);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.edit, color: Colors.white), // Update
                                        onPressed: () {
                                          _editSchedule(context, _selectedDay);
                                        },
                                      ),
                                    ],
                                  ),
                                  if (events.isEmpty)
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Center(
                                        child: Text(
                                          'Anda belum mengisi Jadwal Harian',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    Column(
                                      children: events.map((event) => ListTile(
                                        title: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              event.time.format(context),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                event.name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )).toList(),
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                        Quote(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Event> _getEventsForDay(DateTime day) {
    List<Event> events = _events[day] ?? [];
    events.sort((a, b) => a.compareTo(b));
    return events;
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: _selectedDay,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selected != null && selected != _selectedDay) {
      setState(() {
        _selectedDay = selected;
      });
      _loadEventsForDay(selected);
    }
  }

  Future<void> _editSchedule(BuildContext context, DateTime date) async {
    TextEditingController _nameController = TextEditingController();
    TimeOfDay _selectedTime = TimeOfDay.now();
    List<Event> events = _getEventsForDay(date);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tambah/Edit Jadwal'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                ...events.map((event) {
                  TextEditingController _eventNameController = TextEditingController(text: event.name);
                  TimeOfDay _eventTime = event.time;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _eventNameController,
                            decoration: InputDecoration(labelText: 'Kegiatan'),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.access_time),
                          onPressed: () async {
                            TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: _eventTime,
                            );
                            if (picked != null && picked != _eventTime) {
                              setState(() {
                                _eventTime = picked;
                              });
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.save),
                          onPressed: () async {
                            if (_eventNameController.text.isEmpty) {
                              await DatabaseHelper().deleteEvent(event.id!);
                              events.remove(event);
                            } else {
                              int index = events.indexOf(event);
                              Event updatedEvent = Event(
                                id: event.id,
                                name: _eventNameController.text,
                                time: _eventTime,
                                date: date,
                              );
                              await DatabaseHelper().updateEvent(updatedEvent);
                              events[index] = updatedEvent;
                            }
                            setState(() {
                              _events[date] = events;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(labelText: 'Kegiatan Baru'),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.access_time),
                        onPressed: () async {
                          TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: _selectedTime,
                          );
                          if (picked != null && picked != _selectedTime) {
                            setState(() {
                              _selectedTime = picked;
                            });
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () async {
                          if (_nameController.text.isNotEmpty) {
                            Event newEvent = Event(
                              name: _nameController.text,
                              time: _selectedTime,
                              date: date,
                            );
                            await DatabaseHelper().insertEvent(newEvent);
                            setState(() {
                              if (_events[date] != null) {
                                _events[date]!.add(newEvent);
                              } else {
                                _events[date] = [newEvent];
                              }
                              _nameController.clear();
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Selesai'),
            ),
          ],
        );
      },
    );
  }
}
