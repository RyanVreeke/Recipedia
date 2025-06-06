//
//  ImageLoaderProtocol.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/3/25.
//

import SwiftUI

/// ImageLoader protocol that is set up for the ImageLoader and tests.
protocol ImageLoaderProtocol: Actor {
    var urlSession: URLSession { get }
    func loadImage(url: URL) async -> (UIImage?, Bool)?
}
