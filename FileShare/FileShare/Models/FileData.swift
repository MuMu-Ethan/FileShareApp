//
//  FileData.swift
//  FileShare
//
//  Created by MuMu on 6/9/24.
//

import Foundation


struct FileData: Codable, Identifiable {
    let id: UUID?
    let fileName: String
    let data: Data
}
