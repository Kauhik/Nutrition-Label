//
//  ContentView.swift
//  Nutrition Label
//
//  Created by Kaushik Manian on 5/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    var isAccessibilitySize: Bool {
        dynamicTypeSize >= .accessibility1
    }

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
                            .fixedSize(horizontal: false, vertical: true)

                        Text("iOS Nutrition Labels")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)

                        // Hide description at accessibility sizes to save space
                        if !isAccessibilitySize {
                            Text("Discover how apps can support accessibility features to ensure everyone can use them effectively.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .padding(.top, 4)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 20)

                    // Grouped feature cards
                    LazyVStack(alignment: .leading, spacing: 32) {
                        ForEach(groupedFeatures, id: \.category) { group in
                            VStack(alignment: .leading, spacing: 12) {
                                // Category header - keep icons visible
                                HStack(spacing: 8) {
                                    Image(systemName: group.category.icon)
                                        .foregroundStyle(group.category.color)
                                        .imageScale(.large)
                                    Text(group.category.rawValue)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .fixedSize(horizontal: false, vertical: true)
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
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    var isAccessibilitySize: Bool {
        dynamicTypeSize >= .accessibility1
    }

    var body: some View {
        HStack(spacing: 16) {
            // Icon - hide at accessibility sizes
            if !isAccessibilitySize {
                Image(systemName: feature.icon)
                    .font(.system(size: 40))
                    .foregroundStyle(feature.color)
                    .frame(width: 60, height: 60)
            }

            // Content
            VStack(alignment: .leading, spacing: 6) {
                Text(feature.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .fixedSize(horizontal: false, vertical: true)

                // Hide description at accessibility sizes
                if !isAccessibilitySize {
                    Text(feature.shortDescription)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            Spacer()

            // Chevron - hide at accessibility sizes
            if !isAccessibilitySize {
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
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
