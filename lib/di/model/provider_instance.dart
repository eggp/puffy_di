import 'provider.dart';

/// inside class
class ProviderInstance<T> {
  final Provider provide;
  final T instance;

  ProviderInstance({
    required this.provide,
    required this.instance,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProviderInstance && runtimeType == other.runtimeType && provide == other.provide;

  @override
  int get hashCode => provide.hashCode;

  @override
  String toString() {
    return 'ProvideInstance{\nprovide: $provide,\ninstance: $instance\n}';
  }
}
