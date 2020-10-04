//
//  DateView.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import SwiftUI

struct DateView: View {
    
    @ObservedObject var viewModel: PrayerTimeListViewModel

    var body: some View {
        
        HStack {
            Button(action: {
                
            }) {
                Image(systemName: "chevron.backward")
            }
            VStack {
                Text(viewModel.hijriDate).font(.largeTitle)
                Text(viewModel.gregorianDate).font(.headline)
            }
            Button(action: {
                
            }) {
                Image(systemName: "chevron.forward")
            }    
        }
    }
}

struct DateView_Previews: PreviewProvider {
    @State static var viewModel = PreviewData().prayerTimeListViewModel
    static var previews: some View {
        DateView(viewModel: viewModel)
    }
}
