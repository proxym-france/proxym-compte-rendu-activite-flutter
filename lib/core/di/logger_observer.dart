import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

class LoggerObserver extends ProviderObserver {
  final talker = Talker();

  @override
  Future<void> didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue, Object? newValue, ProviderContainer container) async {
    super.didUpdateProvider(provider, previousValue, newValue, container);
    talker.info('''
    provider = ${provider.name ?? provider.runtimeType}
    new value = $newValue  
    ''');
  }

  @override
  void didAddProvider(ProviderBase<Object?> provider, Object? value, ProviderContainer container) {
    // TODO: implement didAddProvider
    super.didAddProvider(provider, value, container);
    talker.info('''
        provider = ${provider.name ?? provider.runtimeType}
        value = $value  
    ''');
  }

  @override
  void didDisposeProvider(ProviderBase<Object?> provider, ProviderContainer container) {
    // TODO: implement didDisposeProvider
    super.didDisposeProvider(provider, container);
    talker.info('''
        provider = ${provider.name ?? provider.runtimeType}
        value = disposed 
    ''');
  }
}
