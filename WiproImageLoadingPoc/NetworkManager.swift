//
//  NetworkManager.swift
//  WiproPOC
//  Copyright © 2018 Vijay. All rights reserved.
//

import Foundation

struct Welcome: Codable {
    let title: String
    let rows: [Row]
}

struct Row: Codable {
    let title, description, imageHref: String?
}

class NetworkManager: NSObject {
    //Singelton Object
    static let sharedInstance = NetworkManager()
    
    private override init() {}
    
    /// This genric function can take any url and decode to any object and returns
    ///
    /// - Parameters:
    ///   - urlString: Service API url
    ///   - completion: Retuns genric object and completion success = true if parsed successfully
    public func fetchGenericData<T: Codable>(urlString: String, completion: @escaping (T?, Bool) -> ()) {
        let url = URL(string: urlString)
        guard let wrappedUrl = url else {
            completion(nil, false)
            return
        }
        URLSession.shared.dataTask(with: wrappedUrl) { (data, resp, err) in
            if let err = err {
                print("Failed to fetch data:", err)
                completion(nil, false)
                return
            }
            guard let data = data else {
                completion(nil, false)
                return }
            let dataString = String.init(data: data, encoding: String.Encoding(rawValue: String.Encoding.isoLatin1.rawValue))
            let dataVal = dataString?.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            guard let cleanedData = dataVal else { return }
            
            do {
                let obj = try JSONDecoder().decode(T.self, from: cleanedData)
                completion(obj, true)
            } catch let jsonErr {
                completion(nil, false)
                print("Failed to decode json:", jsonErr)
            }
            }.resume()
    }
}
