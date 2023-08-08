class DataModel {
  final double value;
  final String timestamp;

  DataModel({required this.value, required this.timestamp});

  // Convert DataModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'timestamp': timestamp,
    };
  }

  // Create DataModel instance from JSON
  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      value: json['value'],
      timestamp: json['timestamp'],
    );
  }
}
