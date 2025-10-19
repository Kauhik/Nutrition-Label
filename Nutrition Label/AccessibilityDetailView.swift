//
//  AccessibilityDetailView.swift
//  Nutrition Label
//
//  Created by Kaushik Manian on 5/10/25.
//

import SwiftUI

struct AccessibilityDetailView: View {
    let feature: AccessibilityFeature
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    var isAccessibilitySize: Bool {
        dynamicTypeSize >= .accessibility1
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header with icon - hide icon at accessibility sizes
                if !isAccessibilitySize {
                    HStack {
                        Image(systemName: feature.icon)
                            .font(.system(size: 60))
                            .foregroundStyle(feature.color)
                        Spacer()
                    }
                    .padding(.top)
                }

                // Feature name
                Text(feature.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, isAccessibilitySize ? 8 : 0)

                // Short description - hide at accessibility sizes
                if !isAccessibilitySize {
                    Text(feature.shortDescription)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Divider()

                // Platforms - hide at accessibility sizes to save space
                if !isAccessibilitySize {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Available On")
                            .font(.headline)
                            .foregroundStyle(.secondary)

                        FlowLayout(spacing: 8) {
                            ForEach(feature.platforms, id: \.self) { platform in
                                PlatformBadge(platform: platform)
                            }
                        }
                    }

                    Divider()
                }

                // Full description
                VStack(alignment: .leading, spacing: 12) {
                    Text("About")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)

                    Text(feature.fullDescription)
                        .font(.body)
                        .lineSpacing(4)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Divider()

                // How to Enable
                VStack(alignment: .leading, spacing: 12) {
                    Text("How to Enable")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)

                    VStack(alignment: .leading, spacing: isAccessibilitySize ? 16 : 8) {
                        ForEach(Array(feature.activationSteps.enumerated()), id: \.offset) { index, step in
                            if isAccessibilitySize {
                                // Simplified layout for accessibility sizes
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("\(index + 1).")
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .foregroundStyle(feature.color)

                                    Text(step)
                                        .font(.body)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineSpacing(4)
                                }
                            } else {
                                // Standard layout for normal sizes
                                HStack(alignment: .top, spacing: 12) {
                                    Text("\(index + 1).")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(feature.color)
                                        .frame(width: 20, alignment: .leading)

                                    Text(step)
                                        .font(.body)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineSpacing(4)
                                }
                            }
                        }
                    }
                }

                Divider()

                // Test Playground
                AccessibilityTestPlayground(feature: feature)

                // Implementation tips - hide at accessibility sizes
                if !isAccessibilitySize {
                    Divider()

                    VStack(alignment: .leading, spacing: 12) {
                        Text("For Developers")
                            .font(.headline)
                            .foregroundStyle(.secondary)

                        Text("Ensure your app supports this feature by following Apple's Human Interface Guidelines and testing with the Accessibility Inspector.")
                            .font(.body)
                            .foregroundStyle(.secondary)
                            .lineSpacing(4)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }

            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PlatformBadge: View {
    let platform: String

    var platformIcon: String {
        switch platform {
        case "iOS":
            return "iphone"
        case "iPadOS":
            return "ipad"
        case "macOS":
            return "macbook"
        case "watchOS":
            return "applewatch"
        case "tvOS":
            return "appletv"
        case "visionOS":
            return "visionpro"
        default:
            return "questionmark.circle"
        }
    }

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: platformIcon)
                .font(.caption)
            Text(platform)
                .font(.caption)
                .fontWeight(.medium)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(Color.accentColor.opacity(0.15))
        .foregroundStyle(Color.accentColor)
        .clipShape(Capsule())
    }
}

struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(in: proposal.replacingUnspecifiedDimensions().width, subviews: subviews, spacing: spacing)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(in: bounds.width, subviews: subviews, spacing: spacing)
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: bounds.minX + result.frames[index].minX, y: bounds.minY + result.frames[index].minY), proposal: .unspecified)
        }
    }

    struct FlowResult {
        var frames: [CGRect] = []
        var size: CGSize = .zero

        init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
            var currentX: CGFloat = 0
            var currentY: CGFloat = 0
            var lineHeight: CGFloat = 0

            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)

                if currentX + size.width > maxWidth && currentX > 0 {
                    currentX = 0
                    currentY += lineHeight + spacing
                    lineHeight = 0
                }

                frames.append(CGRect(x: currentX, y: currentY, width: size.width, height: size.height))
                lineHeight = max(lineHeight, size.height)
                currentX += size.width + spacing
            }

            self.size = CGSize(width: maxWidth, height: currentY + lineHeight)
        }
    }
}

#Preview {
    NavigationStack {
        AccessibilityDetailView(feature: AccessibilityFeature.allFeatures[0])
    }
}
