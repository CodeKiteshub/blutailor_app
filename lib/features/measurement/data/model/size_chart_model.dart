import 'package:bluetailor_app/features/measurement/domain/entities/size_chart_entity.dart';

class SizeChartModel extends SizeChartEntity {
  SizeChartModel({required super.label, required super.size});


  factory SizeChartModel.fromJson(Map<String, dynamic> json) {
    return SizeChartModel(
      label: json['label'],
      size: json['size'],
    );
  }
}
