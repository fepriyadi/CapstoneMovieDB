//
//  File.swift
//  
//
//  Created by Fep on 18/07/24.
//

import Foundation

public class Utils {
    
    public static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    public static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter
    }()
    
    private static var timeHMSFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        return formatter
    }()
    
    static func formatSecondsToHMS(_ seconds: Double) -> String {
        guard !seconds.isNaN,
            let text = timeHMSFormatter.string(from: seconds) else {
                return "00:00"
        }
         
        return text
    }
    static func round(to places: Int, number: Double) -> Double {
            let divisor = pow(100.0, Double(places))
            return (number * divisor).rounded() / divisor
        }
    
    public static func extractParams(parameters: [String: Any]) -> String{
        var parameterString = ""
        for (key, value) in parameters {
            let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let encodedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
            if parameterString.isEmpty {
                parameterString += "\(encodedKey)=\(encodedValue)"
            } else {
                parameterString += "&\(encodedKey)=\(encodedValue)"
            }
        }
        return parameterString
    }
    
//    public static func castToJson(movie: MovieObject){
//        let encoder = JSONEncoder()
//        encoder.outputFormatting = .prettyPrinted // Optional: for pretty printed JSON
//        let jsonData = try? encoder.encode(movie)
//        
//        if let jsonString = String(data: jsonData ?? Data(), encoding: .utf8) {
//            print(jsonString)
//        }
//    }
}
