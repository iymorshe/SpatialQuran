import SwiftUI
struct DisplayText: View {
    var text: String
    var font: Font = .title
    var alignment: Alignment = .center
    var body: some View {
        Text(text)
            .font(font)
            .padding()
            .frame(maxWidth: .infinity, alignment: alignment)
            .multilineTextAlignment(.center)
    }
}
