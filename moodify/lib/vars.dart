// import 'package:uuid/uuid.dart';

// var uuid = Uuid();

class DataModel {
  final String id;
  final double value;
  final String timestamp;

  const DataModel(
      {required this.id, required this.value, required this.timestamp});

  // Convert DataModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'timestamp': timestamp,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': timestamp,
      'value': value,
    };
  }

  @override
  String toString() {
    return 'Dog{id: $id, timestamp: $timestamp, value: $value}';
  }
}

const donationUrl = 'https://digitalbabushka.org/coming-soon/';

const digitalBabushkaUrl = 'https://digitalbabushka.org';

const maxSamplesPerPeriod = 8;
const minSamplesPerPeriod = 3;
