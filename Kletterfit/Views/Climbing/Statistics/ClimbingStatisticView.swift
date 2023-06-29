import SwiftUI
import Charts
import CoreData

struct StatisticClimbingView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var routes: FetchedResults<Route>
    @Environment(\.presentationMode) var presentationMode
    
    var averageTriesByColor: [String: Int] {
        var routesByColor: [String: [Route]] = [:]
        
        for route in routes {
            if var colorRoutes = routesByColor[route.color ?? ""] {
                colorRoutes.append(route)
                routesByColor[route.color ?? ""] = colorRoutes
            } else {
                routesByColor[route.color ?? ""] = [route]
            }
        }
        
        var averageTriesByColor: [String: Int] = [:]
        
        for (color, colorRoutes) in routesByColor {
            let totalTries = colorRoutes.reduce(0, { $0 + $1.tries })
            let averageTries = Int(totalTries) / Int(colorRoutes.count)
            averageTriesByColor[color] = averageTries
        }
        
        return averageTriesByColor
    }
    
    var countRoutesByColor: [String: Int] {
        var routesByColor: [String: [Route]] = [:]
        
        for route in routes {
            if route.finished {
                if var colorRoutes = routesByColor[route.color ?? ""] {
                    colorRoutes.append(route)
                    routesByColor[route.color ?? ""] = colorRoutes
                } else {
                    routesByColor[route.color ?? ""] = [route]
                }
            }
        }
        
        var countByColor: [String: Int] = [:]
        
        for (color, colorRoutes) in routesByColor {
            countByColor[color] = colorRoutes.count
        }
        
        return countByColor
    }

    var body: some View {
        
        let viewChartFinished: [ViewChartItem] = [
            .init(color: "green", number: countRoutesByColor["green"] ?? 0),
            .init(color: "purple", number: countRoutesByColor["purple"] ?? 0),
            .init(color: "blue", number: countRoutesByColor["blue"] ?? 0),
            .init(color: "black", number: countRoutesByColor["black"] ?? 0),
            .init(color: "orange", number: countRoutesByColor["orange"] ?? 0),
            .init(color: "red", number: countRoutesByColor["red"] ?? 0),
            .init(color: "yellow", number: countRoutesByColor["yellow"] ?? 0)
        ]
        
        let viewChartTries: [ViewChartItem] = [
            .init(color: "green", number: averageTriesByColor["green"] ?? 0),
            .init(color: "purple", number: averageTriesByColor["purple"] ?? 0),
            .init(color: "blue", number: averageTriesByColor["blue"] ?? 0),
            .init(color: "black", number: averageTriesByColor["black"] ?? 0),
            .init(color: "orange", number: averageTriesByColor["orange"] ?? 0),
            .init(color: "red", number: averageTriesByColor["red"] ?? 0),
            .init(color: "yellow", number: averageTriesByColor["yellow"] ?? 0)
        ]
        
        ScrollView {
            VStack(alignment: .leading, spacing: 4){
                Text("Finished routes")
                    .font(.headline)
                Text("Total: \(viewChartFinished.reduce(0, {$0 + $1.number}))")
                    .fontWeight(.semibold)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 12)
                Chart {
                    ForEach(viewChartFinished) {viewChart in
                        BarMark(x: .value("Color", viewChart.color), y: .value("Number", viewChart.number))
                            .foregroundStyle(barColor(for: viewChart.color))
                        
                    }
                }
                .frame(height: 300)
                .chartXAxis {
                    AxisMarks(values: viewChartFinished.map {$0.color}) { color in
                        AxisValueLabel()
                    }
                }
                
                Text("Average Tries")
                    .font(.headline)
                Text("Total: \(viewChartTries.reduce(0, {$0 + $1.number}))")
                    .fontWeight(.semibold)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 12)
                Chart {
                    ForEach(viewChartTries) {viewChart in
                        BarMark(x: .value("Color", viewChart.color), y: .value("Number", viewChart.number))
                            .foregroundStyle(barColor(for: viewChart.color))
                    }
                }
                .frame(height: 300)
                .chartXAxis {
                    AxisMarks(values: viewChartTries.map {$0.color}) { color in
                        AxisValueLabel()
                    }
                }
            }
            .padding()
            .navigationTitle("Statistics Climbing")
        }
        
    }
}

struct StatisticClimbing_Previews: PreviewProvider {
    static var previews: some View {
        StatisticClimbingView()
    }
}

private func barColor(for color: String) -> Color {
    switch color {
    case "green":
        return .green
    case "purple":
        return .purple
    case "blue":
        return .blue
    case "black":
        return .black
    case "orange":
        return .orange
    case "red":
        return .red
    case "yellow":
        return.yellow
    default:
        return .gray
    }
}
