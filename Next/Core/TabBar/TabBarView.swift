//
//  TabBarView.swift
//  NEXT
//
//  Created by JJMac on 4/07/24.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var selectedTab = 0
    var body: some View {
        Group{
            if authViewModel.userSession == nil {
                LoginView()
            }else{
                TabView(selection: $selectedTab) {
                    Text("Home")
                        .tabItem { VStack{
                            Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                                .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                            Text("Home")
                        } }
                        .onAppear {
                            selectedTab = 0
                        }
                        .tag(0)
                    
                    Text("Cart")
                        .tabItem { VStack{
                            Image(systemName: selectedTab == 1 ? "cart.fill" : "cart")
                                .environment(\.symbolVariants, selectedTab == 1 ? .fill : .none)
                            Text("Cart")
                        } }
                        .onAppear {
                            selectedTab = 1
                        }
                        .tag(1)
                    

                    
                    MapView()
                        .environmentObject(authViewModel)
                        .environmentObject(locationViewModel)
                    
                        .tabItem { VStack{
                            Image(systemName: selectedTab == 3 ? "map.circle.fill" : "map.circle")
                                .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                            Text("Map")
                        } }
                        .onAppear {
                            selectedTab = 3
                        }
                        .tag(3)
                    
                    Text("Profile")
                        .tabItem { VStack{
                            Image(systemName: selectedTab == 4 ? "person.crop.circle.fill" : "person.crop.circle")
                                .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
                            Text("Profile")
                        } }
                        .onAppear {
                            selectedTab = 4
                        }
                        .tag(4)
                }
                .background(.white)
                .tint(.purple)
                .onAppear{
                    UITabBar.appearance().isTranslucent = false // Setting tab bar to be opaque
                    UITabBar.appearance().backgroundColor = UIColor.white // Ensuring tab bar background color is white
                }
            }
        }
    }
}

#Preview {
    TabBarView()
}
