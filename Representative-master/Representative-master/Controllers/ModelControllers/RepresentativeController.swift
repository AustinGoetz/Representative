//
//  RepresentativeController.swift
//  Representative-master
//
//  Created by Austin Goetz on 10/2/19.
//  Copyright © 2019 DevMtnStudent. All rights reserved.
//

import Foundation

class RepresentativeController {
    
    static let baseURL = URL(string: "https://whoismyrepresentative.com/getall_reps_bystate.php")
    
    static func searchRepresentatives(forState state: String, completion: @escaping (([Representative]) -> Void)) {
        
        guard let url = baseURL else {completion([]); return}
        
        let stateQuery = URLQueryItem(name: "state", value: state)
        
        // Append with string that enables json data "&output=json"
        let jsonQuery = URLQueryItem(name: "output", value: "json")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = [stateQuery, jsonQuery]
        
        guard let finalURL = components?.url else {completion([]); return}
        
        // Start the dataTask
        let dataTask = URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            
            // If there is an error, handle that first
            if let error = error {
                print("There was an error decoding the Data! \(error.localizedDescription)")
                completion([])
                return
            }
            
            // If there is no error this means I may have data. Guard against the chance there is no data though
            guard let data = data,
                let oldData = String(data: data, encoding: .ascii),
                let newData = oldData.data(using: .utf8)
                else {completion([]); return}
            
            // Now that I know I have data, let's initialize an instance of JSONDecoder and attempt to decode that data
            let jsonDecoder = JSONDecoder()
            
            do {
                let resultsDictionary = try jsonDecoder.decode([String: [Representative]].self, from: newData)
                let repArray = resultsDictionary["results"]
                completion(repArray ?? [])
                print(state)
                
            } catch {
                print("Error decoding the data into our recipe object \(error.localizedDescription)")
                completion([])
                return
            }
        }
        dataTask.resume()
    }
}// END OF CLASS
