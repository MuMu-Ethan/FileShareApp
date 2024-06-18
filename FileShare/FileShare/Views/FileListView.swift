//
//  FileListView.swift
//  FileShare
//
//  Created by MuMu on 6/12/24.
//

import SwiftUI


struct FileListView: View {
    
    @ObservedObject var viewModel: FileShareViewModel
    
    var body: some View {
        Section {
            ForEach(viewModel.files) { file in
                HStack {
                    Text(file.fileName)
                    
                    Spacer()
                    
                    Button {
                        viewModel.document = ExportDocument(fileName: file.fileName, data: file.data)
                        viewModel.isExporting = true
                    } label: {
                        Image(systemName: "square.and.arrow.down")
                    }
                }
            }
            .onDelete { offsets in
                for index in offsets {
                    print(index)
                    viewModel.deletedFile = viewModel.files[index]
                    viewModel.files.remove(atOffsets: offsets)
                    Task {
                        await viewModel.deleteFile()
                        await viewModel.fetchFiles()
                    }
                    
                }
            }
        }
    }
}
