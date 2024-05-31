//
//  Navigator+Model.swift
//  Navigator
//
//  Created by Stephen Wojcik on 28/05/2024.
//

import Foundation

public struct Destination: Hashable, Identifiable {
    public let id = UUID()
}

public enum PresentationStyle: Hashable {
    case sheet
    @available(macOS, unavailable)
    case fullScreenCover
}

public enum CoordinationMethod: Hashable {
    case root
    case pushed(destination: Destination)
    case presented
}
