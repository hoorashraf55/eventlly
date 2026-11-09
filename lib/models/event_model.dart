class EventModel {
  final String id;
  final String title;
  final String description;
  final String categoryImage;
  final String date;
  final String time;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryImage,
    required this.date,
    required this.time,
  });

  factory EventModel.fromMap(Map<String, dynamic> map, String documentId) {
    return EventModel(
      id: documentId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      categoryImage: map['categoryImage'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'categoryImage': categoryImage,
      'date': date,
      'time': time,
    };
  }
}