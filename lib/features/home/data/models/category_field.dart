enum CategoryField { id, name }

extension CategoryFieldExtension on CategoryField {
  String get value => switch (this) {
    CategoryField.id => 'id',
    CategoryField.name => 'name',
  };
}
