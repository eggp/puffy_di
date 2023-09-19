import 'package:collection/collection.dart';
import 'package:puffy_di/di/model/provider_instance.dart';

import 'model/provider.dart';

class DI {
  static final DI _instance = DI._();

  final List<Provider> providers = List.empty(growable: true);
  final List<ProviderInstance> providersInstances = List.empty(growable: true);

  DI._();

  static void provide(Provider provide) {
    final providers = _instance.providers;
    if (_instance.providersInstances.firstWhereOrNull((instance) => instance.provide.type == provide.type) != null) {
      throw 'Do not override provider when has instance';
    }
    final maybeIndex = providers.indexWhere((prov) => prov.type == provide.type);
    if (maybeIndex == -1) {
      _instance.providers.add(provide);
    } else {
      if (provide.replaceBuilder == null) {
        throw 'Do not override existing provider, use \'replaceBuilder\'';
      } else {
        providers[maybeIndex] = provide;
      }
    }
  }

  static S get<S>() {
    return _instance._get(S);
  }

  S _get<S>(Type type) {
    final maybeInstance = providersInstances.firstWhereOrNull((instance) => instance.provide.type == type);
    if (maybeInstance != null) {
      return maybeInstance.instance as S;
    }
    final maybeProvider = providers.firstWhereOrNull((provider) => provider.type == type);
    if (maybeProvider == null) {
      throw 'XXXX';
    }

    ProviderInstance providerInstance;
    if (maybeProvider.replaceBuilder != null) {
      providerInstance = ProviderInstance(instance: maybeProvider.replaceBuilder!(), provide: maybeProvider);
    } else {
      providerInstance = ProviderInstance(instance: maybeProvider.builder!(), provide: maybeProvider);
    }
    providersInstances.add(providerInstance);
    return providerInstance.instance as S;
  }
}
