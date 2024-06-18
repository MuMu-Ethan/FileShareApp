//
//  FileShareViewModel.swift
//  FileShare
//
//  Created by MuMu on 6/9/24.
//

import SwiftUI


class FileShareViewModel: ObservableObject {
    
    static let url = "http://192.168.1.7:8080"
    
    @Published var files: [FileData] = []
    @Published var deletedFile: FileData?
    @Published var document: ExportDocument?
    
    @Published var errorMessage = ""
    @Published var showError = false
    
    @Published var isImporting = false
    @Published var isExporting = false
    @Published var isDeletingAll = false
    @Published var isDeletingFile = false
    @Published var isRefreshing = false
    
    let importExportService = ImportExportService()
    
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
    
    func handleImport(result: Result<URL, Error>) {
        do {
            try importExportService.handleImport(result: result, uploadFile: self.uploadFile)
        } catch {
            self.errorMessage = "Failed to upload file: \(error.localizedDescription)"
            self.showError = true
        }
    }
    
    
    func handleExport(result: Result<URL, Error>) {
        do {
            try importExportService.handleExport(result: result)
        } catch {
            self.errorMessage = "Failed to download file: \(error.localizedDescription)"
            self.showError = true
        }
    }
}
