import SwiftUI

struct CustomSegmentedPicker: View {
    @State var index = 0
    @State var offset: CGFloat = UIScreen.main.bounds.width
    private let width = UIScreen.main.bounds.width
    private let minimumDragDistance: CGFloat = 50
    private var computedOffset: CGFloat {
        var newValue: CGFloat

        if index == 0 {
            newValue = width
        } else if index == 1 {
            newValue = 0
        } else {
            newValue = -width
        }

        return newValue
    }

    var body: some View {
        VStack(spacing: 0) {
            HeaderTabView(index: $index, offset: $offset)

            GeometryReader { geometry in

                HStack(spacing: 0) {
                    TabHomeView(viewModel: TabHomeViewModelFactory.make())
                        .frame(width: geometry.frame(in: .global).width)

                    TabRestaurantsView(viewModel: TabRestaurantViewModelFactory.make())
                        .frame(width: geometry.frame(in: .global).width)

                    // TabSavedView()
                    //    .frame(width: geometry.frame(in: .global).width)
                }
                .offset(x: offset - width)
                .highPriorityGesture(DragGesture()
                    .onEnded { gesture in
                        if gesture.translation.width > minimumDragDistance {
                            swipeLeft()
                        }
                        if -gesture.translation.width > minimumDragDistance {
                            swipeRight()
                        }
                    })
            }
        }
    }

    // TODO: Create and move this to viewmodel

    private func swipeLeft() {
        index = max(index - 1, 0)
        offset = computedOffset
    }

    private func swipeRight() {
        index = min(index + 1, 1)
        offset = computedOffset
    }
}
