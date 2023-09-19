class Provider<T> {
  final Type type;
  final T Function()? builder;
  final T Function()? replaceBuilder;

  Provider({
    this.builder,
    this.replaceBuilder,
  }) : type = T;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Provider &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          builder == other.builder &&
          replaceBuilder == other.replaceBuilder;

  @override
  int get hashCode => type.hashCode ^ builder.hashCode ^ replaceBuilder.hashCode;

  @override
  String toString() {
    return 'Provide{\ntype: $type,\nbuilder: $builder,\nreplaceBuilder: $replaceBuilder\n}';
  }
}
