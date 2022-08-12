import Flutter
import UIKit
import CoreLocation

public class SwiftBacklocationPlugin: NSObject, FlutterPlugin, CLLocationManagerDelegate {
  static var locationManager: CLLocationManager?
  static var channel: FlutterMethodChannel?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "co.com.quick/backlocation/methods", binaryMessenger: registrar.messenger())
    let instance = SwiftBacklocationPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    SwiftBacklocationPlugin.locationManager = CLLocationManager()
    SwiftBacklocationPlugin.locationManager?.delegate = self
    SwiftBacklocationPlugin.locationManager?.requestAlwaysAuthorization()

    SwiftBacklocationPlugin.locationManager?.allowsBackgroundLocationUpdates = true
    if #available(iOS 11.0, *) {
        SwiftBacklocationPlugin.locationManager?.showsBackgroundLocationIndicator = true;
    }
    SwiftBacklocationPlugin.locationManager?.pausesLocationUpdatesAutomatically = false

    SwiftBacklocationPlugin.channel?.invokeMethod("location", arguments: "method")

    if (call.method == "start_location_service") {
        SwiftBacklocationPlugin.channel?.invokeMethod("location", arguments: "start_location_service")
        
        let args = call.arguments as? Dictionary<String, Any>
        let distanceFilter = args?["distance_filter"] as? Double
        SwiftBacklocationPlugin.locationManager?.distanceFilter = distanceFilter ?? 0
        
        SwiftBacklocationPlugin.locationManager?.startUpdatingLocation() 
    } else if (call.method == "stop_location_service") {
        SwiftBacklocationPlugin.channel?.invokeMethod("location", arguments: "stop_location_service")
        SwiftBacklocationPlugin.locationManager?.stopUpdatingLocation()
    }
    result(true)
  }

  public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
      if status == .authorizedAlways {
          
      }
  }
    
  public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      let location = [
          "speed": locations.last!.speed,
          "altitude": locations.last!.altitude,
          "latitude": locations.last!.coordinate.latitude,
          "longitude": locations.last!.coordinate.longitude,
          "accuracy": locations.last!.horizontalAccuracy,
          "bearing": locations.last!.course,
          "time": locations.last!.timestamp.timeIntervalSince1970 * 1000,
          "is_mock": false
      ] as [String : Any]

      SwiftBacklocationPlugin.channel?.invokeMethod("location", arguments: location)
  }

}
