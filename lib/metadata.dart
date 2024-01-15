extension MetadataX on Map<String, dynamic> {
  bool get isIndoorWorkout => (this['HKIndoorWorkout'] as num?)?.toInt() == 1;

  bool get wasUserEntered => (this['HKWasUserEntered'] as num?)?.toInt() == 1;
}