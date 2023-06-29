import SwiftUI

struct TrainingCard: View {
    var item: TrainingItem
    @State var show = false
    
    // Create a computed property to generate color based on difficulty
    private var backgroundColor: Color {
        switch item.difficulty ?? "Unknown" {
        case "Easy":
            return Color.green.opacity(0.5)
        case "Intermediate":
            return Color.orange.opacity(0.5)
        case "Hard":
            return Color.red.opacity(0.5)
        default:
            return Color.gray.opacity(0.5)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(item.name ?? "Title")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding(.bottom, 4)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(item.desc ?? "")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
                .padding(.bottom, 4)
            
            HStack {
                Image(systemName: "clock")
                Text(item.duration ?? "Unknown")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("•")
                    .foregroundColor(.secondary)
                
                Image(systemName: "flame.fill")
                Text(item.difficulty ?? "Unknown")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(16)
        .background(backgroundColor)
        .cornerRadius(16)
        .padding(.bottom, 8)
        .onTapGesture {
            show.toggle()
        }
        .sheet(isPresented: $show, content: {
            TrainingDetailView(isPresented: $show, trainingItem: item) // Pass trainingItem
        })
    }
}

