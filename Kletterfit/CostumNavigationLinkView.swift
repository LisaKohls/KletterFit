//
//  CostumNavigationLinkView.swift
//  Kletterfit
//
//  Created by Jana Eichholz on 06.05.23.
//

import SwiftUI

struct CostumNavigationLinkView: View {
    
    var navigationLinkText: String
    
    var body: some View {
        NavigationLink(destination: TrainingOverView()) {
            Text(navigationLinkText)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.black)
        }
        .aspectRatio(contentMode: .fit)
        .frame(maxWidth: .infinity)
        .padding(20)
        .cornerRadius(15)
    }
}

struct CostumNavigationLinkView_Previews: PreviewProvider {
    static var previews: some View {
        CostumNavigationLinkView(navigationLinkText: "PreviewText")
    }
}
