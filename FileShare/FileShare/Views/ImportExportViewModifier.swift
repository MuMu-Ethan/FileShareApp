//
//  ImportExportView.swift
//  FileShare
//
//  Created by MuMu on 6/12/24.
//

import SwiftUI


struct ImportExportViewModifier: ViewModifier {
    
    @ObservedObject var viewModel: FileShareViewModel
    
    func body(content: Content) -> some View {
        content
            .fileImporter(isPresented: $viewModel.isImporting, allowedContentTypes: [.item], onCompletion: viewModel.handleImport)
            .fileExporter(isPresented: $viewModel.isExporting, document: viewModel.document, contentType: .item, defaultFilename: viewModel.document?.fileName, onCompletion: viewModel.handleExport)
    }
}


extension View {
    func fileImporterAndExporter(viewModel: FileShareViewModel) -> some View {
        modifier(ImportExportViewModifier(viewModel: viewModel))
    }
}
