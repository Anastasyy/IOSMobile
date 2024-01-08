//
//  Laba_1App.swift
//  Laba_1
//
//  Created by Anastasiia on 08.01.2024.
//

import SwiftUI
import SwiftData
@main
struct Laba_1App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(PreviewSampleData.container)
        }
    }
}

