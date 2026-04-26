enum SortOption {
  none('Sin orden'),
  nameAsc('Nombre (A-Z)'),
  nameDesc('Nombre (Z-A)'),
  priceAsc('Precio (Menor a Mayor)'),
  priceDesc('Precio (Mayor a Menor)');

  final String label;
  const SortOption(this.label);
}
