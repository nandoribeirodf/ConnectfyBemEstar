//
//  PersonFormView.swift
//  Connectfy Bem Estar
//
//  Created by Fernando Araujo Ribeiro on 27/11/25.
//

import SwiftUI

struct PersonFormView: View {
    enum FormResult {
        case cancel
        case save(Person)
        case delete(Person)
    }
    
    private enum Mode {
        case create
        case edit
    }
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var workingPerson: Person
    @State private var hasLastInteraction: Bool
    private let mode: Mode
    private let onFinish: (FormResult) -> Void
    
    // MARK: - Init customizado
    init(person: Person?, defaultCircle: CircleType, onFinish: @escaping (FormResult) -> Void) {
        if let person {
            _workingPerson = State(initialValue: person)
            _hasLastInteraction = State(initialValue: person.lastInteraction != nil)
            self.mode = .edit
        } else {
            let newPerson = Person(name: "", circle: defaultCircle)
            _workingPerson = State(initialValue: newPerson)
            _hasLastInteraction = State(initialValue: false)
            self.mode = .create
        }
        self.onFinish = onFinish
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.12),
                    Color.white
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            Form {
                Section("Dados básicos".uppercased()) {
                    TextField("Nome", text: $workingPerson.name)
                    
                    Picker("Círculo", selection: $workingPerson.circle) {
                        ForEach(CircleType.allCases) { circle in
                            Text(circle.rawValue).tag(circle)
                        }
                    }
                    
                    TextField("Localidade", text: $workingPerson.location)
                        .textInputAutocapitalization(.words)
                }
                
                Section("Interações".uppercased()) {
                    Toggle("Registrar última interação", isOn: $hasLastInteraction)
                    
                    if hasLastInteraction {
                        DatePicker(
                            "Última interação",
                            selection: Binding(
                                get: { workingPerson.lastInteraction ?? Date() },
                                set: { workingPerson.lastInteraction = $0 }
                            ),
                            displayedComponents: .date
                        )
                    }
                }
                
                if mode == .edit {
                    Section {
                        Button(role: .destructive) {
                            onFinish(.delete(workingPerson))
                            dismiss()
                        } label: {
                            Text("Excluir contato")
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
        }
        .navigationTitle(mode == .create ? "Nova Pessoa" : "Editar Pessoa")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancelar") {
                    onFinish(.cancel)
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button("Salvar") {
                    if !hasLastInteraction {
                        workingPerson.lastInteraction = nil
                    }
                    onFinish(.save(workingPerson))
                    dismiss()
                }
                .disabled(workingPerson.name.trimmingCharacters(in: .whitespaces).isEmpty)
            }
        }
    }
}


