import 'Findings.dart';

class Data {
  String? patientName;
  List<Findings>? findings;
  num? dangerScore;
  String? summary;
  List<String>? tips;

  Data({
    this.patientName,
    this.findings,
    this.dangerScore,
    this.summary,
    this.tips,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      patientName: json['patientName'],
      findings: json['findings'] != null
          ? List<Findings>.from(
        json['findings'].map((x) => Findings.fromJson(x)),
      )
          : [],
      dangerScore: json['dangerScore'],
      summary: json['summary'],
      tips: List<String>.from(json['tips'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientName': patientName,
      'findings': findings?.map((e) => e.toJson()).toList(),
      'dangerScore': dangerScore,
      'summary': summary,
      'tips': tips,
    };
  }
}