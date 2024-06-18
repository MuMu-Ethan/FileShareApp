//
//  ContentView.swift
//  FileShare
//
//  Created by MuMu on 6/9/24.
//

import SwiftUI


struct FileShareView: View {
    
    @StateObject private var viewModel = FileShareViewModel()
        
    var body: some View {
        NavigationStack {
            Form {
                FileListView(viewModel: viewModel)
                
                Section {
                    Button(role: .destructive) {
                        Task {
                            viewModel.isDeletingAll = true
                        }
                    } label: {
                        HStack {
                            Text("Delete All Files")
                            Image(systemName: "trash")
                        }
                    }
                }
            }
            
            .fileImporterAndExporter(viewModel: viewModel)
            .navigationTitle("File Share")
            .alert(viewModel.errorMessage, isPresented: $viewModel.showError) {
                Button("OK") { }
            }
            .alert("Are you sure you want to delete all files?", isPresented: $viewModel.isDeletingAll) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    Task {
                        await viewModel.deleteAllFiles()
                        await viewModel.fetchFiles()
                    }
                }
            }
            .toolbar {
                Button {
                    viewModel.isRefreshing.toggle()
                    Task {
                        await viewModel.fetchFiles()
                    }
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .symbolEffect(.bounce, value: viewModel.isRefreshing)
                }
                
                Button("Upload") {
                    viewModel.isImporting = true
                }
                
                EditButton()
            }
        }
    }
}


#Preview {
    FileShareView()
}
