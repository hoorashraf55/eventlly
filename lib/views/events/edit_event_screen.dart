import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/event_model.dart';

class EditEventScreen extends StatefulWidget {
  final EventModel event;

  const EditEventScreen({super.key, required this.event});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.event.title);
    _descriptionController = TextEditingController(text: widget.event.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _updateEvent() async {
    setState(() => _isLoading = true);
    try {
      await FirebaseFirestore.instance
          .collection('events')
          .doc(widget.event.id)
          .update({
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Event updated successfully!")),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update: $e")),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
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
          "Edit event",
          style: TextStyle(color: Color(0xFF101623), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  widget.event.categoryImage,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),
              const Text("Title", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Description", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _updateEvent,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5669FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    "Update event",
                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}