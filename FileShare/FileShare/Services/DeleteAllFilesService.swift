//
//  DeleteAllFilesService.swift
//  FileShare
//
//  Created by MuMu on 6/12/24.
//

import Foundation


class DeleteAllFilesService {
    
    let url = "\(FileShareViewModel.url)/delete/all"
    
    func deleteAll() async throws {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let _ = try await URLSession.shared.data(for: request)
    }
}
