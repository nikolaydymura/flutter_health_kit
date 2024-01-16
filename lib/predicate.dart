typedef PredicateDescriptor = Map<String, dynamic>;

class Predicate {
  static PredicateDescriptor predicateForSamples({
    required DateTime withStart,
    required DateTime end,
    bool? strictStartDate,
    bool? strictEndDate,
  }) =>
      {
        'code': 'predicateForSamples',
        'withStart': withStart.millisecondsSinceEpoch / 1000,
        'end': end.millisecondsSinceEpoch / 1000,
        if (strictStartDate != null) 'strictStartDate': strictStartDate,
        if (strictEndDate != null) 'strictEndDate': strictEndDate,
      };
}
