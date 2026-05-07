//
//  File.swift
//  Lookout
//
//  Created by Vivek Lathiya on 08/05/26.
//

import Foundation
import SwiftUI

public class LookoutSettings: ObservableObject {
    @Published public var showAllLabels: Bool = false
    @MainActor public static let shared = LookoutSettings()
}

public struct LookoutContainer<Content: View>: View {
    let content: Content
    @ObservedObject var settings = LookoutSettings.shared

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        ZStack(alignment: .bottomTrailing) {
            content
            
            // A floating action button that only appears in Debug
            #if DEBUG
            Button(action: { settings.showAllLabels.toggle() }) {
                Image(systemName: settings.showAllLabels ? "eye.fill" : "eye.slash.fill")
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }
            .padding()
            #endif
        }
    }
}
