//
//  FileShareViewModel.swift
//  FileShare
//
//  Created by MuMu on 6/9/24.
//

import SwiftUI
import Observation

@Observable
class FileShareViewModel {
    
    static let url = "http://127.0.0.1:8080"
    
    var files: [FileData] = []
    var deletedFile: FileData?
    var document: ExportDocument?
    
    var errorMessage = ""
    var showError = false
    
    var isImporting = false
    var isExporting = false
    var isDeletingAll = false
    var isRefreshing = false
    
    let fetchService = FetchFileService()
    let uploadService = UploadFileService()
    let deleteAllService = DeleteAllFilesService()
    let deleteFileService = DeleteFileService()
    
    init() {
        Task{ await self.fetchFiles() }
    }
    
    func fetchFiles() async {
        do {
            let files = try await fetchService.fetchFiles()
            await MainActor.run {
                withAnimation {
                    self.files = files
                }
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Failed to refresh: \(error.localizedDescription)"
                self.showError = true
            }
        }
    }
    
    
    func uploadFile(fileData: FileData) async {
        do {
            try await uploadService.uploadFile(body: fileData)
            await self.fetchFiles()
        } catch {
            await MainActor.run {
                self.errorMessage = "Failed to upload file: \(error.localizedDescription)"
                self.showError = true
            }
        }
    }
    
    func deleteAllFiles() async {
        do {
            try await deleteAllService.deleteAll()
        } catch {
            await MainActor.run {
                self.errorMessage = "Failed to delete all files: \(error.localizedDescription)"
                self.showError = true
            }
        }
    }
    
    func deleteFile() async {
        do {
            try await deleteFileService.deleteFile(file: deletedFile)
        } catch {
            await MainActor.run {
                self.errorMessage = "Failed to delete file: \(error.localizedDescription)"
                self.showError = true
            }
        }
    }
}
