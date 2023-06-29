import SwiftUI
import UIKit

struct AddRouteView: View {
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage? = nil
    
    @State private var nameOfRoute: String = ""
    @State private var descriptionOfRoute: String = ""
    
    @State private var selectedColor: ColorOfRoute = .green
    @State var selectedOptionColor = ""
    
    @State private var tries: Int16 = 0
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isChecked = false
    
    @State var showAlert = false
    
    //Core Data
    @FetchRequest(sortDescriptors: []) var routes: FetchedResults<Route>
    @Environment(\.managedObjectContext) var moc
    
    
    var selectedUIImage: Image? {
        if let image = selectedImage {
            return Image(uiImage: image)
        } else {
            return nil
        }
    }
    
    var body: some View {
        
        VStack {
            Form {
                Section {
                    TextField("Name", text: $nameOfRoute)
                    TextField("Description", text: $descriptionOfRoute)
                }
                Section {
                    List {
                        Picker("Color", selection: $selectedColor) {
                            Text("green").tag(ColorOfRoute.green)
                            Text("purple").tag(ColorOfRoute.purple)
                            Text("blue").tag(ColorOfRoute.blue)
                            Text("black").tag(ColorOfRoute.black)
                            Text("orange").tag(ColorOfRoute.orange)
                            Text("red").tag(ColorOfRoute.red)
                            Text("yellow").tag(ColorOfRoute.yellow)
                        }
                    }
                }
                Section {
                    Stepper("Tries: \(tries)", value: $tries, in: 0...100)
                    HStack {
                        Text("Finished")
                        Spacer()
                        Checkmark(isChecked: $isChecked)
                    }
                    
                }
                Section {
                    Button(action: {
                        showImagePicker.toggle()
                    }) {
                        Text("Add Photo of route")
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(sourceType: .camera, selectedImage: $selectedImage)
                    }
                }
                
                Section {
                    selectedUIImage?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .cornerRadius(20)
                }
            }
        }
        .navigationBarTitle("Add route", displayMode: .inline)
        .navigationBarItems(trailing:
                                Button("Save", action: {
            //Route wird abgespeichert
            if nameOfRoute.isEmpty {
                showAlert = true
            } else {
                let newRoute = Route(context: moc)
                newRoute.id = UUID()
                newRoute.name = nameOfRoute
                newRoute.routeDescription = descriptionOfRoute
                newRoute.tries = tries
                newRoute.color = selectedColor.rawValue
                newRoute.image = selectedImage?.jpegData(compressionQuality: 1.0)
                newRoute.finished = isChecked
                print(isChecked)
                do {
                    try moc.save()
                    // Close the page
                    presentationMode.wrappedValue.dismiss()
                } catch {
                    // Handle save error
                    print("Failed to save the route: \(error)")
                }
            }
            
        })
        )
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Invalid Route"), message: Text("Make sure you've filled out all necessary fields."), dismissButton: .default(Text("Got it!")))
        }
    }
}

struct AddRoute_Previews: PreviewProvider {
    static var previews: some View {
        AddRouteView()
        
    }
}

enum ColorOfRoute: String, CaseIterable, Identifiable {
    case green, purple, blue, black, orange, red, yellow
    var id: Self { self }
}

