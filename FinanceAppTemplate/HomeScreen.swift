//
//  SwiftUIView.swift
//  FinanceAppTemplate
//
//  Created by Ayaz Panahov on 18.08.21.
//

import SwiftUI

enum OperationType: String, Codable {
    case SENT = "Sent"
    case RECIEVE = "Recieve"
    case LOAN = "Loan"
}

class ExpenceObject: NSObject, Codable{
    
    var operationType: OperationType;
    var subtitle: String;
    var amount: Int
    
    static func == (lhs: ExpenceObject, rhs: ExpenceObject) -> Bool {
        return lhs.operationType == rhs.operationType && lhs.subtitle == rhs.subtitle && lhs.amount == rhs.amount;
    }
         
    
    init(operationType: OperationType, subtitle: String, amount: Int) {
        self.operationType = operationType;
        self.subtitle = subtitle;
        self.amount = amount;
    }
    
    required init(from decoder: Decoder) throws {
        let values = try! decoder.container(keyedBy: CodingKeys.self)
        self.operationType = try! values.decode(OperationType.self, forKey: .operationType)
        self.subtitle = try! values.decode(String.self, forKey: .subtitle)
        self.amount = try! values.decode(Int.self, forKey: .amount)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(operationType, forKey: .operationType)
        try container.encode(subtitle, forKey: .subtitle)
        try container.encode(amount, forKey: .amount)
    }
    
    enum CodingKeys: String, CodingKey{
        case operationType
        case subtitle
        case amount
    }
}

struct HomeScreen: View {
    
    @StateObject var mainOptions: MainOptions;
    @State var expences: [ExpenceObject] = []
    
    @State var forTrailing: CGFloat = 0;
    @State var forLeading: CGFloat = 0;
    @State var forTop: CGFloat = 0;
    @State var forBottom: CGFloat = 0;
    
    @State var point_position: CGPoint  = CGPoint(x: 0, y: 0);
    @State var displayToolBar: Bool = false;
    
    var body: some View {
        ZStack{
            Color("Background").ignoresSafeArea()
            VStack{
                Overview()
                HStack{
                    Group{
                        Text("Overview")
                            .font(.title)
                            .foregroundColor(Color("MainColor"))
                            .bold()
                        BellIcon(haveNotification: true, expences: $expences, mainOptions: mainOptions)
                    }
                    Spacer()
                    Text("Sept 13, 2020")
                        .foregroundColor(Color("MainColor"))
                    
                }.padding(.horizontal, 22)
                .padding(.vertical, 10)
                ScrollView(.vertical){
                    Group{
                        ForEach(expences, id: \.self ){ item in
                            ExpenceTileDissmisible(expences: $expences, expenceObject: item)
                                .transition(.slide)
                        }
                        .animation(.easeInOut(duration: 0.5))
                    }.padding(.top, 50)
            }
                
                Spacer()
            }.padding(.top, 40)
        }.ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .onAppear{
            let decoded = UserDefaults.standard.array(forKey: "Expences") as? [ExpenceObject] ?? []
            print(decoded)
                //as? [Data] ?? nil
//            if decoded != nil{
//                for elem in 0...decoded!.count {
//                    print("HHEYY")
//                }
//                expences = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded!) as? [ExpenceObject] ?? []
//            }
            
        }
        
    }
}

struct ExpenceTileDissmisible: View{
    
    @State var isFirstTouch: Bool = true;
    @State var delta: CGFloat = 0;
    @State var posX: CGFloat = UIScreen.screenWidth/2;
    @State var opacity: Double = 0;
    
    @Binding var expences: [ExpenceObject];
    var expenceObject: ExpenceObject;
    
    var body: some View{
        ZStack{
            HStack{
                ExpenceTile(expenceObject: expenceObject)
                    .position(x: posX)
                    .onTapGesture {
                        
                    }
                    .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                        .onChanged({ (value) in
                            delta = value.translation.width
                            posX =
                                delta <= 0 ? UIScreen.screenWidth/2 + delta : UIScreen.screenWidth/2 + delta/10
                        })
                        .onEnded({ value in
                            if(posX < UIScreen.screenWidth/4){
                                delta = -120;
                                posX = UIScreen.screenWidth/4
                            }else{
                                delta = 0;
                                posX = UIScreen.screenWidth/2
                            }
                        })
                    )
                    .transition(.slide)
                    .animation(.easeInOut(duration: 0.3))
                Button(action: {
                    expences.remove(at: expences.firstIndex(of: expenceObject)!)
                }, label: {
                    ZStack{
                        Color.red
                        VStack{
                            Image(systemName: "trash")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.white)
                                .frame(width: 40, height: 40, alignment: .center)
                        }
                    }
                })
                .opacity(opacity)
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        opacity = 1
                    }
                }
                .frame(width: 80, height: 80, alignment: .center)
                .cornerRadius(25)
                .position(x: 250 + delta, y: 0.0)
                .animation(.easeInOut(duration: 0.3))
            }
            
        }
       
    }
}

struct ExpenceTile: View {
    
    var expenceObject: ExpenceObject;
    
    
    @State var iconName: String = "dollarsign.cirlce";
    
    var body: some View{
        ZStack{
            Color.white
                .onAppear(){
                    switch expenceObject.operationType{
                        case .SENT:
                            iconName = "arrow.up"
                            break;
                        case .RECIEVE:
                            iconName = "arrow.down"
                            break;
                        case .LOAN:
                            iconName = "dollarsign.square"
                            break;
                    }
                }
            HStack{
                ZStack{
                    Color("AccentRing")
                    Image(systemName: iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.screenWidth * 0.06, height: UIScreen.screenWidth * 0.06, alignment: .center)
                }
                .cornerRadius(20)
                .frame(width: UIScreen.screenWidth * 0.15, height: UIScreen.screenWidth * 0.15, alignment: .center)
                .padding()
                
                VStack(alignment: .leading){
                    Text(expenceObject.operationType.rawValue)
                        .bold()
                    Text(expenceObject.subtitle)
                        .font(.caption)
                }
                Spacer()
                Text("\(expenceObject.amount)$")
                    .bold()
                    .padding()
            }
        }
        .cornerRadius(25)
        .shadow(color: Color("AccentRound").opacity(0.6), radius: 15, x: 0, y: 10)
        .padding(.horizontal, UIScreen.screenWidth * 0.07)
        .frame(width: UIScreen.screenWidth, height: 80, alignment: .center)
        .padding(.vertical, UIScreen.screenHeight * 0.015)
        
        
    }
}

struct PopUpPanel: View{
    var body: some View{
        ZStack{
            Color("AccentRing")
                .opacity(0.9)
                .blur(radius: 5)
            HStack{
                Button(action: {
                    
                }, label: {
                    Spacer()
                    Spacer()
                    VStack{
                        Image(systemName: "pencil")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.blue)
                            .frame(width: 20, height: 30, alignment: .center)
                            .padding(.bottom, 2)
                        Text("Edit")
                            .font(.caption)
                            
                    }
                    Spacer()
                })
                Spacer()
                Divider()
                    .padding(.vertical, 15)
                Spacer()
                Button(action: {
                    
                }, label: {
                    Spacer()
                    VStack{
                        Image(systemName: "trash")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.red)
                            .frame(width: 20, height: 30, alignment: .center)
                            .padding(.bottom, 2)
                        Text("Delete")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                    Spacer()
                    Spacer()
                })
            }
            
        }
//        .background()
        .frame(width: 150, height: 70, alignment: .center)
        .cornerRadius(25)
    }
}

struct BellIcon: View{
    
    @State var haveNotification: Bool;
    @Binding var expences: [ExpenceObject];
    @StateObject var mainOptions: MainOptions;
    
    var body: some View{
        Button(action: {
            haveNotification = !haveNotification;
            let expenceObject: ExpenceObject = ExpenceObject(operationType: OperationType.SENT, subtitle: "String", amount: 555);
            let randInt: Int = Int.random(in: 0...2);
            let randIntAmount: Int = Int.random(in: 100...9999);
            expenceObject.amount = randIntAmount;
            switch randInt{
                case 0:
                    expenceObject.operationType = OperationType.SENT
                    break;
                case 1:
                    expenceObject.operationType = OperationType.RECIEVE
                    break;
                case 2:
                    expenceObject.operationType = OperationType.LOAN
                    break;
                default:
                    expenceObject.operationType = OperationType.SENT
                    break;
            }
            expences.insert(expenceObject, at: 0);
            let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: expences, requiringSecureCoding: false)
            UserDefaults.standard.setValue(encodedData, forKey: "Expences")
        }, label: {
            ZStack{
                Image(systemName: "bell")
                    .imageScale(.large)
                    .foregroundColor(.black)
                    .padding(.top, 2)
                
                if(haveNotification){
                    Image(systemName: "circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.red)
                        .frame(width: 7.5, height: 7.5, alignment: .topTrailing)
                        .padding([.bottom, .leading], 10)
                        .transition(.scale)
                }
            }.animation(.easeInOut(duration: 0.5))
        })
        
    }
}

struct Overview: View {
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
                VStack(){
                    ScrollView(.vertical){
                        Group{
                        HStack{
                            Image(systemName: "text.alignleft")
                                .foregroundColor(Color("MainColor"))
                            Spacer()
                            Image(systemName: "pencil")
                                .foregroundColor(Color("MainColor"))
                        }.padding(.top, 20)
                        .padding(.horizontal)
                        VStack{
                            Spacer()
                            Image("PlaceHolder")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.screenWidth * 0.25, height: UIScreen.screenWidth * 0.25, alignment: .top)
                                .cornerRadius(100)
                            Text("Hira Riazal")
                                .font(.title2)
                                .foregroundColor(Color("MainColor"))
                                .bold()
                            Text("UI/UX Designer")
                                .font(.caption)
                                .padding(.top, 1)
                            Spacer()
                        }
                        Group{
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                        }
                        HStack{
                            VStack{
                                Text("$8900")
                                    .foregroundColor(Color("MainColor"))
                                    .padding(.bottom, 1)
                                Text("Income")
                                    .font(.caption)
                            }
                            .frame(width: UIScreen.screenWidth * 0.2)
                            Divider().frame(width: 1, height: 65).background(Color.black.opacity(0.1))
                            VStack{
                                Text("$5500")
                                    .foregroundColor(Color("MainColor"))
                                    .padding(.bottom, 1)
                                Text("Expenses")
                                    .font(.caption)
                            }
                            .frame(width: UIScreen.screenWidth * 0.2)
                            Divider().frame(width: 1, height: 65).background(Color.black.opacity(0.1))
                            VStack{
                                Text("$890")
                                    .foregroundColor(Color("MainColor"))
                                    .padding(.bottom, 1)
                                Text("Loan")
                                    .font(.caption)
                            }
                            .frame(width: UIScreen.screenWidth * 0.2)
                        }
                        .padding(.bottom, UIScreen.screenHeight * 0.05)
                    }
                }
            }
        }
        .frame(minWidth: UIScreen.screenWidth * 0.85, idealWidth: UIScreen.screenWidth * 0.85, maxWidth: UIScreen.screenWidth * 0.85, minHeight: UIScreen.screenHeight * 0.25, idealHeight: UIScreen.screenHeight * 0.25, maxHeight: UIScreen.screenHeight * 0.4, alignment: .top)
        .cornerRadius(25)
        .shadow(color: Color("AccentRound").opacity(0.6), radius: 15, x: 0, y: 10)
    }
}




struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(mainOptions: MainOptions()).previewDevice(
            "iPhone 12 Pro"
        )
        
//        ExpenceTileDissmisible().previewDevice(
//            "iPhone 12 Pro"
//        )
//
    }
}
