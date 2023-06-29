import SwiftUI

struct Checkmark: View {
    @Binding var isChecked: Bool
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var routes: FetchedResults<Route>
    
    var body: some View {
        Button(action: {
            isChecked.toggle()
            do {
                try moc.save()
                print("Daten erfolgreich aktualisiert.")
            } catch {
                print("Fehler beim Speichern der Änderungen: \(error)")
            }
        }) {
            Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isChecked ? .blue : .gray)
            
        }
        .buttonStyle(PlainButtonStyle())
        
        
    }
}
