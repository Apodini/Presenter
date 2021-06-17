
import Foundation

if #available(OSX 11.0, iOS 14.0, *) {
    print("before main")
    ExampleApp.main()
    print("after main")
    RunLoop.main.run()
} else {
    fatalError("Not supported")
}
