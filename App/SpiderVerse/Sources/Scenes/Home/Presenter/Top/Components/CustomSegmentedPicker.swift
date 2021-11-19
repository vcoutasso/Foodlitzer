import SwiftUI

struct CustomSegmentedPicker: View {
    @State private var atHome = true
    @State private var atRestaurants = false
    @State private var atSaved = false
    @Namespace private var animation

    var body: some View {
        HStack(alignment: .top) {
            Button {
                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)) {
                    atHome = true
                    atRestaurants = false
                    atSaved = false
                }
            } label: {
                VStack(spacing: 5) {
                    Text("Home")
                        .font(.custom("SF Compact Medium", size: 14)) // Change font
                        .foregroundColor(atHome ? .black : .black.opacity(0.5))
                        .padding(.horizontal, 5)

                    if atHome {
                        Rectangle()
                            .frame(height: 4)
                            .foregroundColor(.black)
                            .matchedGeometryEffect(id: "Shape", in: animation)
                    }
                }
                .fixedSize(horizontal: true, vertical: false)
            }

            Spacer()

            Button {
                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)) {
                    atHome = false
                    atRestaurants = true
                    atSaved = false
                }
            } label: {
                VStack(spacing: 5) {
                    Text("Restaurants")
                        .font(.custom("SF Compact Medium", size: 14)) // Change font
                        .foregroundColor(atRestaurants ? .black : .black.opacity(0.5))
                        .padding(.horizontal, 5)

                    if atRestaurants {
                        Rectangle()
                            .frame(height: 4)
                            .foregroundColor(.black)
                            .matchedGeometryEffect(id: "Shape", in: animation)
                    }
                }
                .fixedSize(horizontal: true, vertical: false)
            }

            Spacer()

            Button {
                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)) {
                    atHome = false
                    atRestaurants = false
                    atSaved = true
                }
            } label: {
                VStack(spacing: 5) {
                    Text("Saved")
                        .font(.custom("SF Compact Medium", size: 14)) // Change font
                        .foregroundColor(atSaved ? .black : .black.opacity(0.5))
                        .padding(.horizontal, 5)

                    if atSaved {
                        Rectangle()
                            .frame(height: 4)
                            .foregroundColor(.black)
                            .matchedGeometryEffect(id: "Shape", in: animation)
                    }
                }
                .fixedSize(horizontal: true, vertical: false)
            }
        }
        .padding(.horizontal, 50)
    }
}

struct CustomSegmentedPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomSegmentedPicker()
    }
}
