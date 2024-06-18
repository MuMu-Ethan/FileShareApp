//
//  DeleteFileService.swift
//  FileShare
//
//  Created by MuMu on 6/16/24.
//

import Foundation


class DeleteFileService {
    
    let url = FileShareViewModel.url
    
    func deleteFile(file: FileData?) async throws {
        
        guard let id = file?.id else {
            return
        }
        
        let url = "\(url)/delete/\(id)"
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let _ = try await URLSession.shared.data(for: request)
    }
}
