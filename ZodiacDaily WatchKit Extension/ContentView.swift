//
//  ContentView.swift
//  ZodiacDaily WatchKit Extension
//
//  Created by Abraham Rubio on 12/02/21.
//

import UserNotifications
import SwiftUI

struct ContentView: View {
    @State var secondScreenShown = false
    @State var listVal = getDay()
    let horoscopos = ["Aries", "Tauro", "Geminis", "Cancer", "Leo", "Virgo", "Libra", "Escorpio", "Sagitario", "Capricornio", "Acuario", "Piscis"]
    
    var body: some View {
        
        VStack{
            Text(listVal.self).font(.title2)
            Spacer()
            Picker("Signos Zodiacales", selection: $listVal) {
                ForEach(horoscopos, id: \.self) { i in
                    HStack(alignment: .center) {
                        Image(i)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25.0, height: 25.0)
                        Text(i).font(.title3)
                    }
                    
                }
            }
            .padding()
            .frame(height: 80)
            Spacer()
            //if listVal != getDay() {
            
            NavigationLink(destination: SecondView(secondScreenShown: $secondScreenShown, listVal: listVal), isActive: $secondScreenShown,
                           label: {
                            Text("Buscar")
                            
                           })
                .background(Color.purple)
                .cornerRadius(15)
                .padding([.leading, .bottom, .trailing])
                .opacity(listVal != getDay() ? 1 : 0.5)
                .disabled(listVal != getDay() ? false : true)
            // }
            
        }
    }
}

struct SecondView: View{
    @Binding var secondScreenShown: Bool
    @State var listVal:String
    @State var horos: [Horoscopes] = []
    var proView = LoadingView()
    @State private var shouldHide = false
    
    @State var showLoadingView: Bool = true
    var body: some View {
        
        //VStack{
        HStack{
            Image(listVal.self)
                .resizable()
                .scaledToFit()
                .frame(width: 25.0, height: 25.0)
            Text("\(listVal.self)").bold()
            //ProgressView()
        }
        if showLoadingView {
            LoadingView()
        }
        List {
            ForEach(horos) { detalle in
                Text("🔎 General:\n").bold() + Text(detalle.general)
                Text("💕 Amor:\n").bold() + Text(detalle.love)
                Text("👩‍💻 Trabajo:\n").bold() + Text(detalle.job)
                
            }
            .onAppear(perform: {
                showLoadingView = false
            })
        }
        
        .onAppear {
            self.shouldHide = true
            print("onAppear: \(listVal.self)")
            APICall().getHoroscopes(sign: listVal.self) { (horos) in
                self.horos = horos
            }
            
        }
        //}
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func getDay() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier:"es_MX")
    dateFormatter.setLocalizedDateFormatFromTemplate("d")
    let dayNum = dateFormatter.string(from: Date())
    dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
    let month = dateFormatter.string(from: Date())
    return month.capitalizingFirstLetter() + " " + dayNum
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}

