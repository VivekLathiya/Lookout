// The Swift Programming Language
// https://docs.swift.org/swift-book


import SwiftUI

#if DEBUG
public struct LookoutModifier: ViewModifier {
    @State private var isEnabled: Bool = true
    
    public func body(content: Content) -> some View {
        content
            .overlay(
                ZStack {
                    if isEnabled {
                        // Border to show the frame of the view
                        Rectangle()
                            .strokeBorder(Color.blue.opacity(0.5), style: StrokeStyle(lineWidth: 1, dash: [4]))
                        
                        // Label to show the exact dimensions
                        GeometryReader { geo in
                            VStack {
                                Spacer()
                                Text("\(Int(geo.size.width)) x \(Int(geo.size.height))")
                                    .font(.system(size: 8, weight: .bold, design: .monospaced))
                                    .padding(2)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(2)
                                    .offset(y: 10)
                            }
                        }
                    }
                }
            )
            // Long press to toggle this specific view's inspector
            .onLongPressGesture {
                isEnabled.toggle()
            }
    }
}

public extension View {
    /// Adds a debug border and dimension label to the view.
    /// Long press to toggle the overlay.
    func lookout() -> some View {
        self.modifier(LookoutModifier())
    }
}
#else
public extension View {
    // In release builds, this does absolutely nothing (Zero overhead)
    func lookout() -> some View { self }
}
#endif
