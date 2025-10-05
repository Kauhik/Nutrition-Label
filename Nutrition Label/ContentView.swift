//
//  ContentView.swift
//  Nutrition Label
//
//  Created by Kaushik Manian on 5/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""

    var filteredFeatures: [AccessibilityFeature] {
        if searchText.isEmpty {
            return AccessibilityFeature.allFeatures
        } else {
            return AccessibilityFeature.allFeatures.filter { feature in
                feature.name.localizedCaseInsensitiveContains(searchText) ||
                feature.shortDescription.localizedCaseInsensitiveContains(searchText)
            }
        }
    } 

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Accessibility")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text("iOS Nutrition Labels")
                            .font(.title2)
                            .foregroundStyle(.secondary)

                        Text("Discover how apps can support accessibility features to ensure everyone can use them effectively.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .padding(.top, 4)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()

                    // Feature cards
                    LazyVStack(spacing: 16) {
                        ForEach(filteredFeatures) { feature in
                            NavigationLink(destination: AccessibilityDetailView(feature: feature)) {
                                AccessibilityCard(
                                    feature: feature
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .searchable(text: $searchText, prompt: "Search features")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AccessibilityCard: View {
    let feature: AccessibilityFeature
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack(spacing: 16) {
            // Icon
            Image(systemName: feature.icon)
                .font(.system(size: 40))
                .foregroundStyle(feature.color)
                .frame(width: 60, height: 60)

            // Content
            VStack(alignment: .leading, spacing: 6) {
                Text(feature.name)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Text(feature.shortDescription)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)

                // Platform count
                Text("\(feature.platforms.count) platforms")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }

            Spacer()

            // Chevron
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(colorScheme == .dark ? Color(.systemGray6) : Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
        )
    }
}

#Preview {
    ContentView()
}
