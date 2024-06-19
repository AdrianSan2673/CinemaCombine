//
//  Utils.swift
//  CarteleraMDB
//
//  Created by Adrian San Martin on 30/03/24.
//

import Foundation
import UIKit
class Utils {

    private let urlSession = URLSession.shared
    
    static let jsonDecoder : JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter
    }()
    
    func loadURLAndDecode<T: Codable>(url: URL, params: [String: String]? = nil, completion: @escaping (T?, MovieError?) -> ()) {
        
        // Guardo la url
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(nil, .invalidEndPoint)
            return
        }
        
        // Recibe los paramatros y los quaryItems
        var quaryItems = [URLQueryItem(name: "api_key", value: Base_token.token.rawValue)]
        if let params = params {
            quaryItems.append(contentsOf: params.map {URLQueryItem(name: $0.key, value: $0.key)} )
        }
        urlComponents.queryItems =  quaryItems
        
        //completa la url final
        guard let finalURL = urlComponents.url else {
            completion(nil, .invalidEndPoint)
            return
        }
        
        //Inicia la tarea
        urlSession.dataTask(with: finalURL) { [weak self] (data, response, error) in
            guard let self = self else {return}
            if error != nil {
                completion(nil, .apiError)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                completion(nil, .invalidResponse)
                return
            }
            guard let data = data else {
                completion(nil, .noData)
                return
            }
            do {
                //Obtengo la respuesta y realixo el parseo
                let decodeResponse = try? JSONDecoder().decode(T.self, from: data)
                completion(decodeResponse, nil)
            } catch let decodingError as DecodingError {
                switch decodingError {
                        case .typeMismatch(let type, let context):
                            print("Type mismatch error: \(type), context: \(context)")
                            completion(nil,.typeMismatch)
                        case .keyNotFound(let key, let context):
                            print("Key not found error: \(key), context: \(context)")
                            completion(nil, .keyNotFound)
                        case .valueNotFound(let type, let context):
                            print("Value not found error: \(type), context: \(context)")
                            completion(nil, .valueNotFound)
                        case .dataCorrupted(let context):
                            print("Data corrupted error, context: \(context)")
                            completion(nil, .invalidResponse)
                        default:
                            print("Decoding error: \(decodingError)")
                            completion(nil, .serializationError)
                    }
            }
            catch {
                completion(nil, .serializationError)
            }
        }.resume()
    }
}

extension UIColor {
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
