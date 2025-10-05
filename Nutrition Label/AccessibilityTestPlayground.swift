//
//  AccessibilityTestPlayground.swift
//  Nutrition Label
//
//  Created by Kaushik Manian on 5/10/25.
//

import SwiftUI

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

    let options = ["Option 1", "Option 2", "Option 3"]

    var body: some View {
        VStack(spacing: 16) {
            // Instructions
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

            // Feedback display
            Text(feedback)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(color)
                .frame(maxWidth: .infinity)
                .padding()
                .background(color.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            // Interactive buttons
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

            // Toggle control
            HStack {
                Text("Notifications")
                    .font(.body)
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

            // Text input field
            VStack(alignment: .leading, spacing: 8) {
                Text("Say: \"Type your message\"")
                    .font(.caption)
                    .foregroundStyle(.secondary)

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
                Text("Choose an option:")
                    .font(.caption)
                    .foregroundStyle(.secondary)

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

            // Action buttons
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

                    Divider()

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
                                .minimumScaleFactor(0.7)
                                .lineLimit(1)
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
                                .minimumScaleFactor(0.7)
                                .lineLimit(1)
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

    var body: some View {
        VStack(spacing: 16) {
            Text("Toggle Dark Mode in Settings > Display & Brightness to see all UI elements adapt instantly.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding()
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            // Current Mode Indicator
            HStack(spacing: 12) {
                Image(systemName: colorScheme == .dark ? "moon.fill" : "sun.max.fill")
                    .font(.title)
                    .foregroundStyle(color)

                VStack(alignment: .leading, spacing: 2) {
                    Text(colorScheme == .dark ? "Dark Mode Active" : "Light Mode Active")
                        .font(.headline)
                    Text("All elements adapt automatically")
                        .font(.caption)
                        .foregroundStyle(.secondary)
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

            // UI Elements
            VStack(alignment: .leading, spacing: 8) {
                Text("UI Elements")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                VStack(spacing: 8) {
                    // Button
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "star.fill")
                            Text("Accent Button")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }

                    // Card
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
                Image(systemName: "info.circle.fill")
                    .foregroundStyle(color)
                Text(colorScheme == .dark ?
                    "Dark mode reduces glare and eye strain in low-light environments" :
                    "Light mode provides better visibility in bright environments")
                    .font(.caption)
                    .foregroundStyle(.secondary)
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

    var body: some View {
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

struct ListRowDemo: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
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

// MARK: - Differentiate Without Color Test
struct DifferentiateColorTestView: View {
    let color: Color
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor

    var body: some View {
        VStack(spacing: 16) {
            Text("Enable this setting in Accessibility to see icons appear automatically. The app responds instantly!")
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding()
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            Text(differentiateWithoutColor ? "Icons shown (Feature ON)" : "Color only (Feature OFF)")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(differentiateWithoutColor ? .green : .secondary)

            HStack(spacing: 12) {
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

    var body: some View {
        VStack(spacing: 8) {
            if showIcon {
                Image(systemName: icon)
                    .font(.title)
                    .foregroundStyle(color)
            } else {
                Circle()
                    .fill(color)
                    .frame(width: 30, height: 30)
            }

            Text(status)
                .font(.caption)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Contrast Test
struct ContrastTestView: View {
    let color: Color
    @Environment(\.colorSchemeContrast) var contrast

    var body: some View {
        VStack(spacing: 16) {
            Text("Enable Increase Contrast in Accessibility settings. The app automatically adjusts backgrounds!")
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding()
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(spacing: 12) {
                HStack {
                    Text("Current Contrast:")
                        .font(.headline)
                    Spacer()
                    Text(contrast == .increased ? "Increased ✓" : "Standard")
                        .font(.headline)
                        .foregroundStyle(contrast == .increased ? .green : .secondary)
                }

                Text("Notice how background opacity increases when you enable this feature for better visibility.")
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .background(color.opacity(contrast == .increased ? 0.2 : 0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding()
        .background(Color.secondary.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: - Reduced Motion Test
struct ReducedMotionTestView: View {
    let color: Color
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var isAnimating = false

    var body: some View {
        VStack(spacing: 16) {
            Text("Enable Reduce Motion in Accessibility settings. Tap the button below to see the difference!")
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding()
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            HStack {
                Text("Status:")
                    .font(.caption)
                    .fontWeight(.semibold)
                Spacer()
                Text(reduceMotion ? "ON - No animations" : "OFF - Animations active")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(reduceMotion ? .green : .secondary)
            }
            .padding(.horizontal)

            Button("Toggle Animation") {
                isAnimating.toggle()
            }
            .foregroundStyle(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Circle()
                .fill(color)
                .frame(width: 60, height: 60)
                .offset(x: isAnimating ? 100 : -100)
                .animation(reduceMotion ? .none : .spring(duration: 0.8), value: isAnimating)

            Text(reduceMotion ? "Circle moves instantly (no spring animation)" : "Circle animates with spring effect")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(Color.secondary.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: - Captions Test
struct CaptionsTestView: View {
    let color: Color

    var body: some View {
        VStack(spacing: 16) {
            Text("Enable Closed Captions in supported video apps to see text for dialogue and sounds.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding()
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(spacing: 12) {
                Image(systemName: "captions.bubble")
                    .font(.system(size: 50))
                    .foregroundStyle(color)

                Text("[Background Music Playing]")
                    .font(.caption)
                    .padding(8)
                    .background(Color.black.opacity(0.7))
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))

                Text("Captions appear in video content")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .background(color.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding()
        .background(Color.secondary.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: - Audio Descriptions Test
struct AudioDescriptionsTestView: View {
    let color: Color

    var body: some View {
        VStack(spacing: 16) {
            Text("Enable Audio Descriptions in supported video content to hear narrated descriptions of visual elements.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding()
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(spacing: 12) {
                Image(systemName: "waveform")
                    .font(.system(size: 50))
                    .foregroundStyle(color)

                Text("🔊 'A person walks through a sunny park...'")
                    .font(.caption)
                    .italic()
                    .foregroundStyle(.secondary)

                Text("Audio descriptions narrate visual scenes")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .background(color.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding()
        .background(Color.secondary.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 16))
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
