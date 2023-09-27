//
// Created for My Images CD
// by Stewart Lynch on 2022-10-31
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import SwiftUI

@main
struct AppEntry: App {
    @StateObject var shareService = ShareService()
    
    var body: some Scene {
        WindowGroup {
            MyImagesGridView()
                .environment(\.managedObjectContext, MyImagesContainer().persistenteContainer.viewContext)
                .environmentObject(shareService)
                .onAppear {
                    print("Document Directory", URL.documentsDirectory.path)
                }
        }
    }
}
