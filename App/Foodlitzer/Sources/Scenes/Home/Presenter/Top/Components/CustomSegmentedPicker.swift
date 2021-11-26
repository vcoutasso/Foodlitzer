import SwiftUI

struct CustomSegmentedPicker: View {
    @State var index = 1
    @State var offset: CGFloat = UIScreen.main.bounds.width
    var width = UIScreen.main.bounds.width

    var body: some View {
        VStack(spacing: 0) {
            HeaderTabView(index: self.$index, offset: self.$offset)

            GeometryReader { g in

                HStack(spacing: 0) {
                    TabHomeView(viewModel: TabHomeViewModelFactory.make())
                        .frame(width: g.frame(in: .global).width)

                    TabRestaurantsView(viewModel: TabHomeViewModelFactory.make())
                        .frame(width: g.frame(in: .global).width)

                    TabSavedView()
                        .frame(width: g.frame(in: .global).width)
                }
                .offset(x: self.offset - self.width)
                .highPriorityGesture(DragGesture()

                    .onEnded { value in

                        if value.translation.width > 50 { // minimum drag...
                            print("right")
                            self.changeView(left: false)
                        }
                        if -value.translation.width > 50 {
                            print("left")
                            self.changeView(left: true)
                        }
                    })
            }
        }
    }

    func changeView(left: Bool) {
        if left {
            if index != 3 {
                index += 1
            }
        } else {
            if index != 0 {
                index -= 1
            }
        }

        if index == 1 {
            offset = width
        } else if index == 2 {
            offset = 0
        } else {
            offset = -width
        }
    }
}
