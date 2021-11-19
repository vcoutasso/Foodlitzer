import SwiftUI

struct CustomSegmentedPicker: View {
    // MARK: - State Atributes

    @State private var atHome = true
    @State private var atRestaurants = false
    @State private var atSaved = false

    // MARK: - Animation Atribute

    @Namespace private var animation

    // MARK: - Private Layout Metrics:

    private var segmentedPadding: CGFloat = 5

    // MARK: - View

    var body: some View {
        HStack(alignment: .top) {
            homeTab

            Spacer()

            restaurantsTab

            Spacer()

            savedTab
        }
        .padding(.horizontal, 50)
    }

    // MARK: - Extracted Views

    private var homeTab: some View {
        Button {
            setCurrentTabTo(.home)
        } label: {
            VStack(spacing: segmentedPadding) {
                Text(Strings.Tab.home)
                    .compactMedium14()
                    .foregroundColor(atHome ? .black : .black.opacity(0.5))
                    .padding(.horizontal, segmentedPadding)

                if atHome { animateSegmentedBar }
            }
            .fixedSize(horizontal: true, vertical: false)
        }
    }

    private var restaurantsTab: some View {
        Button {
            setCurrentTabTo(.restaurant)
        } label: {
            VStack(spacing: segmentedPadding) {
                Text(Strings.Tab.restaurants)
                    .compactMedium14()
                    .foregroundColor(atRestaurants ? .black : .black.opacity(0.5))
                    .padding(.horizontal, segmentedPadding)

                if atRestaurants { animateSegmentedBar }
            }
            .fixedSize(horizontal: true, vertical: false)
        }
    }

    private var savedTab: some View {
        Button {
            setCurrentTabTo(.saved)
        } label: {
            VStack(spacing: segmentedPadding) {
                Text(Strings.Tab.saved)
                    .compactMedium14()
                    .foregroundColor(atSaved ? .black : .black.opacity(0.5))
                    .padding(.horizontal, segmentedPadding)

                if atSaved { animateSegmentedBar }
            }
            .fixedSize(horizontal: true, vertical: false)
        }
    }

    // MARK: - Component

    private var animateSegmentedBar: some View {
        Rectangle()
            .segmentedPickerBarStyle()
            .matchedGeometryEffect(id: Strings.Animation.segmentedPicker, in: animation)
    }

    // MARK: - Method:

    func setCurrentTabTo(_ button: Tab) {
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)) {
            switch button {
            case .home:
                atHome = true
                atRestaurants = false
                atSaved = false

            case .restaurant:
                atHome = false
                atRestaurants = true
                atSaved = false

            case .saved:
                atHome = false
                atRestaurants = false
                atSaved = true
            }
        }
    }
}
