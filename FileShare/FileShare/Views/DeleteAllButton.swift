//
//  DeleteAllButton.swift
//  FileShare
//
//  Created by MuMu on 7/24/24.
//

import SwiftUI

struct DeleteAllButton: View {
    
    @Environment(FileShareViewModel.self) var viewModel
    
    var body: some View {
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
        .alert("Are you sure you want to delete all files?", isPresented: Bindable(viewModel).isDeletingAll) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                Task {
                    await viewModel.deleteAllFiles()
                    await viewModel.fetchFiles()
                }
            }
        }
        
    }
}

#Preview {
    DeleteAllButton()
}
