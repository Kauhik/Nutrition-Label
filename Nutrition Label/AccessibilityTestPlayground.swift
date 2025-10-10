//
//  AccessibilityTestPlayground.swift
//  Nutrition Label
//
//  Created by Kaushik Manian on 5/10/25.
//

import SwiftUI
import AVKit

struct AccessibilityTestPlayground: View {
    let feature: AccessibilityFeature

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Try It Out")
                .font(.headline)
                .foregroundStyle(.secondary)

            Text("Test how this accessibility feature works with the interactive elements below.")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            // Different test playgrounds based on the feature
            Group {
                switch feature.name {
                case "VoiceOver":
                    VoiceOverTestView(color: feature.color)
                case "Voice Control":
                    VoiceControlTestView(color: feature.color)
                case "Larger Text":
                    LargerTextTestView(color: feature.color)
                case "Dark Interface":
                    DarkInterfaceTestView(color: feature.color)
                case "Differentiate Without Color Alone":
                    DifferentiateColorTestView(color: feature.color)
                case "Sufficient Contrast":
                    ContrastTestView(color: feature.color)
                case "Reduced Motion":
                    ReducedMotionTestView(color: feature.color)
                case "Captions":
                    CaptionsTestView(color: feature.color)
                case "Audio Descriptions":
                    AudioDescriptionsTestView(color: feature.color)
                default:
                    GenericTestView(color: feature.color)
                }
            }
        }
    }
}

// MARK: - VoiceOver Test
struct VoiceOverTestView: View {
    let color: Color
    @State private var counter = 0
    @State private var isLiked = false
    @State private var sliderValue = 50.0

    var body: some View {
        VStack(spacing: 16) {
            Text("Enable VoiceOver (triple-click side button) and try navigating these elements by swiping right/left. Double-tap to activate.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding()
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            // Counter Button
            HStack {
                Button(action: {
                    counter += 1
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                        Text("Add Item")
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(color)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .accessibilityLabel("Add item button")
                .accessibilityHint("Double tap to add an item to the counter")
                .accessibilityValue("Current count: \(counter) items")

                Text("\(counter)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(color)
                    .frame(width: 60)
                    .accessibilityLabel("Item count")
                    .accessibilityValue("\(counter) items")
            }

            // Like Button with State
            Button(action: {
                isLiked.toggle()
            }) {
                HStack {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .font(.title3)
                    Text(isLiked ? "Liked" : "Like")
                        .fontWeight(.semibold)
                }
                .foregroundStyle(isLiked ? .white : color)
                .padding()
                .frame(maxWidth: .infinity)
                .background(isLiked ? color : Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(color, lineWidth: 2)
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .accessibilityLabel(isLiked ? "Unlike" : "Like")
            .accessibilityHint("Double tap to \(isLiked ? "remove like" : "add like")")
            .accessibilityValue(isLiked ? "Liked" : "Not liked")

            // Image with Description
            VStack(spacing: 8) {
                Image(systemName: "sun.max.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(color)
                    .accessibilityLabel("Weather icon")
                    .accessibilityHint("Sunny weather, 75 degrees fahrenheit")

                Text("Weather Icon")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.secondary.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Weather display")
            .accessibilityValue("Sunny, 75 degrees fahrenheit")

            // Slider with Value
            VStack(alignment: .leading, spacing: 8) {
                Text("Volume")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Slider(value: $sliderValue, in: 0...100)
                    .tint(color)
                    .accessibilityLabel("Volume slider")
                    .accessibilityValue("\(Int(sliderValue)) percent")
                    .accessibilityHint("Swipe up or down to adjust volume")

                Text("\(Int(sliderValue))%")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .accessibilityHidden(true)
            }
            .padding()
            .background(Color.secondary.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding()
        .background(Color.secondary.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: - Voice Control Test
struct VoiceControlTestView: View {
    let color: Color
    @State private var feedback = "Waiting for voice command..."
    @State private var likeCount = 0
    @State private var isToggled = false
    @State private var textInput = ""
    @State private var selectedOption = "Option 1"
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    var isAccessibilitySize: Bool {
        dynamicTypeSize >= .accessibility1
    }

    let options = ["Option 1", "Option 2", "Option 3"]

    var body: some View {
        VStack(spacing: 16) {
            // Instructions - hide at accessibility sizes
            if !isAccessibilitySize {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Voice Control Commands to Try:")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)

                    VStack(alignment: .leading, spacing: 4) {
                        Label("\"Show names\" - See button labels", systemImage: "tag")
                        Label("\"Show numbers\" - See item numbers", systemImage: "number")
                        Label("\"Show grid\" - Show precise tap grid", systemImage: "grid")
                        Label("\"Tap [name]\" - Tap any button", systemImage: "hand.tap")
                        Label("\"Type [text]\" - Dictate text", systemImage: "text.cursor")
                    }
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            // Feedback display
            Text(feedback)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(color)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity)
                .padding()
                .background(color.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            // Interactive buttons - stack vertically at accessibility sizes
            if isAccessibilitySize {
                VStack(spacing: 12) {
                    Button("Like") {
                        likeCount += 1
                        feedback = "Liked! Count: \(likeCount)"
                    }
                    .foregroundStyle(.white)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.pink)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    Button("Share") {
                        feedback = "Share button activated!"
                    }
                    .foregroundStyle(.white)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    Button("Save") {
                        feedback = "Item saved!"
                    }
                    .foregroundStyle(.white)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            } else {
                HStack(spacing: 12) {
                    Button("Like") {
                        likeCount += 1
                        feedback = "Liked! Count: \(likeCount)"
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.pink)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    Button("Share") {
                        feedback = "Share button activated!"
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    Button("Save") {
                        feedback = "Item saved!"
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }

            // Toggle control
            HStack {
                Text("Notifications")
                    .font(.body)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                Toggle("", isOn: $isToggled)
                    .labelsHidden()
                    .onChange(of: isToggled) { _, newValue in
                        feedback = newValue ? "Notifications ON" : "Notifications OFF"
                    }
            }
            .padding()
            .background(Color.secondary.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10))

            // Text input field - hide label at accessibility sizes
            VStack(alignment: .leading, spacing: 8) {
                if !isAccessibilitySize {
                    Text("Say: \"Type your message\"")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                TextField("Tap or speak to type", text: $textInput)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: textInput) { _, newValue in
                        if !newValue.isEmpty {
                            feedback = "Text entered: \(newValue)"
                        }
                    }
            }

            // Selection buttons
            VStack(alignment: .leading, spacing: 8) {
                if !isAccessibilitySize {
                    Text("Choose an option:")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                // Stack vertically at accessibility sizes
                if isAccessibilitySize {
                    VStack(spacing: 8) {
                        ForEach(options, id: \.self) { option in
                            Button(option) {
                                selectedOption = option
                                feedback = "Selected: \(option)"
                            }
                            .font(.body)
                            .foregroundStyle(selectedOption == option ? .white : color)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .background(selectedOption == option ? color : Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(color, lineWidth: 1.5)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                } else {
                    HStack(spacing: 8) {
                        ForEach(options, id: \.self) { option in
                            Button(option) {
                                selectedOption = option
                                feedback = "Selected: \(option)"
                            }
                            .font(.caption)
                            .foregroundStyle(selectedOption == option ? .white : color)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(selectedOption == option ? color : Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(color, lineWidth: 1.5)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                }
            }

            // Action buttons - stack vertically at accessibility sizes
            if isAccessibilitySize {
                VStack(spacing: 12) {
                    Button("Reset") {
                        likeCount = 0
                        textInput = ""
                        selectedOption = "Option 1"
                        isToggled = false
                        feedback = "Everything reset!"
                    }
                    .foregroundStyle(color)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(color, lineWidth: 2)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    Button("Confirm") {
                        feedback = "Action confirmed! ✓"
                    }
                    .foregroundStyle(.white)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(color)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            } else {
                HStack(spacing: 12) {
                    Button("Reset") {
                        likeCount = 0
                        textInput = ""
                        selectedOption = "Option 1"
                        isToggled = false
                        feedback = "Everything reset!"
                    }
                    .foregroundStyle(color)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(color, lineWidth: 2)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    Button("Confirm") {
                        feedback = "Action confirmed! ✓"
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(color)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: - Larger Text Test
struct LargerTextTestView: View {
    let color: Color
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @State private var notificationCount = 3

    var isAccessibilitySize: Bool {
        dynamicTypeSize >= .accessibility1
    }

    var body: some View {
        VStack(spacing: 16) {
            // Instructions
            Text("Go to Settings > Accessibility > Display & Text Size > Larger Text. Watch elements scale!")
                .font(.caption)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
                .padding()
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            // Current size indicator
            VStack(spacing: 8) {
                HStack {
                    Image(systemName: "textformat.size")
                        .font(.title2)
                        .foregroundStyle(color)
                    Text("Size")
                        .font(.headline)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                    Spacer()
                }

                HStack {
                    Text(isAccessibilitySize ? "Access." : "Standard")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .foregroundStyle(isAccessibilitySize ? .green : .blue)
                    Spacer()
                    Text("\(String(describing: dynamicTypeSize))")
                        .font(.caption)
                        .minimumScaleFactor(0.3)
                        .lineLimit(1)
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
            .background(color.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            // Text style samples
            VStack(alignment: .leading, spacing: 12) {
                Text("Styles")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Large Title")
                        .font(.largeTitle)
                        .minimumScaleFactor(0.5)
                        .lineLimit(2)

                    Text("Title")
                        .font(.title)
                        .minimumScaleFactor(0.5)

                    Text("Headline")
                        .font(.headline)
                        .minimumScaleFactor(0.5)

                    Text("Body text scales smoothly")
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("Callout")
                        .font(.callout)
                        .minimumScaleFactor(0.5)

                    Text("Footnote")
                        .font(.footnote)
                        .minimumScaleFactor(0.5)

                    Text("Caption")
                        .font(.caption)
                        .minimumScaleFactor(0.5)
                }
            }
            .padding()
            .background(Color.secondary.opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            // Icons with text labels
            VStack(alignment: .leading, spacing: 12) {
                Text("Icons + Text")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)

                // Use VStack at accessibility sizes for better readability
                if isAccessibilitySize {
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(spacing: 12) {
                            Image(systemName: "heart.fill")
                                .font(.title)
                                .foregroundStyle(.red)
                            Text("Favorite")
                                .font(.body)
                                .fixedSize(horizontal: false, vertical: true)
                        }

                        HStack(spacing: 12) {
                            Image(systemName: "star.fill")
                                .font(.title)
                                .foregroundStyle(.yellow)
                            Text("Featured")
                                .font(.body)
                                .fixedSize(horizontal: false, vertical: true)
                        }

                        HStack(spacing: 12) {
                            Image(systemName: "bell.fill")
                                .font(.title)
                                .foregroundStyle(.orange)
                            Text("Alerts")
                                .font(.body)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    HStack(spacing: 16) {
                        VStack(spacing: 8) {
                            Image(systemName: "heart.fill")
                                .font(.title)
                                .foregroundStyle(.red)
                            Text("Favorite")
                                .font(.caption)
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                        }

                        VStack(spacing: 8) {
                            Image(systemName: "star.fill")
                                .font(.title)
                                .foregroundStyle(.yellow)
                            Text("Featured")
                                .font(.caption)
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                        }

                        VStack(spacing: 8) {
                            Image(systemName: "bell.fill")
                                .font(.title)
                                .foregroundStyle(.orange)
                            Text("Alerts")
                                .font(.caption)
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding()
            .background(Color.secondary.opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            // List items with icons
            VStack(alignment: .leading, spacing: 12) {
                Text("List Items")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)

                VStack(spacing: 8) {
                    // New Message item
                    if isAccessibilitySize {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("New Message")
                                .font(.body)
                                .fixedSize(horizontal: false, vertical: true)
                            HStack {
                                Text("5 unread")
                                    .font(.body)
                                    .foregroundStyle(.secondary)
                                    .fixedSize(horizontal: false, vertical: true)
                                Spacer()
                                Text("5")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(color)
                                    .foregroundStyle(.white)
                                    .clipShape(Capsule())
                            }
                        }
                    } else {
                        HStack(spacing: 12) {
                            Image(systemName: "envelope.fill")
                                .foregroundStyle(color)
                                .imageScale(.large)
                            VStack(alignment: .leading, spacing: 2) {
                                Text("New Message")
                                    .font(.body)
                                    .minimumScaleFactor(0.7)
                                    .lineLimit(1)
                                Text("5 unread")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .minimumScaleFactor(0.7)
                                    .lineLimit(1)
                            }
                            Spacer()
                            Text("5")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .minimumScaleFactor(0.5)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(color)
                                .foregroundStyle(.white)
                                .clipShape(Capsule())
                        }
                    }

                    Divider()

                    // Notifications item
                    if isAccessibilitySize {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Notifications")
                                .font(.body)
                                .fixedSize(horizontal: false, vertical: true)
                            Text("\(notificationCount) alerts")
                                .font(.body)
                                .foregroundStyle(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    } else {
                        HStack(spacing: 12) {
                            Image(systemName: "bell.badge.fill")
                                .foregroundStyle(color)
                                .imageScale(.large)
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Notifications")
                                    .font(.body)
                                    .minimumScaleFactor(0.7)
                                    .lineLimit(1)
                                Text("\(notificationCount) alerts")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .minimumScaleFactor(0.7)
                                    .lineLimit(1)
                            }
                            Spacer()
                        }
                    }
                }
            }
            .padding()
            .background(Color.secondary.opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            // Buttons with different sizes
            VStack(alignment: .leading, spacing: 12) {
                Text("Buttons")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)

                VStack(spacing: 8) {
                    Button(action: { notificationCount += 1 }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add Alert")
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .font(.body)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(color)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }

                    Button(action: { notificationCount = 0 }) {
                        HStack {
                            Image(systemName: "trash")
                            Text("Clear")
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .font(.body)
                        .foregroundStyle(color)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(color, lineWidth: 2)
                        )
                    }

                    // Switch to VStack at accessibility sizes
                    if isAccessibilitySize {
                        VStack(spacing: 8) {
                            Button("Cancel") {
                                notificationCount = 3
                            }
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.secondary.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 8))

                            Button("OK") {
                                notificationCount = 3
                            }
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(color)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    } else {
                        HStack(spacing: 8) {
                            Button("Cancel") {
                                notificationCount = 3
                            }
                            .font(.subheadline)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.secondary.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 8))

                            Button("OK") {
                                notificationCount = 3
                            }
                            .font(.subheadline)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(color)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                }
            }
            .padding()
            .background(Color.secondary.opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            // Multiline text wrapping
            VStack(alignment: .leading, spacing: 12) {
                Text("Text Wrap")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)

                Text("This shows how text wraps when you scale text size. Layout adapts to fit larger text while staying readable.")
                    .font(.body)
                    .foregroundStyle(.primary)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineSpacing(4)
            }
            .padding()
            .background(Color.secondary.opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding()
        .background(Color.secondary.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: - Dark Interface Test
struct DarkInterfaceTestView: View {
    let color: Color
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    var isAccessibilitySize: Bool {
        dynamicTypeSize >= .accessibility1
    }

    var body: some View {
        VStack(spacing: 16) {
            // Hide instructions at accessibility sizes to save space
            if !isAccessibilitySize {
                Text("Toggle Dark Mode in Settings > Display & Brightness to see all UI elements adapt instantly.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                    .background(Color.secondary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            // Current Mode Indicator
            HStack(spacing: 12) {
                // Hide icon at accessibility sizes
                if !isAccessibilitySize {
                    Image(systemName: colorScheme == .dark ? "moon.fill" : "sun.max.fill")
                        .font(.title)
                        .foregroundStyle(color)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(colorScheme == .dark ? "Dark Mode Active" : "Light Mode Active")
                        .font(.headline)
                        .fixedSize(horizontal: false, vertical: true)

                    // Hide subtitle at accessibility sizes
                    if !isAccessibilitySize {
                        Text("All elements adapt automatically")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                Spacer()
            }
            .padding()
            .background(Color.secondary.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            // Semantic Colors Section
            VStack(alignment: .leading, spacing: 8) {
                Text("Semantic Colors")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                VStack(spacing: 8) {
                    ColorRow(label: "Primary", colorStyle: .primary)
                    ColorRow(label: "Secondary", colorStyle: .secondary)
                    ColorRow(label: "Tertiary", colorStyle: .tertiary)
                }
            }

            // Background Layers
            VStack(alignment: .leading, spacing: 8) {
                Text("Background Layers")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)

                // Use VStack at accessibility sizes for better readability
                if isAccessibilitySize {
                    VStack(spacing: 12) {
                        VStack(alignment: .leading, spacing: 8) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(uiColor: .systemBackground))
                                .frame(height: 50)
                                .overlay(
                                    Text("Base")
                                        .font(.body)
                                        .fontWeight(.medium)
                                )
                            Text("Background")
                                .font(.body)
                                .foregroundStyle(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(uiColor: .secondarySystemBackground))
                                .frame(height: 50)
                                .overlay(
                                    Text("Card")
                                        .font(.body)
                                        .fontWeight(.medium)
                                )
                            Text("Secondary")
                                .font(.body)
                                .foregroundStyle(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(uiColor: .tertiarySystemBackground))
                                .frame(height: 50)
                                .overlay(
                                    Text("Fill")
                                        .font(.body)
                                        .fontWeight(.medium)
                                )
                            Text("Tertiary")
                                .font(.body)
                                .foregroundStyle(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                } else {
                    HStack(spacing: 8) {
                        VStack(spacing: 4) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(uiColor: .systemBackground))
                                .frame(height: 50)
                                .overlay(
                                    Text("Base")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                )
                            Text("Background")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }

                        VStack(spacing: 4) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(uiColor: .secondarySystemBackground))
                                .frame(height: 50)
                                .overlay(
                                    Text("Card")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                )
                            Text("Secondary")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }

                        VStack(spacing: 4) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(uiColor: .tertiarySystemBackground))
                                .frame(height: 50)
                                .overlay(
                                    Text("Fill")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                )
                            Text("Tertiary")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }

            // UI Elements
            VStack(alignment: .leading, spacing: 8) {
                Text("UI Elements")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)

                VStack(spacing: 8) {
                    // Button
                    Button(action: {}) {
                        HStack {
                            if !isAccessibilitySize {
                                Image(systemName: "star.fill")
                            }
                            Text("Accent Button")
                                .fontWeight(.semibold)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }

                    // Card
                    if isAccessibilitySize {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Card Title")
                                .font(.body)
                                .fontWeight(.semibold)
                                .fixedSize(horizontal: false, vertical: true)
                            Text("Subtitle")
                                .font(.body)
                                .foregroundStyle(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color(uiColor: .secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    } else {
                        HStack {
                            Image(systemName: "photo")
                                .font(.title2)
                                .foregroundStyle(color)
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Card Title")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Text("Subtitle adapts to color scheme")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundStyle(.tertiary)
                        }
                        .padding()
                        .background(Color(uiColor: .secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }

                    // Grouped Cells
                    VStack(spacing: 1) {
                        ListRowDemo(icon: "bell.fill", title: "Notifications", value: "On")
                        Divider()
                        ListRowDemo(icon: "lock.fill", title: "Privacy", value: "Enabled")
                    }
                    .background(Color(uiColor: .secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }

            // Color Contrast Info
            HStack(spacing: 8) {
                if !isAccessibilitySize {
                    Image(systemName: "info.circle.fill")
                        .foregroundStyle(color)
                }
                Text(colorScheme == .dark ?
                    "Dark mode reduces glare and eye strain in low-light environments" :
                    "Light mode provides better visibility in bright environments")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding()
            .background(Color.secondary.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding()
        .background(Color.secondary.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct ColorRow<S: ShapeStyle>: View {
    let label: String
    let colorStyle: S
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    var isAccessibilitySize: Bool {
        dynamicTypeSize >= .accessibility1
    }

    var body: some View {
        if isAccessibilitySize {
            VStack(alignment: .leading, spacing: 8) {
                Text(label)
                    .font(.body)
                    .fixedSize(horizontal: false, vertical: true)

                Rectangle()
                    .fill(colorStyle)
                    .frame(height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
        } else {
            HStack {
                Text(label)
                    .font(.caption)
                    .frame(width: 70, alignment: .leading)

                Rectangle()
                    .fill(colorStyle)
                    .frame(height: 30)
                    .clipShape(RoundedRectangle(cornerRadius: 6))

                Text("Text adapts")
                    .font(.caption)
                    .foregroundStyle(colorStyle)
            }
        }
    }
}

struct ListRowDemo: View {
    let icon: String
    let title: String
    let value: String
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    var isAccessibilitySize: Bool {
        dynamicTypeSize >= .accessibility1
    }

    var body: some View {
        if isAccessibilitySize {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.body)
                    .fixedSize(horizontal: false, vertical: true)
                Text(value)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.vertical, 12)
        } else {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(.blue)
                    .frame(width: 24)
                Text(title)
                    .font(.subheadline)
                Spacer()
                Text(value)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
    }
}

// MARK: - Differentiate Without Color Test
struct DifferentiateColorTestView: View {
    let color: Color
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @State private var selectedOption = "Option 1"
    @State private var email = "invalid-email"

    var isAccessibilitySize: Bool {
        dynamicTypeSize >= .accessibility1
    }

    var body: some View {
        VStack(spacing: 16) {
            // Hide instructions at accessibility sizes
            if !isAccessibilitySize {
                Text("Toggle Differentiate Without Color in Accessibility > Display & Text Size to see icons and labels appear.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                    .background(Color.secondary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            // Feature Status
            HStack(spacing: 12) {
                // Hide icon at accessibility sizes
                if !isAccessibilitySize {
                    Image(systemName: differentiateWithoutColor ? "checkmark.circle.fill" : "circle")
                        .font(.title)
                        .foregroundStyle(color)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(differentiateWithoutColor ? "Feature Active" : "Feature Inactive")
                        .font(.headline)
                        .fixedSize(horizontal: false, vertical: true)

                    // Hide subtitle at accessibility sizes
                    if !isAccessibilitySize {
                        Text(differentiateWithoutColor ? "Icons & text shown" : "Color-only mode")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                Spacer()
            }
            .padding()
            .background(Color.secondary.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            // Status Indicators
            VStack(alignment: .leading, spacing: 8) {
                Text("Status Indicators")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)

                // Use VStack at accessibility sizes
                if isAccessibilitySize {
                    VStack(spacing: 12) {
                        StatusIndicator(
                            status: "Success",
                            color: .green,
                            icon: "checkmark.circle.fill",
                            showIcon: differentiateWithoutColor
                        )

                        StatusIndicator(
                            status: "Warning",
                            color: .orange,
                            icon: "exclamationmark.triangle.fill",
                            showIcon: differentiateWithoutColor
                        )

                        StatusIndicator(
                            status: "Error",
                            color: .red,
                            icon: "xmark.circle.fill",
                            showIcon: differentiateWithoutColor
                        )
                    }
                } else {
                    HStack(spacing: 8) {
                        StatusIndicator(
                            status: "Success",
                            color: .green,
                            icon: "checkmark.circle.fill",
                            showIcon: differentiateWithoutColor
                        )

                        StatusIndicator(
                            status: "Warning",
                            color: .orange,
                            icon: "exclamationmark.triangle.fill",
                            showIcon: differentiateWithoutColor
                        )

                        StatusIndicator(
                            status: "Error",
                            color: .red,
                            icon: "xmark.circle.fill",
                            showIcon: differentiateWithoutColor
                        )
                    }
                }
            }

            // Form Validation
            VStack(alignment: .leading, spacing: 8) {
                Text("Form Validation")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)

                VStack(spacing: 8) {
                    // Valid field
                    if isAccessibilitySize {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Name")
                                .font(.body)
                                .fixedSize(horizontal: false, vertical: true)
                            HStack {
                                Text("John Doe")
                                    .font(.body)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(8)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.green.opacity(0.1))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(Color.green, lineWidth: differentiateWithoutColor ? 2 : 1)
                                    )
                                if differentiateWithoutColor {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.title2)
                                        .foregroundStyle(.green)
                                }
                            }
                        }
                    } else {
                        HStack {
                            Text("Name")
                                .font(.subheadline)
                                .frame(width: 60, alignment: .leading)
                            Text("John Doe")
                                .font(.subheadline)
                                .padding(8)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.green.opacity(0.1))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.green, lineWidth: differentiateWithoutColor ? 2 : 1)
                                )
                            if differentiateWithoutColor {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(.green)
                            }
                        }
                    }

                    // Invalid field
                    if isAccessibilitySize {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email")
                                .font(.body)
                                .fixedSize(horizontal: false, vertical: true)
                            HStack {
                                Text(email)
                                    .font(.body)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(8)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.red.opacity(0.1))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(Color.red, lineWidth: differentiateWithoutColor ? 2 : 1)
                                    )
                                if differentiateWithoutColor {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.title2)
                                        .foregroundStyle(.red)
                                }
                            }

                            if differentiateWithoutColor {
                                HStack(spacing: 4) {
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .font(.body)
                                        .foregroundStyle(.red)
                                    Text("Invalid email")
                                        .font(.body)
                                        .foregroundStyle(.red)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                        }
                    } else {
                        HStack {
                            Text("Email")
                                .font(.subheadline)
                                .frame(width: 60, alignment: .leading)
                            Text(email)
                                .font(.subheadline)
                                .padding(8)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.red.opacity(0.1))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.red, lineWidth: differentiateWithoutColor ? 2 : 1)
                                )
                            if differentiateWithoutColor {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.red)
                            }
                        }

                        if differentiateWithoutColor {
                            HStack(spacing: 4) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .font(.caption)
                                    .foregroundStyle(.red)
                                Text("Invalid email format")
                                    .font(.caption)
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                }
            }

            // Selection States
            VStack(alignment: .leading, spacing: 8) {
                Text("Selection States")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)

                // Use VStack at accessibility sizes
                if isAccessibilitySize {
                    VStack(spacing: 8) {
                        ForEach(["Option 1", "Option 2", "Option 3"], id: \.self) { option in
                            Button(action: {
                                selectedOption = option
                            }) {
                                HStack(spacing: 8) {
                                    if differentiateWithoutColor && selectedOption == option {
                                        Image(systemName: "checkmark")
                                            .font(.body)
                                            .fontWeight(.bold)
                                    }
                                    Text(option)
                                        .font(.body)
                                        .fontWeight(selectedOption == option ? .bold : .regular)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(selectedOption == option ? color.opacity(0.2) : Color.clear)
                                .foregroundStyle(selectedOption == option ? color : .primary)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(
                                            selectedOption == option ? color : Color.gray.opacity(0.3),
                                            lineWidth: differentiateWithoutColor && selectedOption == option ? 2 : 1
                                        )
                                )
                            }
                        }
                    }
                } else {
                    HStack(spacing: 8) {
                        ForEach(["Option 1", "Option 2", "Option 3"], id: \.self) { option in
                            Button(action: {
                                selectedOption = option
                            }) {
                                HStack(spacing: 6) {
                                    if differentiateWithoutColor && selectedOption == option {
                                        Image(systemName: "checkmark")
                                            .font(.caption)
                                            .fontWeight(.bold)
                                    }
                                    Text(option.replacingOccurrences(of: "Option ", with: ""))
                                        .font(.caption)
                                        .fontWeight(selectedOption == option ? .bold : .regular)
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .frame(maxWidth: .infinity)
                                .background(selectedOption == option ? color.opacity(0.2) : Color.clear)
                                .foregroundStyle(selectedOption == option ? color : .primary)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(
                                            selectedOption == option ? color : Color.gray.opacity(0.3),
                                            lineWidth: differentiateWithoutColor && selectedOption == option ? 2 : 1
                                        )
                                )
                            }
                        }
                    }
                }
            }

            // Progress/Data Visualization
            VStack(alignment: .leading, spacing: 8) {
                Text("Progress Indicators")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)

                VStack(spacing: isAccessibilitySize ? 16 : 8) {
                    ProgressBarDemo(
                        label: "Storage",
                        value: 0.75,
                        color: .blue,
                        showLabel: differentiateWithoutColor
                    )
                    ProgressBarDemo(
                        label: "Memory",
                        value: 0.45,
                        color: .green,
                        showLabel: differentiateWithoutColor
                    )
                    ProgressBarDemo(
                        label: "CPU",
                        value: 0.90,
                        color: .red,
                        showLabel: differentiateWithoutColor
                    )
                }
            }

            // Tags/Badges
            VStack(alignment: .leading, spacing: 8) {
                Text("Tags & Badges")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)

                // Use VStack at accessibility sizes
                if isAccessibilitySize {
                    VStack(spacing: 12) {
                        TagBadge(
                            text: "Active",
                            icon: "checkmark.circle.fill",
                            color: .green,
                            showIcon: differentiateWithoutColor
                        )
                        TagBadge(
                            text: "Pending",
                            icon: "clock.fill",
                            color: .orange,
                            showIcon: differentiateWithoutColor
                        )
                        TagBadge(
                            text: "Inactive",
                            icon: "xmark.circle.fill",
                            color: .gray,
                            showIcon: differentiateWithoutColor
                        )
                    }
                } else {
                    HStack(spacing: 8) {
                        TagBadge(
                            text: "Active",
                            icon: "checkmark.circle.fill",
                            color: .green,
                            showIcon: differentiateWithoutColor
                        )
                        TagBadge(
                            text: "Pending",
                            icon: "clock.fill",
                            color: .orange,
                            showIcon: differentiateWithoutColor
                        )
                        TagBadge(
                            text: "Inactive",
                            icon: "xmark.circle.fill",
                            color: .gray,
                            showIcon: differentiateWithoutColor
                        )
                    }
                }
            }

            // Info - hide at accessibility sizes to save space
            if !isAccessibilitySize {
                HStack(spacing: 8) {
                    Image(systemName: "info.circle.fill")
                        .foregroundStyle(color)
                    Text("Never rely on color alone to convey information - always provide shapes, icons, or text labels")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct StatusIndicator: View {
    let status: String
    let color: Color
    let icon: String
    let showIcon: Bool
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    var isAccessibilitySize: Bool {
        dynamicTypeSize >= .accessibility1
    }

    var body: some View {
        VStack(spacing: 8) {
            if showIcon {
                Image(systemName: icon)
                    .font(isAccessibilitySize ? .title : .title2)
                    .foregroundStyle(color)
            } else {
                Circle()
                    .fill(color)
                    .frame(width: isAccessibilitySize ? 40 : 28, height: isAccessibilitySize ? 40 : 28)
            }

            Text(status)
                .font(isAccessibilitySize ? .body : .caption)
                .fontWeight(.semibold)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, isAccessibilitySize ? 16 : 10)
        .padding(.horizontal, isAccessibilitySize ? 12 : 8)
        .background(color.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct ProgressBarDemo: View {
    let label: String
    let value: Double
    let color: Color
    let showLabel: Bool
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    var isAccessibilitySize: Bool {
        dynamicTypeSize >= .accessibility1
    }

    var body: some View {
        if isAccessibilitySize {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(label)
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)

                    Spacer()

                    if showLabel {
                        Text("\(Int(value * 100))%")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundStyle(color)
                    }
                }

                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray.opacity(0.2))

                        RoundedRectangle(cornerRadius: 4)
                            .fill(color)
                            .frame(width: geometry.size.width * value)
                    }
                }
                .frame(height: 12)
            }
        } else {
            HStack(spacing: 8) {
                Text(label)
                    .font(.caption)
                    .frame(width: 50, alignment: .leading)

                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray.opacity(0.2))

                        RoundedRectangle(cornerRadius: 4)
                            .fill(color)
                            .frame(width: geometry.size.width * value)
                    }
                }
                .frame(height: 8)

                if showLabel {
                    Text("\(Int(value * 100))%")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(color)
                        .frame(width: 35, alignment: .trailing)
                }
            }
        }
    }
}

struct TagBadge: View {
    let text: String
    let icon: String
    let color: Color
    let showIcon: Bool
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    var isAccessibilitySize: Bool {
        dynamicTypeSize >= .accessibility1
    }

    var body: some View {
        HStack(spacing: isAccessibilitySize ? 8 : 4) {
            if showIcon {
                Image(systemName: icon)
                    .font(isAccessibilitySize ? .body : .caption2)
            }
            Text(text)
                .font(isAccessibilitySize ? .body : .caption2)
                .fontWeight(.medium)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, isAccessibilitySize ? 16 : 10)
        .padding(.vertical, isAccessibilitySize ? 12 : 5)
        .frame(maxWidth: isAccessibilitySize ? .infinity : nil)
        .background(color.opacity(0.2))
        .foregroundStyle(color)
        .clipShape(Capsule())
    }
}

// MARK: - Contrast Test
struct ContrastTestView: View {
    let color: Color
    @Environment(\.colorSchemeContrast) var contrast
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    var isAccessibilitySize: Bool {
        dynamicTypeSize >= .accessibility1
    }

    var body: some View {
        VStack(spacing: 16) {
            // Hide instructions at accessibility sizes
            if !isAccessibilitySize {
                Text("Toggle Increase Contrast in Accessibility > Display & Text Size to see enhanced contrast ratios.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                    .background(Color.secondary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            // Feature Status
            HStack(spacing: 12) {
                // Hide icon at accessibility sizes
                if !isAccessibilitySize {
                    Image(systemName: contrast == .increased ? "circle.lefthalf.filled" : "circle")
                        .font(.title)
                        .foregroundStyle(color)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(contrast == .increased ? "Increased Contrast" : "Standard Contrast")
                        .font(.headline)
                        .fixedSize(horizontal: false, vertical: true)

                    // Hide subtitle at accessibility sizes
                    if !isAccessibilitySize {
                        Text(contrast == .increased ? "Enhanced visibility active" : "Normal mode")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                Spacer()
            }
            .padding()
            .background(Color.secondary.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            // Text Contrast Examples
            VStack(alignment: .leading, spacing: 8) {
                Text("Text Contrast")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)

                VStack(spacing: isAccessibilitySize ? 16 : 12) {
                    TextContrastRow(
                        label: "Primary",
                        textStyle: .primary,
                        contrast: contrast
                    )
                    TextContrastRow(
                        label: "Secondary",
                        textStyle: .secondary,
                        contrast: contrast
                    )
                    TextContrastRow(
                        label: "Tertiary",
                        textStyle: .tertiary,
                        contrast: contrast
                    )
                }
                .padding()
                .background(Color(uiColor: .systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }

            // Button Contrast
            VStack(alignment: .leading, spacing: 8) {
                Text("Button & Interactive Elements")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)

                VStack(spacing: 8) {
                    Button(action: {}) {
                        HStack {
                            if !isAccessibilitySize {
                                Image(systemName: "star.fill")
                            }
                            Text("Primary Button")
                                .fontWeight(.semibold)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(color)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }

                    Button(action: {}) {
                        HStack {
                            if !isAccessibilitySize {
                                Image(systemName: "heart")
                            }
                            Text("Secondary Button")
                                .fontWeight(.semibold)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(color.opacity(contrast == .increased ? 0.2 : 0.1))
                        .foregroundStyle(color)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(color, lineWidth: contrast == .increased ? 2 : 1)
                        )
                    }
                }
            }

            // Background Layers
            VStack(alignment: .leading, spacing: 8) {
                Text("Background Layers")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)

                VStack(spacing: isAccessibilitySize ? 12 : 8) {
                    BackgroundLayerDemo(
                        title: "Primary",
                        backgroundColor: Color(uiColor: .systemBackground),
                        contrast: contrast
                    )
                    BackgroundLayerDemo(
                        title: "Secondary",
                        backgroundColor: Color(uiColor: .secondarySystemBackground),
                        contrast: contrast
                    )
                    BackgroundLayerDemo(
                        title: "Tertiary",
                        backgroundColor: Color(uiColor: .tertiarySystemBackground),
                        contrast: contrast
                    )
                }
            }

            // Separators & Borders - hide at accessibility sizes
            if !isAccessibilitySize {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Separators & Borders")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    VStack(spacing: 1) {
                        HStack {
                            Text("Item 1")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundStyle(.tertiary)
                        }
                        .padding()
                        .background(Color(uiColor: .secondarySystemBackground))

                        Divider()
                            .background(Color.primary.opacity(contrast == .increased ? 0.3 : 0.2))

                        HStack {
                            Text("Item 2")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundStyle(.tertiary)
                        }
                        .padding()
                        .background(Color(uiColor: .secondarySystemBackground))

                        Divider()
                            .background(Color.primary.opacity(contrast == .increased ? 0.3 : 0.2))

                        HStack {
                            Text("Item 3")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundStyle(.tertiary)
                        }
                        .padding()
                        .background(Color(uiColor: .secondarySystemBackground))
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }

            // Icons & Symbols
            VStack(alignment: .leading, spacing: 8) {
                Text("Icons & Symbols")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)

                // Use VStack at accessibility sizes
                if isAccessibilitySize {
                    VStack(spacing: 16) {
                        IconContrastDemo(icon: "house.fill", label: "Home", color: .blue, contrast: contrast)
                        IconContrastDemo(icon: "bell.fill", label: "Alerts", color: .orange, contrast: contrast)
                        IconContrastDemo(icon: "person.fill", label: "Profile", color: .purple, contrast: contrast)
                        IconContrastDemo(icon: "gear", label: "Settings", color: .gray, contrast: contrast)
                    }
                } else {
                    HStack(spacing: 16) {
                        IconContrastDemo(icon: "house.fill", label: "Home", color: .blue, contrast: contrast)
                        IconContrastDemo(icon: "bell.fill", label: "Alerts", color: .orange, contrast: contrast)
                        IconContrastDemo(icon: "person.fill", label: "Profile", color: .purple, contrast: contrast)
                        IconContrastDemo(icon: "gear", label: "Settings", color: .gray, contrast: contrast)
                    }
                }
            }

            // Card Example
            VStack(alignment: .leading, spacing: 8) {
                Text("Card Components")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)

                if isAccessibilitySize {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Card Title")
                            .font(.headline)
                            .fixedSize(horizontal: false, vertical: true)
                        Text("Subtitle")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                        Text("Additional details")
                            .font(.caption)
                            .foregroundStyle(.tertiary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(contrast == .increased ? 0.3 : 0.15), lineWidth: 1)
                    )
                } else {
                    HStack(spacing: 12) {
                        Image(systemName: "photo.fill")
                            .font(.largeTitle)
                            .foregroundStyle(color)
                            .frame(width: 60, height: 60)
                            .background(color.opacity(contrast == .increased ? 0.2 : 0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Card Title")
                                .font(.headline)
                            Text("Subtitle with secondary text")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Text("Additional details in tertiary")
                                .font(.caption)
                                .foregroundStyle(.tertiary)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(contrast == .increased ? 0.3 : 0.15), lineWidth: 1)
                    )
                }
            }

            // WCAG Info
            HStack(spacing: 8) {
                if !isAccessibilitySize {
                    Image(systemName: "info.circle.fill")
                        .foregroundStyle(color)
                }
                Text(contrast == .increased ?
                    "Enhanced contrast improves readability for users with low vision" :
                    "Standard contrast follows WCAG AA guidelines (4.5:1 for text)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding()
            .background(Color.secondary.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding()
        .background(Color.secondary.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct TextContrastRow<S: ShapeStyle>: View {
    let label: String
    let textStyle: S
    let contrast: ColorSchemeContrast
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    var isAccessibilitySize: Bool {
        dynamicTypeSize >= .accessibility1
    }

    var body: some View {
        if isAccessibilitySize {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(label)
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)

                    Spacer()

                    Text(contrast == .increased ? "AAA" : "AA")
                        .font(.body)
                        .fontWeight(.bold)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(contrast == .increased ? Color.green.opacity(0.2) : Color.blue.opacity(0.2))
                        .foregroundStyle(contrast == .increased ? .green : .blue)
                        .clipShape(Capsule())
                }

                Text("The quick brown fox")
                    .font(.body)
                    .foregroundStyle(textStyle)
                    .fixedSize(horizontal: false, vertical: true)
            }
        } else {
            HStack {
                Text(label)
                    .font(.caption)
                    .frame(width: 70, alignment: .leading)

                Text("The quick brown fox jumps")
                    .font(.subheadline)
                    .foregroundStyle(textStyle)

                Spacer()

                Text(contrast == .increased ? "AAA" : "AA")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(contrast == .increased ? Color.green.opacity(0.2) : Color.blue.opacity(0.2))
                    .foregroundStyle(contrast == .increased ? .green : .blue)
                    .clipShape(Capsule())
            }
        }
    }
}

struct BackgroundLayerDemo: View {
    let title: String
    let backgroundColor: Color
    let contrast: ColorSchemeContrast
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    var isAccessibilitySize: Bool {
        dynamicTypeSize >= .accessibility1
    }

    var body: some View {
        VStack(alignment: .leading, spacing: isAccessibilitySize ? 8 : 4) {
            Text(title)
                .font(isAccessibilitySize ? .body : .caption)
                .fontWeight(.medium)
                .fixedSize(horizontal: false, vertical: true)

            if !isAccessibilitySize {
                Text("Contrast: \(contrast == .increased ? "Enhanced" : "Standard")")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(isAccessibilitySize ? 16 : 12)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(contrast == .increased ? 0.4 : 0.2), lineWidth: 1)
        )
    }
}

struct IconContrastDemo: View {
    let icon: String
    let label: String
    let color: Color
    let contrast: ColorSchemeContrast
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    var isAccessibilitySize: Bool {
        dynamicTypeSize >= .accessibility1
    }

    var body: some View {
        if isAccessibilitySize {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title)
                    .foregroundStyle(color)
                    .frame(width: 60, height: 60)
                    .background(color.opacity(contrast == .increased ? 0.2 : 0.1))
                    .clipShape(Circle())

                Text(label)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)

                Spacer()
            }
        } else {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(color)
                    .frame(width: 50, height: 50)
                    .background(color.opacity(contrast == .increased ? 0.2 : 0.1))
                    .clipShape(Circle())

                Text(label)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

// MARK: - Reduced Motion Test
struct ReducedMotionTestView: View {
    let color: Color
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @State private var isAnimating = false
    @State private var showCard = true
    @State private var animationTask: Task<Void, Never>? = nil
    @State private var isRunning = false
    @State private var remainingTime = 0

    var isAccessibilitySize: Bool {
        dynamicTypeSize >= .accessibility1
    }

    var body: some View {
        VStack(spacing: 16) {
            // Hide instructions at accessibility sizes
            if !isAccessibilitySize {
                Text("Toggle Reduce Motion in Accessibility > Motion to see animations adapt or disable.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                    .background(Color.secondary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            // Feature Status
            HStack(spacing: 12) {
                // Hide icon at accessibility sizes
                if !isAccessibilitySize {
                    Image(systemName: reduceMotion ? "checkmark.circle.fill" : "circle")
                        .font(.title)
                        .foregroundStyle(color)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(reduceMotion ? "Reduced Motion Active" : "Animations Enabled")
                        .font(.headline)
                        .fixedSize(horizontal: false, vertical: true)

                    // Hide subtitle at accessibility sizes
                    if !isAccessibilitySize {
                        Text(reduceMotion ? "Minimal animations" : "Full animations")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                Spacer()
            }
            .padding()
            .background(Color.secondary.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Button(action: {
                // Ignore if already running
                guard !isRunning else { return }

                isRunning = true
                remainingTime = 30

                // Start countdown timer (updates every second)
                let timerTask = Task {
                    let startTime = Date()

                    while Date().timeIntervalSince(startTime) < 30 {
                        remainingTime = max(0, 30 - Int(Date().timeIntervalSince(startTime)))
                        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
                    }
                }

                // Start looping animations for 30 seconds
                animationTask = Task {
                    let startTime = Date()

                    while Date().timeIntervalSince(startTime) < 30 {
                        // Toggle animations
                        isAnimating.toggle()

                        // Wait before next toggle (creates loop effect)
                        try? await Task.sleep(nanoseconds: 1_500_000_000) // 1.5 seconds

                        // Toggle card
                        showCard.toggle()

                        try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
                    }

                    // Wait for timer to finish
                    await timerTask.value

                    // Reset everything after 30 seconds
                    isAnimating = false
                    showCard = true
                    remainingTime = 0
                    isRunning = false
                }
            }) {
                HStack {
                    // Hide icon at accessibility sizes
                    if !isAccessibilitySize {
                        Image(systemName: isRunning ? "clock.fill" : "play.fill")
                    }
                    if isRunning {
                        Text("Running (\(remainingTime)s)")
                            .fontWeight(.semibold)
                            .fixedSize(horizontal: false, vertical: true)
                    } else {
                        Text("Trigger Animations")
                            .fontWeight(.semibold)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(isRunning ? Color.gray : color)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .opacity(isRunning ? 0.6 : 1.0)
            }
            .disabled(isRunning)

            // Movement Animation
            VStack(alignment: .leading, spacing: 8) {
                Text("Movement & Spring")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)

                HStack {
                    Spacer()
                    Circle()
                        .fill(color)
                        .frame(width: 50, height: 50)
                        .offset(x: isAnimating ? 80 : -80)
                        .animation(reduceMotion ? .none : .spring(duration: 0.8, bounce: 0.3), value: isAnimating)
                    Spacer()
                }
                .frame(height: 60)
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))

                // Hide description at accessibility sizes
                if !isAccessibilitySize {
                    Text(reduceMotion ? "Instant position change" : "Bouncy spring animation")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            // Scale & Pulse Animation
            VStack(alignment: .leading, spacing: 8) {
                Text("Scale & Pulse")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)

                HStack {
                    Spacer()
                    Image(systemName: "heart.fill")
                        .font(.system(size: 40))
                        .foregroundStyle(.red)
                        .scaleEffect(isAnimating ? 1.3 : 1.0)
                        .animation(reduceMotion ? .none : .easeInOut(duration: 0.6).repeatCount(3, autoreverses: true), value: isAnimating)
                    Spacer()
                }
                .frame(height: 70)
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))

                // Hide description at accessibility sizes
                if !isAccessibilitySize {
                    Text(reduceMotion ? "No scaling animation" : "Pulsing scale effect")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            // Rotation Animation
            VStack(alignment: .leading, spacing: 8) {
                Text("Rotation")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)

                HStack {
                    Spacer()
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 40))
                        .foregroundStyle(color)
                        .rotationEffect(.degrees(isAnimating ? 360 : 0))
                        .animation(reduceMotion ? .none : .linear(duration: 1.0), value: isAnimating)
                    Spacer()
                }
                .frame(height: 70)
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))

                // Hide description at accessibility sizes
                if !isAccessibilitySize {
                    Text(reduceMotion ? "No rotation" : "360° rotation")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            // Opacity Transition (Crossfade)
            VStack(alignment: .leading, spacing: 8) {
                Text("Opacity Transition")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)

                ZStack {
                    if showCard {
                        VStack(spacing: 8) {
                            // Hide icon at accessibility sizes
                            if !isAccessibilitySize {
                                Image(systemName: "sun.max.fill")
                                    .font(.largeTitle)
                                    .foregroundStyle(.orange)
                            }
                            Text("Day Mode")
                                .font(isAccessibilitySize ? .body : .caption)
                                .fontWeight(.semibold)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .transition(reduceMotion ? .identity : .opacity)
                    } else {
                        VStack(spacing: 8) {
                            // Hide icon at accessibility sizes
                            if !isAccessibilitySize {
                                Image(systemName: "moon.stars.fill")
                                    .font(.largeTitle)
                                    .foregroundStyle(.blue)
                            }
                            Text("Night Mode")
                                .font(isAccessibilitySize ? .body : .caption)
                                .fontWeight(.semibold)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .transition(reduceMotion ? .identity : .opacity)
                    }
                }
                .frame(height: isAccessibilitySize ? 80 : 100)
                .onTapGesture {
                    withAnimation(reduceMotion ? .none : .easeInOut(duration: 0.4)) {
                        showCard.toggle()
                    }
                }

                // Hide description at accessibility sizes
                if !isAccessibilitySize {
                    Text(reduceMotion ? "Instant switch" : "Smooth crossfade")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            // Info - hide at accessibility sizes
            if !isAccessibilitySize {
                HStack(spacing: 8) {
                    Image(systemName: "info.circle.fill")
                        .foregroundStyle(color)
                    Text(reduceMotion ?
                        "Animations are minimized to prevent motion sickness and distraction" :
                        "Full animations enhance the user experience")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: - Captions Test
struct CaptionsTestView: View {
    let color: Color
    @State private var player: AVPlayer?
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    var isAccessibilitySize: Bool {
        dynamicTypeSize >= .accessibility1
    }

    var body: some View {
        VStack(spacing: 16) {
            // Instructions - hide at accessibility sizes
            if !isAccessibilitySize {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 8) {
                        Image(systemName: "info.circle.fill")
                            .foregroundStyle(color)
                        Text("Caption Style Settings")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }

                    Text("Go to Settings > Accessibility > Subtitles & Captioning > Style to customize how captions appear. Changes apply instantly to the video below!")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            // Native Video Player with Apple Captions
            VStack(spacing: 8) {
                if let player = player {
                    VideoPlayer(player: player)
                        .aspectRatio(16/9, contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    ZStack {
                        Rectangle()
                            .fill(Color.secondary.opacity(0.2))
                            .aspectRatio(16/9, contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 12))

                        VStack(spacing: 8) {
                            ProgressView()
                            Text("Loading video...")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                // Hide caption description at accessibility sizes
                if !isAccessibilitySize {
                    Text("Apple system captions - respects your Style settings")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding()
            .background(Color(uiColor: .secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            // Caption Types Legend
            VStack(alignment: .leading, spacing: 8) {
                Text("What Captions Include")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)

                VStack(spacing: 6) {
                    CaptionTypeBadge(
                        icon: "text.bubble.fill",
                        label: "Dialogue",
                        description: "All spoken words and conversation",
                        color: .blue
                    )
                    CaptionTypeBadge(
                        icon: "speaker.wave.2.fill",
                        label: "Sound Effects",
                        description: "[Music playing], [Door opens], [Thunder]",
                        color: .orange
                    )
                    CaptionTypeBadge(
                        icon: "person.fill",
                        label: "Speaker Identification",
                        description: "NARRATOR: or character names",
                        color: .purple
                    )
                    CaptionTypeBadge(
                        icon: "music.note",
                        label: "Music & Tone",
                        description: "[Upbeat music], [Dramatic tension]",
                        color: .green
                    )
                }
            }

            // Info - hide at accessibility sizes to save space
            if !isAccessibilitySize {
                HStack(spacing: 8) {
                    Image(systemName: "info.circle.fill")
                        .foregroundStyle(color)
                    Text("Captions are essential for deaf/hard-of-hearing users and helpful in sound-sensitive environments or when learning a new language")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .onAppear {
            setupPlayer()
        }
        .onDisappear {
            player?.pause()
            player = nil
        }
    }

    func setupPlayer() {
        // Using Apple's HLS test stream with built-in captions
        guard let url = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8") else {
            return
        }

        player = AVPlayer(url: url)

        // Enable captions - they will use system styling from Settings
        if let player = player {
            let group = player.currentItem?.asset.mediaSelectionGroup(forMediaCharacteristic: .legible)
            if let group = group {
                let options = AVMediaSelectionGroup.mediaSelectionOptions(from: group.options, with: Locale.current)
                if let option = options.first {
                    player.currentItem?.select(option, in: group)
                }
            }
        }
    }
}

struct CaptionTypeBadge: View {
    let icon: String
    let label: String
    let description: String
    let color: Color
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    var isAccessibilitySize: Bool {
        dynamicTypeSize >= .accessibility1
    }

    var body: some View {
        HStack(spacing: isAccessibilitySize ? 12 : 10) {
            // Hide icon at accessibility sizes
            if !isAccessibilitySize {
                Image(systemName: icon)
                    .font(.caption)
                    .foregroundStyle(color)
                    .frame(width: 24)
            }

            VStack(alignment: .leading, spacing: isAccessibilitySize ? 4 : 2) {
                Text(label)
                    .font(isAccessibilitySize ? .body : .caption)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)

                Text(description)
                    .font(isAccessibilitySize ? .body : .caption2)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()
        }
        .padding(.horizontal, isAccessibilitySize ? 16 : 12)
        .padding(.vertical, isAccessibilitySize ? 12 : 8)
        .background(color.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

// MARK: - Audio Descriptions Test
struct AudioDescriptionsTestView: View {
    let color: Color
    @State private var player: AVPlayer?
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    var isAccessibilitySize: Bool {
        dynamicTypeSize >= .accessibility1
    }

    var body: some View {
        VStack(spacing: 16) {
            // Instructions - hide at accessibility sizes
            if !isAccessibilitySize {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 8) {
                        Image(systemName: "info.circle.fill")
                            .foregroundStyle(color)
                        Text("Audio Description Settings")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }

                    Text("Go to Settings > Accessibility > Audio Descriptions and toggle it on. Then play the video below to hear narrated descriptions of visual elements.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            // Video Player
            VStack(spacing: 8) {
                if let player = player {
                    VideoPlayer(player: player)
                        .aspectRatio(16/9, contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    ZStack {
                        Rectangle()
                            .fill(Color.secondary.opacity(0.2))
                            .aspectRatio(16/9, contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 12))

                        VStack(spacing: 8) {
                            ProgressView()
                            Text("Loading video...")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                // Hide description text at accessibility sizes
                if !isAccessibilitySize {
                    Text("Sample video - audio descriptions narrate visual scenes between dialogue")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding()
            .background(Color(uiColor: .secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            // What Gets Described
            VStack(alignment: .leading, spacing: 8) {
                Text("What Gets Described")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)

                VStack(spacing: 6) {
                    DescriptionTypeBadge(
                        icon: "person.fill",
                        label: "Characters",
                        description: "Who appears, what they wear, expressions",
                        color: .blue
                    )
                    DescriptionTypeBadge(
                        icon: "location.fill",
                        label: "Settings",
                        description: "Location, time of day, environment",
                        color: .green
                    )
                    DescriptionTypeBadge(
                        icon: "figure.walk",
                        label: "Actions",
                        description: "Movements, gestures, interactions",
                        color: .orange
                    )
                    DescriptionTypeBadge(
                        icon: "face.smiling",
                        label: "Emotions",
                        description: "Facial expressions, body language",
                        color: .purple
                    )
                    DescriptionTypeBadge(
                        icon: "text.bubble.fill",
                        label: "Text & Graphics",
                        description: "On-screen text, titles, important visuals",
                        color: .pink
                    )
                }
            }

            // Info - hide at accessibility sizes to save space
            if !isAccessibilitySize {
                HStack(spacing: 8) {
                    Image(systemName: "info.circle.fill")
                        .foregroundStyle(color)
                    Text("Audio descriptions are essential for blind and low-vision users to understand visual storytelling and context in videos")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .onAppear {
            setupPlayer()
        }
        .onDisappear {
            player?.pause()
            player = nil
        }
    }

    func setupPlayer() {
        // Using a different Apple sample video
        guard let url = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8") else {
            return
        }

        player = AVPlayer(url: url)

        // Enable audio descriptions if available and user has them enabled
        if let player = player {
            let group = player.currentItem?.asset.mediaSelectionGroup(forMediaCharacteristic: .audible)
            if let group = group {
                // Try to select audio description track if available
                let options = group.options.filter { option in
                    option.hasMediaCharacteristic(.describesVideoForAccessibility)
                }
                if let audioDescriptionOption = options.first {
                    player.currentItem?.select(audioDescriptionOption, in: group)
                }
            }
        }
    }
}

struct DescriptionTypeBadge: View {
    let icon: String
    let label: String
    let description: String
    let color: Color
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    var isAccessibilitySize: Bool {
        dynamicTypeSize >= .accessibility1
    }

    var body: some View {
        HStack(spacing: isAccessibilitySize ? 12 : 10) {
            // Hide icon at accessibility sizes
            if !isAccessibilitySize {
                Image(systemName: icon)
                    .font(.caption)
                    .foregroundStyle(color)
                    .frame(width: 24)
            }

            VStack(alignment: .leading, spacing: isAccessibilitySize ? 4 : 2) {
                Text(label)
                    .font(isAccessibilitySize ? .body : .caption)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)

                Text(description)
                    .font(isAccessibilitySize ? .body : .caption2)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()
        }
        .padding(.horizontal, isAccessibilitySize ? 16 : 12)
        .padding(.vertical, isAccessibilitySize ? 12 : 8)
        .background(color.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

// MARK: - Generic Test
struct GenericTestView: View {
    let color: Color

    var body: some View {
        VStack(spacing: 16) {
            Text("Enable this accessibility feature in Settings to experience how it improves app usability.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding()
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding()
        .background(Color.secondary.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
