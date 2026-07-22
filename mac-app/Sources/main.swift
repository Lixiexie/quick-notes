import WebKit
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
  var window: NSWindow!

  func applicationDidFinishLaunching(_ notification: Notification) {
    let windowRect = NSRect(x: 0, y: 0, width: 420, height: 780)
    window = NSWindow(
      contentRect: windowRect,
      styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
      backing: .buffered,
      defer: false
    )
    window.title = "随身速记"
    window.center()
    window.minSize = NSSize(width: 320, height: 500)
    window.titlebarAppearsTransparent = true

    // WKWebView 配置
    let config = WKWebViewConfiguration()
    config.preferences.setValue(true, forKey: "developerExtrasEnabled")
    let webView = WKWebView(frame: windowRect, configuration: config)
    webView.autoresizingMask = [.width, .height]
    webView.allowsBackForwardNavigationGestures = true

    // 加载 HTML
    if let resourcePath = Bundle.main.resourcePath {
      let indexPath = resourcePath + "/index.html"
      let url = URL(fileURLWithPath: indexPath)
      let dirURL = URL(fileURLWithPath: resourcePath, isDirectory: true)
      webView.loadFileURL(url, allowingReadAccessTo: dirURL)
    }

    window.contentView = webView
    window.makeKeyAndOrderFront(nil)
  }

  func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.setActivationPolicy(.regular)
app.activate(ignoringOtherApps: true)
app.run()
