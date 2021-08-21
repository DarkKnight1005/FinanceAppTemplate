//
//  RecentTransactions.swift
//  FinanceAppTemplate
//
//  Created by Ayaz Panahov on 19.08.21.
//

import SwiftUI

struct RecentTransactions: View {
    
    @StateObject var mainOptions: MainOptions;
    @State var selectedItems: [Bool] = [true, false, false];
    
    var body: some View {
        ZStack{
            Color("Background").ignoresSafeArea()
            VStack{
                HStack{
                    Button(action: {
                        mainOptions.selectedIndex = 0;
                    }, label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.black)
                            .frame(width: 20, height: 20, alignment: .center)
                    })
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20, alignment: .center)
                }.padding(.all, 20)
                .padding(.top, 30)
                ScrollView(.vertical){
                    HStack(alignment: .firstTextBaseline){
                        Text("Recent Transactions")
                            .foregroundColor(Color("MainColor"))
                            .bold()
                            .font(.title)
                        Spacer()
                        Text("See all")
                    }.padding(.horizontal, 20)
                    
                    ScrollView(.horizontal){
                        HStack{
                            SelectButton(index: 0, selectedItems: $selectedItems, title: "All")
                                .padding(.leading, 20)
                            SelectButton(index: 1, selectedItems: $selectedItems, title: "Income")
                                .padding(.leading, 5)
                            SelectButton(index: 2, selectedItems: $selectedItems, title: "Expence")
                                .padding(.leading, 5)
                            Spacer()
                        }.padding(.top, 10)
                        .padding(.bottom, 20)
                    }
                    Group{
                        HStack{
                            Text("Today")
                                .font(.title2)
                                .bold()
                                .foregroundColor(Color("MainColor"))
                            Spacer()
                        }.padding([.leading], 20)
                        
                        ExpenceTileLite(title: "Payment", subtitle: "Pament from Adnrea", amount: 3000)
                        Spacer()
                        Spacer()
                        RoundPeople()
                        Group{
                            Spacer()
                            CustomButton(buttonName: "See Details")
                            Spacer()
                        }
                    }
                }
 
            }
            
        }
        .ignoresSafeArea()
    }
}

struct RoundPeople: View{
    var body: some View{
        ZStack{
            Group{
                Ring(radius: UIScreen.screenWidth * 0.7, width: 5, color: Color("AccentRing"))
                Ring(radius: UIScreen.screenWidth * 0.5, width: 30, color: Color("AccentRound"))
                Ring(radius: UIScreen.screenWidth * 0.32, width: 10, color: Color("MainColor"))
            }
            Group{
                VStack{
                    HStack{
                        Spacer()
                        Avatar(radius: UIScreen.screenWidth * 0.13, width: 5, needShadow: true)
                        Spacer()
                    }
                    Spacer()
                    HStack{
                        Avatar(radius: UIScreen.screenWidth * 0.13, width: 5, needShadow: true)
                        Spacer()
                        Avatar(radius: UIScreen.screenWidth * 0.13, width: 5, needShadow: true)
                    }
                    .padding(.bottom, UIScreen.screenWidth * 0.1)
                    Spacer()
                    HStack{
                        Avatar(radius: UIScreen.screenWidth * 0.13, width: 5, needShadow: true)
                        Spacer()
                        Avatar(radius: UIScreen.screenWidth * 0.13, width: 5, needShadow: true)
                    }
                    .padding(.bottom, UIScreen.screenWidth * 0.1)
                    .padding(.horizontal, UIScreen.screenWidth * 0.078)
                }
                Avatar(radius: UIScreen.screenWidth * 0.3, width: 10, needShadow: false)
                
                
                
            }
        }
        .frame(width: UIScreen.screenWidth * 0.8, height: UIScreen.screenWidth * 0.82, alignment: .center)
    }
}
struct Avatar: View {
    
    var radius: CGFloat;
    var width: CGFloat;
    var needShadow: Bool;
    
    var body: some View{
        ZStack{
            Color.white
            ZStack{
                Image("PlaceHolder")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .frame(width: radius - width, height: radius - width, alignment: .center)
            .cornerRadius(1000)
        }
        .cornerRadius(1000)
        .frame(width: radius, height: radius, alignment: .center)
        .shadow(color: Color("AccentRound").opacity(0.5), radius: needShadow ? 10 : 465, x: 0, y: needShadow ? 10 : 0)
    }
}

struct CustomButton: View {
    
    var buttonName: String;

    var body: some View {
        ZStack(){
            Color("MainColor")
            Text(buttonName)
                .foregroundColor(.white)
                .bold()
                .font(.title3)
        }
        .frame(width: UIScreen.screenWidth / 1.2, height: 60, alignment: .center)
        .cornerRadius(50)
        .shadow(color: Color("AccentRound").opacity(0.5), radius: 10, x: 0, y: 10)
       
    }
}

struct Ring: View {
    
    var radius: CGFloat;
    var width: CGFloat;
    var color: Color;
    
    var body: some View{
        ZStack{
            color
            ZStack{
                Color("Background")
            }
            .cornerRadius(1000)
            .frame(width: radius - width, height: radius - width, alignment: .center)
        }
        .cornerRadius(1000)
        .frame(width: radius, height: radius, alignment: .center)
    }
}


struct ExpenceTileLite: View {
    
    var title: String;
    var subtitle: String;
    var amount: Int;
    
    var iconName: String = "dollarsign.circle";
    
    var body: some View{
        ZStack{
            Color.white
            HStack{
                ZStack{
                    Image(systemName: iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color("MainColor"))
                        .frame(width: UIScreen.screenWidth * 0.09, height: UIScreen.screenWidth * 0.09, alignment: .center)
                }
                .cornerRadius(20)
                .frame(width: UIScreen.screenWidth * 0.15, height: UIScreen.screenWidth * 0.15, alignment: .center)
                .padding(.leading, 8)
                .padding(.trailing, 0)
                
                VStack(alignment: .leading){
                    Text(title)
                        .bold()
                        .padding(.bottom, 1)
                    Text(subtitle)
                        .font(.caption)
                }
                Spacer()
                Text("\(amount)$")
                    .bold()
                    .foregroundColor(Color("MainColor"))
                    .padding()
            }
        }
        .cornerRadius(25)
        .shadow(color: Color("AccentRound").opacity(0.6), radius: 15, x: 0, y: 10)
        .padding(.horizontal, UIScreen.screenWidth * 0.07)
        .frame(width: UIScreen.screenWidth, height: 80, alignment: .center)
        .padding(.top, UIScreen.screenHeight * 0.015)
        
    }
}


struct SelectButton : View{
    
    var index: Int;
    
    @Binding var selectedItems: [Bool];
    
    var title: String;
    
    var body: some View{
        Button(action: {
            selectedItems[index] = !selectedItems[index]
            if(title.lowercased() != "all"){
                selectedItems[0] = false;
            }else{
                selectedItems = [true, false, false]
            }
        }, label: {
            ZStack{
                selectedItems[index]
                ? Color("MainColor")
                : Color.white
                
                Text(title)
                    .foregroundColor(selectedItems[index] ? .white : .black )
            }
            .transition(.identity)
            .cornerRadius(100)
            .frame(width: CGFloat(title.count * 19), height: 35, alignment: .center)
            .shadow(color: Color("AccentRound").opacity(0.5), radius: 10, x: 0, y: 10)
            .animation(.easeInOut(duration: 0.5))
        })
        
    }
}

//struct RecentTransactions_Previews: PreviewProvider {
//    static var previews: some View {
//        RecentTransactions()
////        Ring(radius: 50, width: 10, color: Color("MainColor"))
//    }
//}
