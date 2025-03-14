import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_camera_plugin_method_channel.dart';

abstract class FlutterCameraPluginPlatform extends PlatformInterface {
  /// Constructs a FlutterCameraPluginPlatform.
  FlutterCameraPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterCameraPluginPlatform _instance = MethodChannelFlutterCameraPlugin();

  /// The default instance of [FlutterCameraPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterCameraPlugin].
  static FlutterCameraPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterCameraPluginPlatform] when
  /// they register themselves.
  static set instance(FlutterCameraPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
