import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_camera_plugin/flutter_camera_plugin.dart';
import 'package:flutter_camera_plugin/flutter_camera_plugin_platform_interface.dart';
import 'package:flutter_camera_plugin/flutter_camera_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterCameraPluginPlatform
    with MockPlatformInterfaceMixin
    implements FlutterCameraPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterCameraPluginPlatform initialPlatform = FlutterCameraPluginPlatform.instance;

  test('$MethodChannelFlutterCameraPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterCameraPlugin>());
  });

  test('getPlatformVersion', () async {
    FlutterCameraPlugin flutterCameraPlugin = FlutterCameraPlugin();
    MockFlutterCameraPluginPlatform fakePlatform = MockFlutterCameraPluginPlatform();
    FlutterCameraPluginPlatform.instance = fakePlatform;

    expect(await flutterCameraPlugin.getPlatformVersion(), '42');
  });
}
