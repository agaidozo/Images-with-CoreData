//
//  ImageFormView.swift
//  My Images CD
//
//  Created by Obde Willy on 04/01/23.
//

import SwiftUI
import PhotosUI

struct ImageFormView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var shareService: ShareService
    @ObservedObject var viewModel: FormViewModel
    @StateObject var imagePicker = ImagePicker()
    @State private var share = false
    @State private var name = ""
    @FetchRequest(sortDescriptors: [])
    private var myImages: FetchedResults<MyImage>
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(uiImage: viewModel.uiImage)
                    .resizable()
                    .scaledToFit()
                
                TextField("Image Name", text: $viewModel.name)
                
                TextField("Comment", text: $viewModel.comment, axis: .vertical)
                
                
                HStack {
                    Text("Date Taken")
                    
                    Spacer()
                    
                    if viewModel.dateHidden {
                        Text("No Date")
                        
                        Button("Set Date") {
                            viewModel.date = Date()
                        }
                    } else {
                        HStack {
                            DatePicker("", selection: $viewModel.date, in: ...Date(), displayedComponents: .date)
                            
                            Button("Clear date") {
                                viewModel.date = Date.distantPast
                            }
                        }
                    }
                }
                .padding()
                .buttonStyle(.bordered)
                
                if !viewModel.receivedFrom.isEmpty {
                    Text("**Received From:** \(viewModel.receivedFrom)")
                }
                
                HStack {
                    if viewModel.updating {
                        PhotosPicker("Change Image",
                                     selection: $imagePicker.imageSelection,
                                     matching: .images,
                                     photoLibrary: .shared())
                        .buttonStyle(.bordered)
                    }
                    
                    Button {
                        if viewModel.updating {
                            if let id = viewModel.id,
                               let selectImage = myImages.first(where: { $0.id == id }) {
                                selectImage.name = viewModel.name
                                selectImage.comment = viewModel.comment
                                selectImage.dateTaken = viewModel.date
                                FileManager().saveImage(with: id, image: viewModel.uiImage)
                                
                                if moc.hasChanges {
                                    try? moc.save()
                                }
                            }
                        } else {
                            let newImage = MyImage(context: moc)
                            newImage.name = viewModel.name
                            newImage.id = UUID().uuidString
                            newImage.comment = viewModel.comment
                            newImage.dateTaken = viewModel.date
                            try? moc.save()
                            FileManager().saveImage(with: newImage.imageID, image: viewModel.uiImage)
                        }
                        
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .disabled(viewModel.incomplete)
                }
                
                Spacer()
            }
            .padding()
            .textFieldStyle(.roundedBorder)
            .disabled(!viewModel.receivedFrom.isEmpty)
            .navigationTitle(viewModel.updating ? "Update Image" : "New Image")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                }
                
                if viewModel.updating {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Button {
                                if let selectedImage = myImages.first(where: { $0.id == viewModel.id }) {
                                    FileManager().deleteImage(with: selectedImage.imageID)
                                    moc.delete(selectedImage)
                                    try? moc.save()
                                }
                                
                                dismiss()
                            } label: {
                                Image(systemName: "trash")
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.red)
                            
                            Button {
                                share.toggle()
                            } label: {
                                Image(systemName: "square.and.arrow.up")
                            }
                        }
                    }
                }
            }
            .onChange(of: imagePicker.uiImage) { newImage in
                if let newImage {
                    viewModel.uiImage = newImage
                }
            }
            .alert("Your Name", isPresented: $share) {
                TextField("Your name", text: $name)
                
                Button("Ok") {
                    if let id = viewModel.id {
                        viewModel.receivedFrom = viewModel.receivedFrom.isEmpty ? name : viewModel.receivedFrom + " -> " + name
                        
                        let codableImage = CodableImage(comment: viewModel.comment,
                                                        dateTaken: viewModel.date,
                                                        id: id,
                                                        name: viewModel.name,
                                                        receivedFrom: viewModel.receivedFrom)
                        
                        shareService.saveMyImage(codableImage)
                    }
                    
                    dismiss()
                }
                
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Please enter your name")
            }

        }
    }
}

struct ImageFormView_Previews: PreviewProvider {
    static var previews: some View {
        ImageFormView(viewModel: FormViewModel(UIImage(systemName: "photo")!))
            .environmentObject(ShareService())
    }
}
