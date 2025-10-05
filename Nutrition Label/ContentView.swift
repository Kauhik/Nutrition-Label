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

    var groupedFeatures: [(category: AccessibilityCategory, features: [AccessibilityFeature])] {
        let filtered = filteredFeatures
        return AccessibilityCategory.allCases.compactMap { category in
            let featuresInCategory = filtered.filter { $0.category == category }
            return featuresInCategory.isEmpty ? nil : (category, featuresInCategory)
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
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
                    .padding(.horizontal)
                    .padding(.bottom, 20)

                    // Grouped feature cards
                    LazyVStack(alignment: .leading, spacing: 32) {
                        ForEach(groupedFeatures, id: \.category) { group in
                            VStack(alignment: .leading, spacing: 12) {
                                // Category header
                                HStack(spacing: 8) {
                                    Image(systemName: group.category.icon)
                                        .foregroundStyle(group.category.color)
                                    Text(group.category.rawValue)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                }
                                .padding(.horizontal)
                                .padding(.top, 8)

                                // Features in this category
                                ForEach(group.features) { feature in
                                    NavigationLink(destination: AccessibilityDetailView(feature: feature)) {
                                        AccessibilityCard(feature: feature)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .background(Color(uiColor: .systemGroupedBackground))
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
