//
//  AccessibilityFeature.swift
//  Nutrition Label
//
//  Created by Kaushik Manian on 5/10/25.
//

import SwiftUI

enum AccessibilityCategory: String, CaseIterable {
    case vision = "Vision"
    case hearing = "Hearing"
    case motor = "Motor"
    case motion = "Motion"

    var icon: String {
        switch self {
        case .vision: return "eye.fill"
        case .hearing: return "ear.fill"
        case .motor: return "hand.raised.fill"
        case .motion: return "figure.run"
        }
    }

    var color: Color {
        
        switch self {
        case .vision: return .blue
        case .hearing: return .green
        case .motor: return .orange
        case .motion: return .purple
        }
    }
}

struct AccessibilityFeature: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let icon: String
    let shortDescription: String
    let fullDescription: String
    let platforms: [String      ]
    let color: Color
    let activationSteps: [String]
    let category: AccessibilityCategory

    static let allFeatures: [AccessibilityFeature] = [
        AccessibilityFeature(
            name: "VoiceOver",
            icon: "speaker.wave.2.fill",
            shortDescription: "Screen reader with speech output",
            fullDescription: """
            VoiceOver is Apple's built-in screen reader that allows users to navigate and explore your app using gestures, keyboard, braille, and speech output.

            Key Features:
            • Gesture-based navigation
            • Braille display support
            • Keyboard shortcuts
            • Speech output for all UI elements
            • Rotor controls for quick navigation

            Users can navigate and understand the entire app without seeing the screen, making it essential for blind and low-vision users.
            """,
            platforms: ["iOS", "iPadOS", "macOS", "watchOS", "tvOS", "visionOS"],
            color: .blue,
            activationSteps: [
                "Open the Settings app",
                "Tap Accessibility",
                "Tap VoiceOver",
                "Toggle VoiceOver on",
                "Quick tip: Triple-click the side button to toggle VoiceOver on/off"
            ],
            category: .vision
        ),

        AccessibilityFeature(
            name: "Voice Control",
            icon: "mic.fill",
            shortDescription: "Operate app entirely by voice",
            fullDescription: """
            Voice Control enables users to navigate and interact with your app using only their voice to tap, swipe, click, type, and more.

            Key Features:
            • Voice commands for all interactions
            • Custom vocabulary support
            • Grid overlay for precise selection
            • Dictation for text input
            • Works across all apps

            This feature is crucial for users with limited mobility who cannot use touch or traditional input methods. Not supported on Apple TV and Apple Watch.
            """,
            platforms: ["iOS", "iPadOS", "macOS"],
            color: .purple,
            activationSteps: [
                "Open the Settings app",
                "Tap Accessibility",
                "Tap Voice Control",
                "Tap Set Up Voice Control",
                "Follow the on-screen instructions to complete setup"
            ],
            category: .motor
        ),

        AccessibilityFeature(
            name: "Larger Text",
            icon: "textformat.size",
            shortDescription: "Text size up to 200%+",
            fullDescription: """
            Larger Text allows users to increase the text size in your app to 200% or more for improved readability.

            Key Features:
            • Dynamic Type support
            • Scales from default to 200%+
            • System-wide text size preference
            • Maintains layout and hierarchy
            • Automatic font scaling

            This is essential for users with low vision or reading difficulties. Apps should use Dynamic Type to automatically adjust text size. Not supported on Mac and Apple TV.
            """,
            platforms: ["iOS", "iPadOS", "watchOS", "visionOS"],
            color: .green,
            activationSteps: [
                "Open the Settings app",
                "Tap Accessibility",
                "Tap Display & Text Size",
                "Tap Larger Text",
                "Drag the slider to adjust text size to your preference"
            ],
            category: .vision
        ),

        AccessibilityFeature(
            name: "Dark Interface",
            icon: "moon.fill",
            shortDescription: "Dark appearance to reduce eye strain",
            fullDescription: """
            Dark Interface provides a dark color scheme for screens, menus, and controls to reduce eye strain in low-light environments.

            Key Features:
            • System-wide dark mode
            • Automatic time-based switching
            • Reduced brightness and glare
            • Better contrast in dark environments
            • Preserves color accuracy

            Dark mode helps users with light sensitivity, migraines, or those who prefer working in darker environments. It can reduce eye strain during extended use.
            """,
            platforms: ["iOS", "iPadOS", "macOS", "watchOS", "tvOS", "visionOS"],
            color: .indigo,
            activationSteps: [
                "Open the Settings app",
                "Tap Display & Brightness",
                "Under Appearance, select Dark",
                "Optional: Enable Automatic to switch between Light and Dark based on time"
            ],
            category: .vision
        ),

        AccessibilityFeature(
            name: "Differentiate Without Color Alone",
            icon: "circle.hexagongrid.fill",
            shortDescription: "Uses shapes/text, not just color",
            fullDescription: """
            This feature ensures your app uses shapes, icons, or text in addition to color to convey important information.

            Key Features:
            • Shape-based indicators
            • Text labels for states
            • Icons supplement color
            • Patterns and textures
            • Multiple visual cues

            Critical for users with color blindness or visual processing differences. Never rely solely on color to communicate status, warnings, or important information.
            """,
            platforms: ["iOS", "iPadOS", "macOS", "watchOS", "tvOS", "visionOS"],
            color: .orange,
            activationSteps: [
                "Open the Settings app",
                "Tap Accessibility",
                "Tap Display & Text Size",
                "Toggle on Differentiate Without Color"
            ],
            category: .vision
        ),

        AccessibilityFeature(
            name: "Sufficient Contrast",
            icon: "circle.lefthalf.filled",
            shortDescription: "Higher contrast for better visibility",
            fullDescription: """
            Sufficient Contrast ensures higher contrast ratios between text, icons, and background elements for improved visibility.

            Key Features:
            • Enhanced contrast ratios
            • Better text readability
            • Clearer icon visibility
            • Adjustable contrast levels
            • WCAG compliance support

            Essential for users with low vision, color blindness, or those in bright lighting conditions. Follow WCAG 2.1 guidelines: 4.5:1 for normal text, 3:1 for large text.
            """,
            platforms: ["iOS", "iPadOS", "macOS", "watchOS", "tvOS", "visionOS"],
            color: .gray,
            activationSteps: [
                "Open the Settings app",
                "Tap Accessibility",
                "Tap Display & Text Size",
                "Toggle on Increase Contrast"
            ],
            category: .vision
        ),

        AccessibilityFeature(
            name: "Reduced Motion",
            icon: "arrow.trianglehead.clockwise",
            shortDescription: "Reduced animations for comfort",
            fullDescription: """
            Reduced Motion modifies or reduces certain types of animation that may cause motion sickness, discomfort, or distraction.

            Key Features:
            • Minimized animations
            • Crossfade transitions
            • Disabled parallax effects
            • Static interface elements
            • Simplified visual changes

            Helps users with vestibular disorders, motion sensitivity, ADHD, or those who are easily distracted. Replace complex animations with simple fades or instant transitions.
            """,
            platforms: ["iOS", "iPadOS", "macOS", "watchOS", "tvOS", "visionOS"],
            color: .teal,
            activationSteps: [
                "Open the Settings app",
                "Tap Accessibility",
                "Tap Motion",
                "Toggle on Reduce Motion"
            ],
            category: .motion
        ),

        AccessibilityFeature(
            name: "Captions",
            icon: "captions.bubble.fill",
            shortDescription: "Text for dialog and sounds",
            fullDescription: """
            Captions provide time-synchronized text for dialog and relevant sounds in video or audio-only content.

            Key Features:
            • Synchronized text display
            • Speaker identification
            • Sound effect descriptions
            • Multiple language support
            • Customizable appearance

            Essential for deaf and hard-of-hearing users, as well as users in sound-sensitive environments or those learning a new language. Include both dialogue and important sound effects.
            """,
            platforms: ["iOS", "iPadOS", "macOS", "tvOS", "visionOS"],
            color: .pink,
            activationSteps: [
                "Open the Settings app",
                "Tap Accessibility",
                "Tap Subtitles & Captioning",
                "Toggle on Closed Captions + SDH",
                "Tap Style to customize caption appearance"
            ],
            category: .hearing
        ),

        AccessibilityFeature(
            name: "Audio Descriptions",
            icon: "waveform",
            shortDescription: "Narrated descriptions of visuals",
            fullDescription: """
            Audio Descriptions provide narrated descriptions of visual content in videos with time-synchronized narration of key visual elements.

            Key Features:
            • Descriptive narration
            • Time-synchronized audio
            • Scene and action descriptions
            • Character and setting details
            • Extended audio descriptions

            Crucial for blind and low-vision users to understand visual content in videos. Describes important visual information that isn't conveyed through dialogue or sound effects.
            """,
            platforms: ["iOS", "iPadOS", "macOS", "tvOS", "visionOS"],
            color: .red,
            activationSteps: [
                "Open the Settings app",
                "Tap Accessibility",
                "Tap Audio Descriptions",
                "Toggle on Audio Descriptions",
                "Note: Content must support audio descriptions for this feature to work"
            ],
            category: .hearing
        )
    ]
}
