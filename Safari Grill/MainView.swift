//
//  MainView.swift
//  Safari Grill
//
//  Created by Jay Jayaprakash on 23/08/2023.
//

import SwiftUI



struct MainView: View {
    @ObservedObject var MenuItemViewModelLocal = MenuItemViewModel()
    
    var body: some View {
        ScrollView{
            VStack {
                ForEach(MenuItemViewModelLocal.MenuItems, id: \.id) { menuItem in
                    MenuItemView(menuItem: menuItem)
                    
                }
                
                Button {
                    MenuItemViewModelLocal.getData()
                } label: {
                    Text("Press ME")
                }
            }
            .padding(.horizontal,10)        }
    }
}


struct MenuItemView: View {
    let menuItem: MenuItem
    @ObservedObject private var imageLoader: ImageLoader
    
    @State private var extended = false
    
    init(menuItem: MenuItem) {
        self.menuItem = menuItem
        self._imageLoader = ObservedObject(wrappedValue: ImageLoader(urlString: menuItem.imageURL))
    }
    
    var body: some View {
        VStack {
            ZStack {
                if let image = imageLoader.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: extended ? 500 : 300)
                        .clipped()
                        .cornerRadius(15)
                } else {
                    
                    Image("placeholder")
                        .resizable()
                        .scaledToFill()
                        .frame(height: extended ? 500 : 300)
                        .clipped()
                        .cornerRadius(15)
                }
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(Color(.systemBackground))
                        .cornerRadius(20)
                        .frame(height: extended ? 300 : 130)
                        .overlay(
                            VStack {
                                Text(menuItem.name)
                                    .foregroundColor(.orange)
                                    .font(.title)
                                    .fontWeight(.heavy)
                                if extended {
                                    Text(menuItem.description)
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .padding(.top, 5)
                                }
                            }
                                .padding(30)
                        )
                        .animation(.linear(duration: 0.3))
                }
                .padding()
                .animation(.easeInOut(duration: 0.3))
            }
        }
        .padding(.horizontal, 10)
        .onTapGesture(perform: {
            withAnimation {
                extended.toggle()
            }
        })
        .frame(height: extended ? 800 : 400)
    }
}








#Preview {
    MainView()
}
