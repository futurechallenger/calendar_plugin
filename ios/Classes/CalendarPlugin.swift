import Flutter
import UIKit
import EventKit
import EventKitUI

public class CalendarPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "calendar_plugin", binaryMessenger: registrar.messenger())
    let instance = CalendarPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
  
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
      case "getPlatformVersion":
        result("iOS " + UIDevice.current.systemVersion)
        
      case "addEventToCalendar":
        if call.arguments == nil {
          result(FlutterError(code: "Invalid parameters", message: "Invalid parameters", details: nil))
          return
        }
        
        guard let args = call.arguments as? [String : Any] else {return}
        let title = args["content"] as? String
        let note = args["note"] as? String
        
        if title == nil {
          result(FlutterError(code: "Invalid parameters", message: "Title is invalid or empty", details: nil))
          return
        }
        
        let eventStore : EKEventStore = EKEventStore()
        eventStore.requestAccess(to: .event) { (granted, error) in
          if (granted) && (error == nil) {
            print("granted \(granted)")
            print("error \(error)")
            
            let event:EKEvent = EKEvent(eventStore: eventStore)
            
            event.title = title
            event.startDate = Date()
            event.endDate = Date()
            event.notes = note ?? "This is a note"
            event.calendar = eventStore.defaultCalendarForNewEvents
            do {
              try eventStore.save(event, span: .thisEvent)
            } catch let error as NSError {
              print("failed to save event with error : \(error)")
            }
            print("Saved Event")
          }
          else{
            print("failed to save event with error : \(error) or access not granted")
          }
        }
        
      result(title)
      default:
        result(FlutterMethodNotImplemented)
    }
  }
}

