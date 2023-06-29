import SwiftUI

struct ClimbingOverView: View {
    @FetchRequest(sortDescriptors: []) var routes: FetchedResults<Route>
    
    @Environment(\.managedObjectContext) var moc
    
    @State private var onLoadAnimation: Bool = false
    
    var sortedRoutes: [Route] {
            routes.sorted { route1, route2 in
                if route1.finished == route2.finished {
                    return route1.name ?? "" < route2.name ?? ""
                } else {
                    return !route1.finished && route2.finished
                }
            }
        }
        
    
    var body: some View {
        
        NavigationView() {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .center, spacing: 15.0) {
                        //ClimbingStatistikView wird geöffnet
                        MainTabs(infoFitnessIcon: gradientButtonsInfo[0])
                            .opacity(onLoadAnimation ? 1 : 0)
                            .offset(x: onLoadAnimation ? 0 : 0, y: onLoadAnimation ? 0 : 5)
                            .animation(.easeInOut(duration: 0.5).delay(0.4), value: onLoadAnimation)
                            .padding(.top, 50)
                        Text("Climbing Projects")
                            .font(.headline)
                            .padding(.top, 16)
                            .opacity(onLoadAnimation ? 1 : 0)
                            .offset(x: onLoadAnimation ? 0 : -5)
                            .animation(.easeInOut(duration: 0.6).delay(0.5), value: onLoadAnimation)
                        //hinzugefügte Routen
                        if routes.isEmpty {
                            Text("No routes yet")
                                .foregroundColor(.secondary)
                                .padding(.top, 50)
                                .opacity(onLoadAnimation ? 1 : 0)
                                .offset(x: onLoadAnimation ? 0 : 0, y: onLoadAnimation ? 0 : 5)
                                .animation(.easeInOut(duration: 0.5).delay(0.4), value: onLoadAnimation)
                        } else {
                            VStack {
                                ForEach(sortedRoutes) {route in
                                    NavigationLink(destination: ClimbingDetailView(route: route)){
                                        ClimbingCard(route: route)
                                            .opacity(onLoadAnimation ? 1 : 0)
                                            .offset(y: onLoadAnimation ? 0 : 15)
                                            .animation(Animation.easeInOut(duration: 0.7).delay(0.6), value: onLoadAnimation)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .onAppear {
                        withAnimation {
                            onLoadAnimation = true
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: AddRouteView()) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Climbing")
        }
    }
}

struct ClimbingOverView_Previews: PreviewProvider {
    static var previews: some View {
        ClimbingOverView()
    }
}
