//
//  ImportExportView.swift
//  FileShare
//
//  Created by MuMu on 6/12/24.
//

import SwiftUI


struct ImportExportViewModifier: ViewModifier {
    
    @Binding var viewModel: FileShareViewModel
    
    func body(content: Content) -> some View {
        content
            .fileImporter(
                isPresented: $viewModel.isImporting,
                allowedContentTypes: [.item],
                onCompletion: { result in
                    do {
                        let fileURL = try result.get()
                            
                        if fileURL.startAccessingSecurityScopedResource() {
                            let data = try Data(contentsOf: fileURL)
                            let file = FileData(id: nil, fileName: fileURL.lastPathComponent, data: data)
                            Task {
                                await viewModel.uploadFile(fileData: file)
                            }
                        }
                    } catch {
                        viewModel.errorMessage = "Failed to upload file: \(error.localizedDescription)"
                        viewModel.showError = true
                    }
                }
            )
            .fileExporter(
                isPresented: $viewModel.isExporting,
                document: viewModel.document,
                contentType: .item,
                defaultFilename: viewModel.document?.fileName,
                onCompletion: { result in
                    switch result {
                    case .success:
                        break
                    case .failure(let error):
                        viewModel.errorMessage = "Failed to download file: \(error.localizedDescription)"
                        viewModel.showError = true
                    }
                }
            )
    }
}


extension View {
    func fileImporterAndExporter(viewModel: Binding<FileShareViewModel>) -> some View {
        modifier(ImportExportViewModifier(viewModel: viewModel))
    }
}
