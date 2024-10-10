import 'package:cached_network_image/cached_network_image.dart';
import 'package:catholicpal/models/celebration_model.dart';
import 'package:catholicpal/models/liturgical_day_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
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
                _showCompactLiturgicalDayDialog(context, selectedDay);
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
            bottom: 16,
            left: 16,
            child: Text(
              DateFormat('MMMM yyyy').format(focusedDay),
              style:  GoogleFonts.poppins(
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

  void _showCompactLiturgicalDayDialog(
      BuildContext context, DateTime selectedDay) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<CalendarProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (provider.hasError) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text('Failed to load liturgical data.'),
                actions: [
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            } else if (provider.liturgicalDay != null) {
              return _buildCompactLiturgicalDayDialog(provider.liturgicalDay!);
            } else {
              return const AlertDialog(
                title: Text('No Data'),
                content: Text('No liturgical data available for this date.'),
              );
            }
          },
        );
      },
    );
  }

  Widget _buildCompactLiturgicalDayDialog(LiturgicalDay liturgicalDay) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          maxWidth: 500,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDialogHeader(liturgicalDay.date),
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildInfoSection(liturgicalDay),
                      const SizedBox(height: 8),
                      _buildCelebrationsSection(liturgicalDay.celebrations),
                    ],
                  ),
                ),
              ),
            ),
            _buildDialogFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogHeader(DateTime date) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              DateFormat('MMMM d, yyyy').format(date),
              style:  GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(LiturgicalDay liturgicalDay) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Liturgical Information',
              style:  GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              'Season',
              liturgicalDay.season,
              HugeIcons.strokeRoundedCalendar01,
            ),
            _buildInfoRow(
              'Week',
              liturgicalDay.seasonWeek.toString(),
              HugeIcons.strokeRoundedTimeSetting02,
            ),
            _buildInfoRow(
              'Weekday',
              liturgicalDay.weekday,
              HugeIcons.strokeRoundedSunset,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor, size: 24,),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style:  GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCelebrationsSection(List<Celebration> celebrations) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Celebrations',
              style:  GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            _buildCelebrationsList(celebrations),
          ],
        ),
      ),
    );
  }

  Widget _buildCelebrationsList(List<Celebration> celebrations) {
    if (celebrations.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text('No celebrations for this day.'),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: celebrations.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final celebration = celebrations[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // width: 32,
                // height: 32,
                decoration: BoxDecoration(
                  color: _getCelebrationColor(celebration.colour),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    celebration.colour[0].toUpperCase(),
                    style:  GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      celebration.title,
                      style:  GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rank: ${celebration.rank}',
                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDialogFooter() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).pop(),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          shadowColor: Theme.of(context).primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          surfaceTintColor: Theme.of(context).primaryColor,
        ),
        child: const Text('Close'),
      ),
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
