//
//  API.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 29/07/2024.
//

import Foundation

struct API {
    static func getHomeSection(completion: @escaping (Result<SectionResponseDTO, Error>) -> Void) {
        guard let url = URL(string: "https://mobile.clients.peacocktv.com/bff/sections/v1?template=sections_v2&segment=all_free_users&node_id=32849634-d3d3-11e9-bbc6-d7a405d0af9d") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("US", forHTTPHeaderField: "x-skyott-activeterritory")
        request.setValue("MOBILE", forHTTPHeaderField: "x-skyott-device")
        request.setValue("en", forHTTPHeaderField: "x-skyott-language")
        request.setValue("IOS", forHTTPHeaderField: "x-skyott-platform")
        request.setValue("NBCUOTT", forHTTPHeaderField: "x-skyott-proposition")
        request.setValue("NBCU", forHTTPHeaderField: "x-skyott-provider")
        request.setValue("US", forHTTPHeaderField: "x-skyott-territory")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
               completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
               return
           }
            
            do {
                // Parse the JSON data
                let jsonData = String(data: data, encoding: .utf8)
                let result = try JSONDecoder().decode(SectionResponseDTO.self, from: data)
                completion(.success(result))
            } catch let decodingError {
                // let message = "Decoding error: \(decodingError.detailedDescription)"
                //print(message)
                completion(.failure(decodingError))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
}

extension DecodingError {
    var detailedDescription: String {
        switch self {
        case .typeMismatch(let type, let context):
            return "Type '\(type)' mismatch: \(context.debugDescription) - \(context.codingPath)"
        case .valueNotFound(let type, let context):
            return "Value '\(type)' not found: \(context.debugDescription) - \(context.codingPath)"
        case .keyNotFound(let key, let context):
            return "Key '\(key)' not found: \(context.debugDescription) - \(context.codingPath)"
        case .dataCorrupted(let context):
            return "Data corrupted: \(context.debugDescription) - \(context.codingPath)"
        @unknown default:
            return "Unknown error: \(self)"
        }
    }
}
