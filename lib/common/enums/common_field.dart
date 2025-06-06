enum CommonField { createdAt, updatedAt }

extension CommonFieldExtension on CommonField {
  String get value => switch (this) {
    CommonField.createdAt => 'createdAt',
    CommonField.updatedAt => 'updatedAt',
  };
}
