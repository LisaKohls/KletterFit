import SwiftUI

struct MainTabs: View {
    var infoFitnessIcon: GradientButtonItem = gradientButtonsInfo[0]
    
    var body: some View {
        NavigationLink(destination: infoFitnessIcon.destination) {
            Text(infoFitnessIcon.name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .frame(maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                .background(infoFitnessIcon.gradient)
                .cornerRadius(20)
        }
        .padding(0)
    }
}
