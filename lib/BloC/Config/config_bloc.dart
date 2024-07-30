import 'package:flutter_bloc/flutter_bloc.dart';

import 'config.dart';
import 'config_state.dart';

class ConfigCubit extends Cubit<ConfigState> {
  final ConfigRepository _configRepository;

  ConfigCubit(this._configRepository) : super(ConfigInitial());

  Future<void> loadConfig() async {
    emit(ConfigLoading());
    try {
      final config = await _configRepository.fetchSystemConfig();
      emit(ConfigLoaded(config));
    } catch (e) {
      emit(const ConfigError(
          'Failed to load configuration. Please try again later.'));
    }
  }
}
