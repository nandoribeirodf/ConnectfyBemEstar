//
//  PeopleListView.swift
//  Connectfy Bem Estar
//
//  Created by Fernando Araujo Ribeiro on 27/11/25.
//

import SwiftUI

struct PeopleListView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) private var dismiss
    
    let circle: CircleType
    
    @State private var isCreating = false
    @State private var editingPerson: Person?
    
    var body: some View {
        ZStack {
            // Fundo
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.15),
                    Color.white
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    // MARK: - Header com voltar + título + add
                    HStack(spacing: 14) {
                        // Voltar
                        Button {
                            dismiss()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.ultraThinMaterial)
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(circle.color)
                            }
                            .frame(width: 34, height: 34)
                            .shadow(color: .black.opacity(0.1),
                                    radius: 3, x: 0, y: 2)
                        }
                        
                        // Título
                        Text(circle.rawValue)
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        // Adicionar pessoa
                        Button {
                            isCreating = true
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(circle.color)
                                .symbolRenderingMode(.hierarchical)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    
                    // MARK: - Lista estilizada
                    VStack(spacing: 12) {
                        ForEach(appState.people(in: circle)) { person in
                            Button {
                                editingPerson = person
                            } label: {
                                personCard(person)
                            }
                            .buttonStyle(CardTapStyle()) // micro animação
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 40)
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        
        // Sheet de CRIAÇÃO
        .sheet(isPresented: $isCreating) {
            NavigationStack {
                PersonFormView(
                    person: nil,
                    defaultCircle: circle
                ) { result in
                    switch result {
                    case .cancel:
                        break
                    case .save(let person):
                        appState.add(person)
                    case .delete:
                        break // não existe delete em nova pessoa
                    }
                    isCreating = false
                }
            }
        }
        
        // Sheet de EDIÇÃO (usa item:)
        .sheet(item: $editingPerson) { person in
            NavigationStack {
                PersonFormView(
                    person: person,
                    defaultCircle: circle
                ) { result in
                    switch result {
                    case .cancel:
                        break
                    case .save(let updated):
                        appState.update(updated)
                    case .delete(let deleted):
                        appState.delete(deleted)
                    }
                    editingPerson = nil
                }
            }
        }
    }
    
    // MARK: - Card visual da pessoa
    private func personCard(_ person: Person) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(.ultraThinMaterial)
                .shadow(color: .black.opacity(0.08),
                        radius: 4, x: 0, y: 3)
            
            HStack(spacing: 14) {
                // Avatar com cor por círculo
                ZStack {
                    Circle()
                        .fill(circle.color.opacity(0.15))
                        .frame(width: 42, height: 42)
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 32))
                        .foregroundColor(circle.color)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(person.name)
                        .font(.system(.headline, design: .rounded))
                        .foregroundColor(.primary)
                    
                    Text(subtitle(for: person))
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Badge “faz tempo / sem registro” + chevron
                VStack(alignment: .trailing, spacing: 6) {
                    if let info = staleInfo(for: person) {
                        Text(info.label)
                            .font(.system(.caption, design: .rounded).weight(.semibold))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(
                                Capsule()
                                    .fill(info.color.opacity(0.12))
                            )
                            .foregroundColor(info.color)
                    }
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.secondary.opacity(0.5))
                }
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 14)
        }
    }
    
    // MARK: - Subtítulo
    private func subtitle(for person: Person) -> String {
        let loc = person.location.isEmpty ? "Sem localidade" : person.location
        let last = person.lastInteractionDescription
        return "\(loc) • \(last)"
    }
    
    // MARK: - Lógica de “faz tempo”
    private func staleInfo(for person: Person) -> (label: String, color: Color)? {
        guard let date = person.lastInteraction else {
            return ("Sem registro", .gray)
        }
        
        let days = Calendar.current.dateComponents([.day], from: date, to: Date()).day ?? 0
        
        if days >= 90 {
            return ("Faz tempo", .orange)
        } else if days >= 45 {
            return ("Precisa de contato", .yellow)
        } else {
            return nil
        }
    }
}

// MARK: - Estilo de botão com micro-animação

struct CardTapStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .opacity(configuration.isPressed ? 0.92 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.8),
                       value: configuration.isPressed)
    }
}

