//
//  ToolbarButtons.swift
//  FileShare
//
//  Created by MuMu on 7/23/24.
//

import SwiftUI

struct ToolbarButtons: View {
    
    @Environment(FileShareViewModel.self) var viewModel
    
    var body: some View {
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
    }
}

#Preview {
    ToolbarButtons()
}
