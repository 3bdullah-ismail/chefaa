class Findings {
  String? testName;
  num? result;
  String? unit;
  String? status;
  String? interpretation;

  Findings({
    this.testName,
    this.result,
    this.unit,
    this.status,
    this.interpretation,
  });

  factory Findings.fromJson(Map<String, dynamic> json) {
    return Findings(
      testName: json['testName'],
      result: json['result'],
      unit: json['unit'],
      status: json['status'],
      interpretation: json['interpretation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'testName': testName,
      'result': result,
      'unit': unit,
      'status': status,
      'interpretation': interpretation,
    };
  }
}
