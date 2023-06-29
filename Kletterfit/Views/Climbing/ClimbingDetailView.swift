import SwiftUI

struct ClimbingDetailView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var routes: FetchedResults<Route>
    @Environment(\.presentationMode) var presentationMode
    
    var route: Route
    @State var tries: Int16
    
    init(route: Route) {
        self.route = route
        _tries = State(initialValue: route.tries)
    }
    
    var body: some View {
        VStack {
            if let routeDescription = route.routeDescription, !routeDescription.isEmpty {
                HStack {
                    Text(routeDescription)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                }
            }
            Form {
                Section {
                    if let imageData = route.image, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                Section {
                    Text("Color of route")
                        .font(.headline)
                    Text(route.color ?? "")
                }
                
                Section {
                    Stepper("Tries: \(tries)", value: $tries, in: 0...100)
                    HStack {
                        Text("Finished")
                        Spacer()
                        Checkmark(isChecked: Binding(
                            get: { route.finished },
                            set: { route.finished = $0 }
                        ))
                    }
                }
            }
            .navigationTitle(route.name ?? "")
            .navigationBarItems(trailing:
                                    Button("Save", action: {
                route.tries = tries
                do {
                    try moc.save()
                    presentationMode.wrappedValue.dismiss()
                } catch {
                    print("Failed to save the route: \(error)")
                }
            })
                                
            )
        }
    }
}

struct ClimbingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let route = Route()
        
        return NavigationView {
            ClimbingDetailView(route: route)
        }
    }
}
