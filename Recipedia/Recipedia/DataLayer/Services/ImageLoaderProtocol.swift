//
//  ImageLoaderProtocol.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/3/25.
//

import Foundation
import SwiftUI

/// ImageLoader protocol that is set up for the ImageLoader and tests.
protocol ImageLoaderProtocol {
    func loadImage(url: URL) async -> UIImage?
}
