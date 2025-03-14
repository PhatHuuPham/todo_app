import Flutter
import UIKit

public class FlutterCameraPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_camera_plugin", binaryMessenger: registrar.messenger())
        let instance = FlutterCameraPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "openCamera" {
            openCamera(result: result)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    private func openCamera(result: @escaping FlutterResult) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = false
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        rootViewController?.present(picker, animated: true, completion: nil)
        result("Camera opened")
    }
}
