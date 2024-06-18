//
//  UploadFileDataService.swift
//  FileShare
//
//  Created by MuMu on 6/9/24.
//

import Foundation


class UploadFileService {
    let url = "\(FileShareViewModel.url)/upload"
    
    func uploadFile(body: FileData) async throws {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        let data = try JSONEncoder().encode(body)
                
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
        let _ = try await URLSession.shared.data(for: request)
    }
}
