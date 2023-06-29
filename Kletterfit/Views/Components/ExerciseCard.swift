//
//  ExerciseCard.swift
//  Kletterfit
//
//  Created by Jana Eichholz on 20.06.23.
//

import SwiftUI

struct ExerciseCard: View {
    var exercise: Exercises
    
    @State var show = false
    
    @State private var showDeleteConfirmation = false
    
    @Environment(\.managedObjectContext) var moc
    
    func deleteExercise() {
        moc.delete(exercise)
        do {
            try moc.save()
        } catch {
            print("Failed to delete the exercise: \(error)")
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(exercise.exerciseName ?? "Title")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding(.bottom, 4)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(exercise.exerciseDescription ?? "")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
                .padding(.bottom, 4)
            
            Text(exercise.exerciseMuscleGroup ?? "")
                .font(.subheadline)
                .foregroundColor(.secondary)
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
            ActionSheet(title: Text("Delete Route"), message: Text("Are you sure you want to delete this exercise?"), buttons: [
                .destructive(Text("Delete"), action: {
                    deleteExercise()
                }),
                .cancel()
            ])
        }
        .padding(16)
        .background(.blue.opacity(0.2))
        .cornerRadius(16)
        .padding(.bottom, 8)
    }

}

struct ExerciseCard_Previews: PreviewProvider {
    static var previews: some View {
        let exercise = Exercises()
        
        return NavigationView {
            ExerciseCard(exercise: exercise)
        }
    }
}
