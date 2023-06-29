import SwiftUI

struct ClimbingCard: View {
    var route: Route
    
    @State private var showDeleteConfirmation = false
    
    @Environment(\.managedObjectContext) var moc
    
    var color: Color {
        let colorName = route.color ?? "blue"
        
        switch colorName {
        case "green":
            return .green.opacity(0.3)
        case "purple":
            return .purple.opacity(0.3)
        case "blue":
            return .blue.opacity(0.3)
        case "black":
            return .black.opacity(0.3)
        case "orange":
            return .orange.opacity(0.3)
        case "red":
            return .red.opacity(0.3)
        case "yellow":
            return .yellow.opacity(0.3)
        default:
            return .blue.opacity(0.3)
        }
    }
    
    func deleteRoute() {
        // Delete the route from Core Data
        moc.delete(route)
        do {
            try moc.save()
        } catch {
            print("Failed to delete the route: \(error)")
        }
    }
    
    var body: some View {
        
        HStack(alignment: .top) {
            if let imageData = route.image, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(15)
            }
            
            Spacer()
                .frame(width: 16)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(route.name ?? "Title")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.bottom, 4)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(route.routeDescription ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .padding(.bottom, 4)
                
                HStack {
                    Image(systemName: "paintpalette")
                        .foregroundColor(.black)
                    Text(route.color ?? "Unknown")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    Checkmark(isChecked: Binding(
                        get: { route.finished },
                        set: { route.finished = $0 }
                    ))
                }
            }
        }
        .contextMenu {
            Button(action: {
                showDeleteConfirmation = true
            }) {
                Text("Delete")
                Image(systemName: "trash")
            }
        }
        .actionSheet(isPresented: $showDeleteConfirmation) {
            ActionSheet(title: Text("Delete Route"), message: Text("Are you sure you want to delete this route?"), buttons: [
                .destructive(Text("Delete"), action: {
                    deleteRoute()
                }),
                .cancel()
            ])
        }
        .padding(16)
        .background(color)
        .cornerRadius(16)
        .padding(.bottom, 8)
    }
}

struct ClimbingCard_Previews: PreviewProvider {
    static var previews: some View {
        let route = Route()
        
        return NavigationView {
            ClimbingCard(route: route)
        }
    }
}

