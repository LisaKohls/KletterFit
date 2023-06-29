//
//  TrainingListItemView.swift
//  Kletterfit
//
//  Created by Jana Eichholz on 08.06.23.
//

import SwiftUI

struct TrainingListRowView: View {
    
    var item: TrainingItem
    @State var show = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            Image(systemName: item.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 128)
                .frame(maxWidth: .infinity)
            
            Text(item.name)
                .font(.title)
                .fontWeight(.bold)
            
            Text(item.duration)
                .font(.subheadline)
                .opacity(0.7)
            
            Text(item.creator)
                .opacity(0.7)
        }
        .sheet(isPresented: $show, content: {
            TrainingDetailView()
        })
        .onTapGesture {
            show.toggle()
        }
        .foregroundColor(.white)
        .padding(16)
        .background(item.background)
        .cornerRadius(30)
        .padding(.bottom, 8)
    }
}

struct TrainingListRowView2_Previews: PreviewProvider {
    static var previews: some View {
        TrainingListRowView(item: TrainingItem(name: "Name of Training", duration: "50 min", creator: "You", icon: "figure.strengthtraining.traditional", background: .accentColor))
    }
}


