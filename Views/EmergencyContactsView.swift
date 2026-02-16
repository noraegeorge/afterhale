import SwiftUI

struct EmergencyContactsView: View {
    @StateObject private var dataManager = DataManager.shared
    @State private var showingAddContact = false

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.red.opacity(0.2), Color.orange.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        // Header
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Emergency Contacts")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .accessibilityAddTraits(.isHeader)

                                Text("People you trust and can reach out to")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()

                            Button(action: { showingAddContact = true }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.red)
                            }
                            .accessibilityLabel("Add new emergency contact")
                        }
                        .padding()

                        // Crisis Hotlines Section
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Crisis Hotlines")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                                .accessibilityAddTraits(.isHeader)

                            CrisisHotlineCard(
                                name: "988 Suicide & Crisis Lifeline",
                                number: "988",
                                description: "24/7 free support",
                                icon: "phone.circle.fill",
                                color: .red
                            )

                            CrisisHotlineCard(
                                name: "Crisis Text Line",
                                number: "741741",
                                description: "Text HOME for support",
                                icon: "message.circle.fill",
                                color: .blue
                            )

                            CrisisHotlineCard(
                                name: "Teen Line",
                                number: "3108554673",
                                description: "Teens helping teens",
                                icon: "person.2.circle.fill",
                                color: .green
                            )
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.1), radius: 10)

                        // Personal Contacts Section
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Your Trusted Contacts")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .accessibilityAddTraits(.isHeader)

                            if dataManager.emergencyContacts.isEmpty {
                                VStack(spacing: 15) {
                                    Image(systemName: "person.2.fill")
                                        .font(.system(size: 60))
                                        .foregroundColor(.secondary)

                                    Text("No contacts yet")
                                        .font(.headline)
                                        .foregroundColor(.secondary)

                                    Text("Add trusted people you can reach out to when you need support")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .multilineTextAlignment(.center)
                                }
                                .padding(40)
                                .accessibilityElement(children: .combine)
                            } else {
                                ForEach(dataManager.emergencyContacts) { contact in
                                    EmergencyContactRow(contact: contact)
                                }
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.1), radius: 10)

                        // Emergency Note
                        VStack(spacing: 10) {
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.red)
                                Text("For life-threatening emergencies, always call 911")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                            }
                        }
                        .padding()
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(15)
                        .accessibilityElement(children: .combine)
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingAddContact) {
                AddEmergencyContactView()
            }
        }
    }
}

struct CrisisHotlineCard: View {
    let name: String
    let number: String
    let description: String
    let icon: String
    let color: Color
    @State private var showingCallAlert = false

    var body: some View {
        Button(action: { showingCallAlert = true }) {
            HStack(spacing: 15) {
                Image(systemName: icon)
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(color)
                    .cornerRadius(12)

                VStack(alignment: .leading, spacing: 5) {
                    Text(name)
                        .font(.headline)
                        .foregroundColor(.primary)

                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Text(formatPhoneNumber(number))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(color)
                }

                Spacer()

                Image(systemName: "phone.fill")
                    .foregroundColor(color)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
        }
        .accessibilityLabel("\(name), \(description), \(formatPhoneNumber(number))")
        .accessibilityHint("Double tap to call")
        .alert("Call \(name)?", isPresented: $showingCallAlert) {
            Button("Call") {
                if let url = URL(string: "tel://\(number)") {
                    UIApplication.shared.open(url)
                }
            }
            Button("Cancel", role: .cancel) {}
        }
    }

    private func formatPhoneNumber(_ number: String) -> String {
        if number == "988" {
            return "988"
        } else if number == "741741" {
            return "741741"
        } else if number.count == 10 {
            let areaCode = number.prefix(3)
            let middle = number.dropFirst(3).prefix(3)
            let last = number.suffix(4)
            return "(\(areaCode)) \(middle)-\(last)"
        }
        return number
    }
}

struct EmergencyContactRow: View {
    let contact: EmergencyContact
    @StateObject private var dataManager = DataManager.shared
    @State private var showingCallAlert = false
    @State private var showingDeleteAlert = false
    @State private var showingEditSheet = false

    var body: some View {
        HStack(spacing: 15) {
            VStack(alignment: .leading, spacing: 5) {
                Text(contact.name)
                    .font(.headline)

                Text(contact.relationship)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text(contact.phoneNumber)
                    .font(.subheadline)
                    .foregroundColor(.blue)

                if !contact.note.isEmpty {
                    Text(contact.note)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }

            Spacer()

            HStack(spacing: 15) {
                Button(action: { showingCallAlert = true }) {
                    Image(systemName: "phone.fill")
                        .foregroundColor(.green)
                        .font(.title3)
                }
                .accessibilityLabel("Call \(contact.name)")

                Button(action: { showingEditSheet = true }) {
                    Image(systemName: "pencil")
                        .foregroundColor(.blue)
                        .font(.title3)
                }
                .accessibilityLabel("Edit contact")

                Button(action: { showingDeleteAlert = true }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .font(.title3)
                }
                .accessibilityLabel("Delete contact")
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
        .alert("Call \(contact.name)?", isPresented: $showingCallAlert) {
            Button("Call") {
                let cleanNumber = contact.phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                if let url = URL(string: "tel://\(cleanNumber)") {
                    UIApplication.shared.open(url)
                }
            }
            Button("Cancel", role: .cancel) {}
        }
        .alert("Delete Contact?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                dataManager.deleteEmergencyContact(contact)
            }
            Button("Cancel", role: .cancel) {}
        }
        .sheet(isPresented: $showingEditSheet) {
            EditEmergencyContactView(contact: contact)
        }
        .accessibilityElement(children: .contain)
    }
}

struct AddEmergencyContactView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var dataManager = DataManager.shared

    @State private var name = ""
    @State private var relationship = ""
    @State private var phoneNumber = ""
    @State private var note = ""

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                        .accessibilityLabel("Contact name")
                    TextField("Relationship", text: $relationship)
                        .accessibilityLabel("Relationship")
                        .accessibilityHint("For example: Parent, Friend, Counselor")
                } header: {
                    Text("Contact Info")
                }

                Section {
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                        .accessibilityLabel("Phone number")
                } header: {
                    Text("Phone")
                }

                Section {
                    TextEditor(text: $note)
                        .frame(minHeight: 80)
                        .accessibilityLabel("Note")
                        .accessibilityHint("Optional note about this contact")
                } header: {
                    Text("Note (Optional)")
                }
            }
            .navigationTitle("Add Emergency Contact")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let contact = EmergencyContact(
                            name: name,
                            relationship: relationship,
                            phoneNumber: phoneNumber,
                            note: note
                        )
                        dataManager.addEmergencyContact(contact)
                        dismiss()
                    }
                    .disabled(name.isEmpty || phoneNumber.isEmpty)
                }
            }
        }
    }
}

struct EditEmergencyContactView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var dataManager = DataManager.shared

    let contact: EmergencyContact

    @State private var name: String
    @State private var relationship: String
    @State private var phoneNumber: String
    @State private var note: String

    init(contact: EmergencyContact) {
        self.contact = contact
        _name = State(initialValue: contact.name)
        _relationship = State(initialValue: contact.relationship)
        _phoneNumber = State(initialValue: contact.phoneNumber)
        _note = State(initialValue: contact.note)
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                    TextField("Relationship", text: $relationship)
                } header: {
                    Text("Contact Info")
                }

                Section {
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                } header: {
                    Text("Phone")
                }

                Section {
                    TextEditor(text: $note)
                        .frame(minHeight: 80)
                } header: {
                    Text("Note (Optional)")
                }
            }
            .navigationTitle("Edit Contact")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        var updatedContact = contact
                        updatedContact.name = name
                        updatedContact.relationship = relationship
                        updatedContact.phoneNumber = phoneNumber
                        updatedContact.note = note
                        dataManager.updateEmergencyContact(updatedContact)
                        dismiss()
                    }
                    .disabled(name.isEmpty || phoneNumber.isEmpty)
                }
            }
        }
    }
}

#Preview {
    EmergencyContactsView()
}
