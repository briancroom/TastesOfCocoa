import WatchKit
import MultiPlatformFramework

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    func applicationDidFinishLaunching() {
        Foo.bar()
    }
}
