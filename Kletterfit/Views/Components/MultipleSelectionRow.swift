import SwiftUI

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
            }
        }
        .contentShape(Rectangle())
        .padding(.horizontal, 16)
    }
}
