//
//  HomeView.swift
//  NextApp
//
//  Created by JJMac on 3/07/24.
//

import SwiftUI

struct MapView: View {
    @State private var mapState = MapViewState.noInput
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            if authViewModel.userSession == nil {
                LoginView()
            }else{
                ZStack(alignment: .bottom) {
                    ZStack(alignment: .top) {
                        LCMapViewRepresentable(mapState: $mapState).ignoresSafeArea()
                        
                        if mapState == .searchingForLocation {
                            LocationSearchView(mapState: $mapState)
                        }else if mapState == .noInput{
                            LocationSearchActivationView().padding(.top,72)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        mapState = .searchingForLocation
                                    }
                                }
                        }
                        
                        MapViewActionButton(mapState: $mapState)
                            .padding(.leading)
                            .padding(.top,4)
                    }
                    
                    if mapState == .locationSelected || mapState == .polylineAdded{
                        RequestView()
                            .transition(.move(edge: .bottom))
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
                .onReceive(LocationManager.shared.$userLocation, perform: { location in
                    if let location = location{
                        locationViewModel.userLocation = location
                    }
            })
                
            }
            
        }
    }
}

#Preview {
    MapView()
}
