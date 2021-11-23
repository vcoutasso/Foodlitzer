import SwiftUI

// TODO: Maybe a where clause makes more sense?
extension View {
    func halfSheet<SheetView: View>(showSheet: Binding<Bool>,
                                    @ViewBuilder sheetView: @escaping () -> SheetView) -> some View {
        background {
            HalfSheet(sheetView: sheetView(), showSheet: showSheet)
        }
    }
}

// TODO: erro no dismiss da sheet
struct HalfSheet<SheetView: View>: UIViewControllerRepresentable {
    var sheetView: SheetView
    @Binding var showSheet: Bool

    let controller = UIViewController()

    func makeUIViewController(context: UIViewControllerRepresentableContext<HalfSheet>) -> UIViewController {
        controller
    }

    func updateUIViewController(_ uiViewController: UIViewController,
                                context: UIViewControllerRepresentableContext<HalfSheet>) {
        if showSheet {
            let sheetController = UIHostingController(rootView: sheetView)
            sheetController.presentationController?.delegate = context.coordinator
            if let sheet = sheetController.sheetPresentationController {
                sheet.detents = [.medium()]
            }
            uiViewController.present(sheetController, animated: true) {
                // self.showSheet = true
            }
        } else {
            uiViewController.dismiss(animated: true, completion: nil)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        var parent: HalfSheet

        init(parent: HalfSheet) {
            self.parent = parent
        }

        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            parent.showSheet = false
        }
    }
}
