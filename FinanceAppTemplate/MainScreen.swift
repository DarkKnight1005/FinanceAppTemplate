//
//  MainScreen.swift
//  FinanceAppTemplate
//
//  Created by Ayaz Panahov on 18.08.21.
//

import SwiftUI


class MainOptions: ObservableObject{
    @Published var selectedIndex: Int = 0;
}

struct MainScreen: View {
    
    @EnvironmentObject var mainOptions: MainOptions;
    @StateObject var mainOptionsState: MainOptions = MainOptions();
    
    var body: some View {
        
        HomeScreen(mainOptions: mainOptionsState)
//        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
//
//            if(mainOptionsState.selectedIndex == 0){
//                HomeScreen(mainOptions: mainOptionsState)
////                    .transition(.opacity)
//            }else if(mainOptionsState.selectedIndex == 1){
//                RecentTransactions(mainOptions: mainOptionsState)
//                    .transition(.opacity)
//            }else if(mainOptionsState.selectedIndex == 2){
//                HomeScreen(mainOptions: mainOptionsState)
//                    .transition(.opacity)
//            }
//            else if(mainOptionsState.selectedIndex == 3){
//                HomeScreen(mainOptions: mainOptionsState)
//                    .transition(.opacity)
//            }else{
//                HomeScreen(mainOptions: mainOptionsState)
//                    .transition(.opacity)
//            }
//
//
//            TabBarView(mainOptionsState: mainOptionsState)
//        }
//        .animation(.easeInOut(duration: 0.5))
        
        
    }
}

struct TabBarView: View{
    
    @StateObject var mainOptionsState: MainOptions = MainOptions();
    
    private let paddings: [CGFloat] = [0.715, 0.75/2]
    
    
    var body: some View{
        ZStack{
            Color("Background")
                .ignoresSafeArea()
            HStack{
                Group{
                    Spacer()
                    TabBarItemButton(index: 0, title: "Home", iconName: "house", mainOptions: mainOptionsState);
                    Spacer()
                }
                Group{
                    TabBarItemButton(index: 1, title: "Home", iconName: "creditcard", mainOptions: mainOptionsState);
                    Spacer()
                }
                Group{
                    Button(action: {
                        
                    }, label: {
                        MainTabBarItem(title: "Home", iconName: "plus")
                            .transition(.scale)
                    })
                    Spacer()
                }
                Group{
                    TabBarItemButton(index: 2, title: "Home", iconName: "dollarsign.square", mainOptions: mainOptionsState);
                    Spacer()
                }
                Group{
                    TabBarItemButton(index: 3, title: "Home", iconName: "person.crop.circle", mainOptions: mainOptionsState);
                    Spacer()
                }
                
            }.animation(.easeInOut(duration: 0.25))
            .padding(.top, 15)
            .padding(.bottom, UIScreen.screenHeight >= 812.0 ? 65 : 35)
            
            HStack{
                UnderLine()
                    .padding(
                        mainOptionsState.selectedIndex < 2 ? .trailing : .leading,
                        UIScreen.screenWidth * paddings[mainOptionsState.selectedIndex >= 2 ? (((paddings.count-1) - mainOptionsState.selectedIndex % 2)) : mainOptionsState.selectedIndex % 2])
                    
                
            }.animation(.easeInOut(duration: 0.25))
            .padding(.top, 60)
            .padding(.bottom, UIScreen.screenHeight >= 812.0 ? 65 : 35)
            .frame(width: UIScreen.screenWidth * 0.79, height: 10, alignment: .center)
        }
        .frame(width: UIScreen.screenWidth, height: 0, alignment: .center)
    }
}

struct UnderLine: View{
    var body: some View{
        ZStack{
            Color("MainColor")
        }
        .frame(width: 25, height: 7, alignment: .center)
        .cornerRadius(25)
    }
}

struct TabBarItemButton: View{
    
    var index: Int;
    var title: String;
    var iconName: String;
    
    @StateObject var mainOptions: MainOptions;
    
    var body: some View{
        Button(action: {
            mainOptions.selectedIndex = index;
        }, label: {
            TabBarItem(index: index, isSelected: mainOptions.selectedIndex == index, title: title, iconName: iconName)
                .transition(.scale)
        })
    }
}

struct TabBarItem : View{
    
    var index: Int;
    var isSelected: Bool;
    var title: String;
    var iconName: String;
    
    @State var iconSize: CGFloat = 25;
    @State var iconColor: Color = Color.black;
    
    var body: some View{
        VStack{
            Image(systemName: iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(iconColor)
                .frame(width: iconSize, height: iconSize, alignment: .center)
        }
        .onAppear(){
            if(isSelected){
                iconSize = 30;
                iconColor = Color("MainColor")
            }else{
                iconSize = 25;
                iconColor = Color.black
            }
        }
        .onChange(of: isSelected, perform: { value in
            if(value){
                iconSize = 30;
                iconColor = Color("MainColor")
            }else{
                iconSize = 25;
                iconColor = Color.black
            }
        })
    }
}

struct MainTabBarItem : View{
    
    var title: String;
    var iconName: String;
    
    var body: some View{
        ZStack{
            Color("MainColor")
            VStack{
                Image(systemName: iconName)
                    .foregroundColor(.white)
            }
        }
        .cornerRadius(10)
        .frame(width: 40, height: 35, alignment: .center)
        
    }
}


struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen().previewDevice(
            "iPhone 12 Pro"
        )
    }
}
