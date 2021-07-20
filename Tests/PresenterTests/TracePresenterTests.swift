#if !os(watchOS) && canImport(XCTest) && canImport(UIKit)

import XCTest
import Presenter
import TracePresenter
import UIKit

final class TracePresenterTests: XCTestCase {
    func testTracePresenter() {
        let view = TraceGraph(spans: [
            .init(
                service: "gateway",
                operation: "gateway",
                start: 0,
                end: 1,
                parentService: nil,
                parentOperation: nil
            ),
            .init(
                service: "processing",
                operation: "locations",
                start: 0.2,
                end: 0.85,
                parentService: "gateway",
                parentOperation: "gateway"
            ),
            .init(
                service: "processing",
                operation: "fetch-locations",
                start: 0.3,
                end: 0.7,
                parentService: "processing",
                parentOperation: "locations"
            ),
            .init(
                service: "processing",
                operation: "process-locations",
                start: 0.6,
                end: 0.65,
                parentService: "processing",
                parentOperation: "locations"
            ),
            .init(
                service: "database",
                operation: "fetch-locations",
                start: 0.35,
                end: 0.5,
                parentService: "processing",
                parentOperation: "locations"
            )
        ])!

        let image = view.eraseToAnyView().image(in: CGSize(width: 200, height: 200))
        print(image)
    }
}

extension SwiftUI.View {
    func image(in size: CGSize) -> UIImage {
        let view = UIHostingController(rootView: self).view!
        view.frame = CGRect(origin: .zero, size: size)
        return UIGraphicsImageRenderer(size: size).image { _ in
            view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        }
    }
}

#endif
