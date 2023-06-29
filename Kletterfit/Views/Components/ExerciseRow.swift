import SwiftUI

struct ExerciseRow: View {
    let exercise: ExerciseInTraining
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("\(exercise.name ?? "")")
                    .font(.headline)
                    .foregroundColor(Color.blue)
                
                Text("\(exercise.sets) sets, \(exercise.repetitions) \(exercise.type ?? "")")
                    .font(.subheadline)
                    .foregroundColor(Color.black)
            }
        }
        .padding(8)
    }
}
