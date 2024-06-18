//
//  FetchFileDataService.swift
//  FileShare
//
//  Created by MuMu on 6/9/24.
//

import Foundation


class FetchFileService {
    // Server URL
    let url = "http://192.168.1.8:8080"
    
    func fetchFiles() async throws -> [FileData] {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let files = try JSONDecoder().decode([FileData].self, from: data)
        return files
        
    }
}

