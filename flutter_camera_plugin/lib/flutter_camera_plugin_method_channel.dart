import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_camera_plugin_platform_interface.dart';

/// An implementation of [FlutterCameraPluginPlatform] that uses method channels.
class MethodChannelFlutterCameraPlugin extends FlutterCameraPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_camera_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
