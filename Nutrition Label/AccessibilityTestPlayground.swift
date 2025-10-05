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
    @State private var text = ""

    var body: some View {
        VStack(spacing: 16) {
            Text("Enable Voice Control and try saying: 'Tap button name' or 'Show numbers' to see item numbers you can tap.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding()
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            Button("Press Me") {
                text = "Button pressed!"
            }
            .foregroundStyle(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            if !text.isEmpty {
                Text(text)
                    .font(.headline)
                    .foregroundStyle(color)
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

    var body: some View {
        VStack(spacing: 16) {
            Text("Go to Settings > Accessibility > Display & Text Size > Larger Text and adjust the slider. This app automatically responds!")
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding()
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 12) {
                Text("Dynamic Type Example")
                    .font(.headline)

                Text("This text uses Dynamic Type and will scale with your system text size settings. Try increasing the text size in Settings to see it grow!")
                    .font(.body)
                    .foregroundStyle(.secondary)

                Text("Current size: \(String(describing: dynamicTypeSize))")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
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

// MARK: - Dark Interface Test
struct DarkInterfaceTestView: View {
    let color: Color
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(spacing: 16) {
            Text("The app automatically adapts when you enable Dark Mode in Settings > Display & Brightness.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding()
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            HStack(spacing: 20) {
                VStack {
                    Image(systemName: colorScheme == .dark ? "moon.fill" : "sun.max.fill")
                        .font(.largeTitle)
                        .foregroundStyle(color)

                    Text(colorScheme == .dark ? "Dark Mode" : "Light Mode")
                        .font(.caption)
                        .fontWeight(.semibold)

                    Text("Currently Active")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 16))
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
