//
//  ImportAndExportService.swift
//  FileShare
//
//  Created by MuMu on 6/10/24.
//

import Foundation


class ImportExportService {
    
    func handleImport(result: Result<URL, Error>, uploadFile: @escaping (FileData) async -> Void) throws {
        let fileURL = try result.get()
            
        if fileURL.startAccessingSecurityScopedResource() {
            let data = try Data(contentsOf: fileURL)
            let file = FileData(id: nil, fileName: fileURL.lastPathComponent, data: data)
            Task {
                await uploadFile(file)
            }
        }
    }
    
    func handleExport(result: Result<URL, Error>) throws {
        switch result {
        case .success(let url):
            break
        case .failure(let error):
            throw error
        }
    }
}
