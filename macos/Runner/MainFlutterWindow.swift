import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterpresentationController = FlutterpresentationController()
    let windowFrame = self.frame
    self.contentpresentationController = flutterpresentationController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterpresentationController)

    super.awakeFromNib()
  }
}
