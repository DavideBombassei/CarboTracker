import 'package:app19/main.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar')),
      body: _calendar(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (() => showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('New Event'),
                  content: TextFormField(
                    controller: _eventController,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel')),
                    TextButton(
                        onPressed: () {
                          if (_eventController.text.isEmpty) {
                            return;
                          } else {
                            if (selectedEvents[_selectedDay] != null) {
                              selectedEvents[_selectedDay]?.add(
                                Event(title: _eventController.text),
                              );
                            } else {
                              selectedEvents[_selectedDay] = [
                                Event(title: _eventController.text)
                              ];
                            }
                          }
                          Navigator.pop(context);
                          _eventController.clear();
                          setState(() {});
                          return;
                        },
                        child: Text('Confirm')),
                  ],
                ))),
        label: Text('New Event'),
        icon: Icon(Icons.add),
      ),
    );
  }

  Widget _calendar() => Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2010),
            lastDay: DateTime.utc(2030),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            eventLoader: _getEventsfromDay,
            headerStyle: HeaderStyle(formatButtonShowsNext: false),
            calendarStyle: CalendarStyle(
              todayDecoration:
                  BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
              selectedDecoration:
                  BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            ),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            startingDayOfWeek: StartingDayOfWeek.monday,
          ),
          ..._getEventsfromDay(_selectedDay).map((Event event) => ListTile(
                title: TextButton(
                    child: Text(event.title),
                    onPressed: () {},
                    onLongPress: () {
                      setState(() {
                        selectedEvents.clear();
                      });
                    }),
              )),
        ],
      );
}

class Event {
  final String title;
  Event({required this.title});

  String toString() => this.title;
}
