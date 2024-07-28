//
//  ContentView.swift
//  FileShare
//
//  Created by MuMu on 6/9/24.
//

import SwiftUI


struct FileShareView: View {
    
    @State private var viewModel = FileShareViewModel()
        
    var body: some View {
        NavigationStack {
            Form {
                FileListView()
                DeleteAllButton()
            }
            
            .fileImporterAndExporter(viewModel: $viewModel)
            .navigationTitle("File Share")
            .alert(viewModel.errorMessage, isPresented: $viewModel.showError) { }
            .toolbar { ToolbarButtons() }
        }
        .environment(viewModel)
    }
}


#Preview {
    FileShareView()
}
