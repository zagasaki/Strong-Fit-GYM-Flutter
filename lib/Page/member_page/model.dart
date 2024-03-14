class MembershipDetailModel {
  int? id;
  String title;
  String? currentStatus; // Add currentStatus property
  DateTime? startDate; // Add startDate property
  DateTime? endDate; // Add endDate property

  MembershipDetailModel({
    this.id,
    required this.title,
    this.currentStatus,
    this.startDate,
    this.endDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'currentStatus': currentStatus, // Map currentStatus
      'startDate': startDate?.toIso8601String(), // Map startDate
      'endDate': endDate?.toIso8601String(), // Map endDate
    };
  }

  factory MembershipDetailModel.fromMap(Map<String, dynamic> map) {
    return MembershipDetailModel(
      id: map['id'],
      title: map['title'],
      currentStatus: map['currentStatus'], // Get currentStatus
      startDate: map['startDate'] != null
          ? DateTime.parse(map['startDate'])
          : null, // Parse startDate
      endDate: map['endDate'] != null
          ? DateTime.parse(map['endDate'])
          : null, // Parse endDate
    );
  }
}
