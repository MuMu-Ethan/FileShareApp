//
//  FileDocument.swift
//  FileShare
//
//  Created by MuMu on 6/9/24.
//

import SwiftUI
import UniformTypeIdentifiers


struct ExportDocument: FileDocument {
    static var readableContentTypes: [UTType] = [.item]
    
    var fileName: String
    var data: Data
    
    init(fileName: String, data: Data) {
        self.fileName = fileName
        self.data = data
    }
    
    init(configuration: ReadConfiguration) throws {
        if let fileData = configuration.file.regularFileContents {
            self.data = fileData
            self.fileName = ""
        } else {
            throw CocoaError(.fileReadCorruptFile)
        }
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        FileWrapper(regularFileWithContents: data)
    }
    
    
}
