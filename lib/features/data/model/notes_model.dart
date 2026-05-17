class NotesModel {
  final int? id;
  final String title;
  final DateTime? createdAt;

  NotesModel({
    this.id,
    required this.title,
    this.createdAt,
  });
  Map<String, dynamic> toMap() => {
        'title': title,
        'created_at': createdAt?.toIso8601String(),
      };

  factory NotesModel.fromMap(Map<String, dynamic> map) => NotesModel(
        id: map['id'] as int?,
        title: map['title'] as String,
        createdAt: map['created_at'] != null
            ? DateTime.parse(map['created_at'] as String)
            : null,
      );
}
