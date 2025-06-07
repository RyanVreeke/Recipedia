//
//  TriggerHapticFeedback.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/6/25.
//

import UIKit

func triggerHapticFeedback(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
    let generator = UIImpactFeedbackGenerator(style: style)
    generator.prepare()
    generator.impactOccurred()
}
