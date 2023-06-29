import SwiftUI

struct GradientButtonItem: Identifiable {
    var id: UUID = UUID()
    var name: String
    var destination: AnyView
    var gradient: LinearGradient
}
