//
//  DataModel.swift
//  ZodiacDaily WatchKit Extension
//
//  Created by Abraham Rubio on 12/02/21.
//

import Foundation

struct Horoscopes: Codable, Identifiable {
    var id : String
    var general: String
    var love: String
    var job: String
}

class APICall {
    func getHoroscopes(sign: String, completion: @escaping([Horoscopes]) -> ()) {
        print(sign)
        guard let url = URL(string: "https://jarvix.ru/api/horoscope.php?signo=\(sign)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            let horos = try! JSONDecoder().decode([Horoscopes].self, from: data!)
            //print(horos)
            DispatchQueue.main.async {
                completion(horos)
            }
        }
        .resume()
        
    }
}
