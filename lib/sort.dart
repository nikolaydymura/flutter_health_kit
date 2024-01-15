enum SortIdentifiers {
  endDate._('endDate'),
  startDate._('startDate'),
  duration._('duration'),
  totalDistance._('totalDistance'),
  totalEnergyBurned._('totalEnergyBurned'),
  totalFlightsClimbed._('totalFlightsClimbed'),
  totalSwimmingStrokeCount._('totalSwimmingStrokeCount');

  const SortIdentifiers._(this.key);

  final String key;
}

class SortDescriptor {
  const SortDescriptor(this.identifier, this.ascending);

  final SortIdentifiers identifier;
  final bool ascending;

  Map<String, dynamic> toJson() => {
        'key': identifier.key,
        'ascending': ascending,
      };
}
