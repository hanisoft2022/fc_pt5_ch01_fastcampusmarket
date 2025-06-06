enum ProductField { isSale, discountRate, name }

extension ProductFieldExtension on ProductField {
  String get value => switch (this) {
    ProductField.isSale => 'isSale',
    ProductField.discountRate => 'discountRate',
    ProductField.name => 'name',
  };
}
