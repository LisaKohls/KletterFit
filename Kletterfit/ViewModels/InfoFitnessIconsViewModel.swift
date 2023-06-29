import Foundation
import SwiftUI

var gradientButtonsInfo = [
GradientButtonItem(name: "Statistics", destination: AnyView(StatisticClimbingView()), gradient: LinearGradient(
    gradient: Gradient(stops: [
.init(color: Color(#colorLiteral(red: 0.13333332538604736, green: 0.7960784435272217, blue: 0.2791372537612915, alpha: 0.8700000047683716)), location: 0),
.init(color: Color(#colorLiteral(red: 0.6237647533416748, green: 0.7960784435272217, blue: 0.13333332538604736, alpha: 0.6100000143051147)), location: 0.7778382897377014)]),
    startPoint: UnitPoint(x: -1.1102230246251565e-16, y: 0),
    endPoint: UnitPoint(x: 1.0000000149011612, y: 1.000000014901162))),
GradientButtonItem(name: "Trainings", destination: AnyView(TrainingsView()), gradient: LinearGradient(
    gradient: Gradient(stops: [
.init(color: Color(#colorLiteral(red: 0.7960784435272217, green: 0.6105097532272339, blue: 0.13333332538604736, alpha: 0.8700000047683716)), location: 0.13615889847278595),
.init(color: Color(#colorLiteral(red: 0.75, green: 0.12187504768371582, blue: 0.12187504768371582, alpha: 0.6100000143051147)), location: 0.7778382897377014)]),
    startPoint: UnitPoint(x: -1.1102230246251565e-16, y: 0),
    endPoint: UnitPoint(x: 1.0000000149011612, y: 1.000000014901162))),
GradientButtonItem(name: "Exercises", destination: AnyView(ExerciseOverView()), gradient: LinearGradient(
    gradient: Gradient(stops: [
.init(color: Color(#colorLiteral(red: 0.13333332538604736, green: 0.3586665987968445, blue: 0.7960784435272217, alpha: 0.8700000047683716)), location: 0),
.init(color: Color(#colorLiteral(red: 0.16666662693023682, green: 0.8333333134651184, blue: 0.713333249092102, alpha: 0.6100000143051147)), location: 0.7778382897377014)]),
    startPoint: UnitPoint(x: -1.1102230246251565e-16, y: 0),
    endPoint: UnitPoint(x: 1.0000000149011612, y: 1.000000014901162)))]
