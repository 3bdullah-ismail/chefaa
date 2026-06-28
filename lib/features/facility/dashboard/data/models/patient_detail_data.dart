class PatientDetailData {
  final String id;
  final String name;
  final String details;
  final List<String> badges;
  final String doctorNotes;
  final String doctorName;
  final String doctorNotesTime;
  final String aiInsight;
  final String aiLinkText;

  const PatientDetailData({
    required this.id,
    required this.name,
    required this.details,
    required this.badges,
    required this.doctorNotes,
    required this.doctorName,
    required this.doctorNotesTime,
    required this.aiInsight,
    required this.aiLinkText,
  });
}
