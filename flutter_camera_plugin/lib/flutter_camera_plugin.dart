
import 'flutter_camera_plugin_platform_interface.dart';

class FlutterCameraPlugin {
  Future<String?> getPlatformVersion() {
    return FlutterCameraPluginPlatform.instance.getPlatformVersion();
  }
}
