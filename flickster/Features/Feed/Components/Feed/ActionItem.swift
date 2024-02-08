import SwiftUI

struct ActionItem: View {
    let imageName: String
    let label: String
    let action: () -> Void
    var width: CGFloat? = 28
    var height: CGFloat? = 28

    var body: some View {
        Button(action: action) {
            VStack() {
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: width ?? 28, height: height ?? 28)
                    .foregroundStyle(.white)
                
                Text(label)
                    .font(.caption)
                    .foregroundStyle(.white)
                    .bold()
            }
            #if os(visionOS)
            .padding(.vertical)
            #endif
            
        }
        #if os(visionOS)
        .frame(width: 70, height: 70)
        .glassBackgroundEffect()
        .buttonStyle(.plain)
        .clipShape(Circle())
        #endif
    }
}

#Preview {
    ActionItem(imageName: "heart.fill", label: "27", action: {
        print("Button tapped")
    })
}
