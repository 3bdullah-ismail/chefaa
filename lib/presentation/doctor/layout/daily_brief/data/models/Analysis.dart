import 'Summary.dart';
import 'ProfitLoss.dart';
import 'PerClinicBreakdown.dart';
import 'Trends.dart';
import 'Predictions.dart';

class Analysis {
  Analysis({
      this.summary, 
      this.profitLoss, 
      this.perClinicBreakdown, 
      this.trends, 
      this.predictions, 
      this.recommendations, 
      this.riskFlags, 
      this.aiNarrative,});

  Analysis.fromJson(dynamic json) {
    summary = json['summary'] != null ? Summary.fromJson(json['summary']) : null;
    profitLoss = json['profitLoss'] != null ? ProfitLoss.fromJson(json['profitLoss']) : null;
    if (json['perClinicBreakdown'] != null) {
      perClinicBreakdown = [];
      json['perClinicBreakdown'].forEach((v) {
        perClinicBreakdown?.add(PerClinicBreakdown.fromJson(v));
      });
    }
    trends = json['trends'] != null ? Trends.fromJson(json['trends']) : null;
    predictions = json['predictions'] != null ? Predictions.fromJson(json['predictions']) : null;
    recommendations = json['recommendations'] != null ? json['recommendations'].cast<String>() : [];
    riskFlags = json['riskFlags'] != null ? json['riskFlags'].cast<String>() : [];
    aiNarrative = json['aiNarrative'];
  }
  Summary? summary;
  ProfitLoss? profitLoss;
  List<PerClinicBreakdown>? perClinicBreakdown;
  Trends? trends;
  Predictions? predictions;
  List<String>? recommendations;
  List<String>? riskFlags;
  String? aiNarrative;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (summary != null) {
      map['summary'] = summary?.toJson();
    }
    if (profitLoss != null) {
      map['profitLoss'] = profitLoss?.toJson();
    }
    if (perClinicBreakdown != null) {
      map['perClinicBreakdown'] = perClinicBreakdown?.map((v) => v.toJson()).toList();
    }
    if (trends != null) {
      map['trends'] = trends?.toJson();
    }
    if (predictions != null) {
      map['predictions'] = predictions?.toJson();
    }
    map['recommendations'] = recommendations;
    map['riskFlags'] = riskFlags;
    map['aiNarrative'] = aiNarrative;
    return map;
  }

}