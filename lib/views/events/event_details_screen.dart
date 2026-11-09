import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/event_model.dart';
import 'edit_event_screen.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventModel event;

  const EventDetailsScreen({super.key, required this.event});

  void _deleteEvent(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete Event"),
        content: const Text("Are you sure you want to delete this event?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              try {
                await FirebaseFirestore.instance
                    .collection('events')
                    .doc(event.id)
                    .delete();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Event deleted successfully")),
                );
                Navigator.pop(context);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Failed to delete: $e")),
                );
              }
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF101623)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Event details",
          style: TextStyle(color: Color(0xFF101623), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Color(0xFF5669FF)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditEventScreen(event: event),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () => _deleteEvent(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                event.categoryImage,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.grey[200],
                  child: const Center(child: Icon(Icons.image, size: 50, color: Colors.grey)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              event.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF101623)),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE0E0E0)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: Color(0xFF5669FF)),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.date, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF5669FF))),
                      Text(event.time, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Description",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF101623)),
            ),
            const SizedBox(height: 8),
            Text(
              event.description,
              style: const TextStyle(color: Colors.grey, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}