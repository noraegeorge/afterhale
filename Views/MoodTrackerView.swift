import SwiftUI

struct MoodTrackerView: View {
    @StateObject private var dataManager = DataManager.shared
    @State private var showingAddMood = false

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple.opacity(0.2), Color.pink.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        // Header with Add Button
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Mood Journal")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .accessibilityAddTraits(.isHeader)

                                Text("Track how you're feeling")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()

                            Button(action: { showingAddMood = true }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.purple)
                            }
                            .accessibilityLabel("Add new mood entry")
                        }
                        .padding()

                        // Mood Summary
                        if !dataManager.moodEntries.isEmpty {
                            VStack(spacing: 15) {
                                Text("Recent Moods")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 15) {
                                        ForEach(dataManager.moodEntries.prefix(7)) { entry in
                                            VStack(spacing: 5) {
                                                Text(entry.mood.emoji)
                                                    .font(.title)
                                                Text(entry.date, style: .date)
                                                    .font(.caption2)
                                                    .foregroundColor(.secondary)
                                            }
                                            .padding()
                                            .background(entry.mood.color.opacity(0.2))
                                            .cornerRadius(10)
                                        }
                                    }
                                }
                                .accessibilityElement(children: .contain)
                                .accessibilityLabel("Recent mood history")
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.1), radius: 10)
                        }

                        // Mood Entries List
                        VStack(spacing: 15) {
                            Text("All Entries")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            if dataManager.moodEntries.isEmpty {
                                VStack(spacing: 15) {
                                    Image(systemName: "face.smiling")
                                        .font(.system(size: 60))
                                        .foregroundColor(.secondary)

                                    Text("No mood entries yet")
                                        .font(.headline)
                                        .foregroundColor(.secondary)

                                    Text("Tap the + button to record your first mood")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .multilineTextAlignment(.center)
                                }
                                .padding(40)
                                .accessibilityElement(children: .combine)
                            } else {
                                ForEach(dataManager.moodEntries) { entry in
                                    MoodEntryRow(entry: entry)
                                        .accessibilityElement(children: .combine)
                                }
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.1), radius: 10)
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingAddMood) {
                AddMoodView()
            }
        }
    }
}

struct MoodEntryRow: View {
    let entry: MoodEntry
    @StateObject private var dataManager = DataManager.shared
    @State private var showingDeleteAlert = false

    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Text(entry.mood.emoji)
                .font(.system(size: 40))
                .accessibilityLabel(entry.mood.rawValue)

            VStack(alignment: .leading, spacing: 5) {
                Text(entry.mood.rawValue)
                    .font(.headline)

                Text(entry.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .accessibilityLabel("Date: \(entry.date.formatted())")

                if !entry.note.isEmpty {
                    Text(entry.note)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                }

                if !entry.tags.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 5) {
                            ForEach(entry.tags, id: \.self) { tag in
                                Text(tag)
                                    .font(.caption)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(entry.mood.color.opacity(0.3))
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
            }

            Spacer()

            Button(action: { showingDeleteAlert = true }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
            .accessibilityLabel("Delete entry")
            .alert("Delete Entry?", isPresented: $showingDeleteAlert) {
                Button("Delete", role: .destructive) {
                    dataManager.deleteMoodEntry(entry)
                }
                Button("Cancel", role: .cancel) {}
            }
        }
        .padding()
        .background(entry.mood.color.opacity(0.1))
        .cornerRadius(10)
    }
}

struct AddMoodView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var dataManager = DataManager.shared

    @State private var selectedMood: MoodEntry.MoodType = .okay
    @State private var note = ""
    @State private var selectedTags: Set<String> = []

    let commonTags = ["School", "Friends", "Family", "Sleep", "Health", "Social Media", "Homework", "Sports"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("How are you feeling?")
                        .font(.headline)
                        .accessibilityAddTraits(.isHeader)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(MoodEntry.MoodType.allCases, id: \.self) { mood in
                                VStack {
                                    Text(mood.emoji)
                                        .font(.system(size: 50))
                                    Text(mood.rawValue)
                                        .font(.caption)
                                }
                                .padding()
                                .background(
                                    selectedMood == mood ?
                                    mood.color.opacity(0.3) : Color.gray.opacity(0.1)
                                )
                                .cornerRadius(10)
                                .onTapGesture {
                                    selectedMood = mood
                                }
                                .accessibilityAddTraits(selectedMood == mood ? .isSelected : [])
                            }
                        }
                        .padding(.vertical)
                    }
                } header: {
                    Text("Mood")
                }

                Section {
                    TextEditor(text: $note)
                        .frame(minHeight: 100)
                        .accessibilityLabel("Mood note")
                        .accessibilityHint("Write about what's affecting your mood")
                } header: {
                    Text("Note (Optional)")
                }

                Section {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                        ForEach(commonTags, id: \.self) { tag in
                            Text(tag)
                                .font(.subheadline)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(
                                    selectedTags.contains(tag) ?
                                    Color.purple.opacity(0.3) : Color.gray.opacity(0.1)
                                )
                                .cornerRadius(8)
                                .onTapGesture {
                                    if selectedTags.contains(tag) {
                                        selectedTags.remove(tag)
                                    } else {
                                        selectedTags.insert(tag)
                                    }
                                }
                                .accessibilityAddTraits(selectedTags.contains(tag) ? .isSelected : [])
                        }
                    }
                } header: {
                    Text("Tags (Optional)")
                }
            }
            .navigationTitle("Add Mood Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let entry = MoodEntry(
                            date: Date(),
                            mood: selectedMood,
                            note: note,
                            tags: Array(selectedTags)
                        )
                        dataManager.addMoodEntry(entry)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    MoodTrackerView()
}
