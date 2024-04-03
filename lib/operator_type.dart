enum OperatorType {
  lessThan._('lessThan'),
  lessThanOrEqualTo._('lessThanOrEqualTo'),
  greaterThan._('greaterThan'),
  greaterThanOrEqualTo._('greaterThanOrEqualTo'),
  equalTo._('equalTo'),
  notEqualTo._('notEqualTo'),
  matches._('matches'),
  like._('like'),
  beginsWith._('beginsWith'),
  endsWith._('endsWith'),
  inRange._('in'),
  customSelector._('customSelector'),
  contains._('contains'),
  between._('between');

  const OperatorType._(this.code);

  final String code;
}
