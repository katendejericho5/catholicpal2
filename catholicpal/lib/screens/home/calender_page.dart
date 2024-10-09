import 'package:cached_network_image/cached_network_image.dart';
import 'package:catholicpal/models/celebration_model.dart';
import 'package:catholicpal/models/liturgical_day_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:catholicpal/providers/calendar_provider.dart';

class LiturgicalCalendarScreen extends StatefulWidget {
  const LiturgicalCalendarScreen({super.key});

  @override
  LiturgicalCalendarScreenState createState() =>
      LiturgicalCalendarScreenState();
}

class LiturgicalCalendarScreenState extends State<LiturgicalCalendarScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final calendarProvider =
        Provider.of<CalendarProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liturgical Calendar'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context, _focusedDay),
            TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              calendarFormat: CalendarFormat.month,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              startingDayOfWeek: StartingDayOfWeek.sunday,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                calendarProvider.fetchLiturgicalDay(selectedDay);
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Consumer<CalendarProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (provider.hasError) {
                  return Center(
                    child: Text(
                      'Error loading data',
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  );
                } else if (provider.liturgicalDay != null) {
                  return _buildLiturgicalInfo(provider.liturgicalDay!);
                } else {
                  return const Center(
                    child: Text(
                      'Select a day to see liturgical data.',
                      style:
                          TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, DateTime focusedDay) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, top: 5, left: 16, right: 16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    'https://images.pexels.com/photos/10628200/pexels-photo-10628200.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Container(),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: Text(
              DateFormat('MMMM yyyy').format(focusedDay),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiturgicalInfo(LiturgicalDay liturgicalDay) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDateHeader(liturgicalDay.date),
          const SizedBox(height: 16),
          _buildInfoRow('Season', liturgicalDay.season, Icons.event),
          _buildInfoRow(
              'Week', liturgicalDay.seasonWeek.toString(), Icons.view_week),
          _buildInfoRow('Weekday', liturgicalDay.weekday, Icons.calendar_today),
          const SizedBox(height: 24),
          Text(
            'Celebrations',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          _buildCelebrationsList(liturgicalDay.celebrations),
        ],
      ),
    );
  }

  Widget _buildDateHeader(DateTime date) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        DateFormat('MMMM d, yyyy').format(date),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCelebrationsList(List<Celebration> celebrations) {
    if (celebrations.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('No celebrations for this day.'),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: celebrations.length,
      itemBuilder: (context, index) {
        final celebration = celebrations[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            title: Text(
              celebration.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Rank: ${celebration.rank}',
            ),
            leading: CircleAvatar(
              backgroundColor: _getCelebrationColor(celebration.colour),
              child: Text(
                celebration.colour[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getCelebrationColor(String colour) {
    switch (colour.toLowerCase()) {
      case 'green':
        return Colors.green;
      case 'red':
        return Colors.red;
      case 'white':
        return Colors.grey[600]!;
      case 'purple':
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }
}

