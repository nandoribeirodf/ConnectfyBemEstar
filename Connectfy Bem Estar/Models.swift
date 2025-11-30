//
//  Models.swift
//  Connectfy Bem Estar
//
//  Created by Fernando Araujo Ribeiro on 27/11/25.
//

import Foundation
import SwiftUI

// MARK: - Círculos

enum CircleType: String, CaseIterable, Identifiable {
    case familia = "Família"
    case amigosProximos = "Amigos Próximos"
    case profissionais = "Profissionais/Terapia"
    case trabalho = "Trabalho"
    
    var id: String { rawValue }
    
    var systemImageName: String {
        switch self {
        case .familia:          return "house.fill"
        case .amigosProximos:   return "person.3.fill"
        case .profissionais:    return "stethoscope"
        case .trabalho:         return "briefcase.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .familia:          return Color.blue.opacity(0.9)
        case .amigosProximos:   return Color.blue.opacity(0.8)
        case .profissionais:    return Color.blue.opacity(0.7)
        case .trabalho:         return Color.blue.opacity(0.6)
        }
    }
}

// MARK: - Pessoa

struct Person: Identifiable, Hashable {
    let id: UUID
    var name: String
    var circle: CircleType
    var location: String
    var lastInteraction: Date?
    
    init(id: UUID = UUID(),
         name: String,
         circle: CircleType,
         location: String = "",
         lastInteraction: Date? = nil) {
        self.id = id
        self.name = name
        self.circle = circle
        self.location = location
        self.lastInteraction = lastInteraction
    }
    
    var lastInteractionDescription: String {
        guard let date = lastInteraction else { return "Sem registro" }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM/yyyy"
        return formatter.string(from: date)
    }
}

// MARK: - Estado global simples

final class AppState: ObservableObject {
    @Published var people: [Person] = [
        // Família (3)
        Person(name: "Ana Paula", circle: .familia, location: "Brasília", lastInteraction: Date()),
        Person(name: "Paulo Henrique", circle: .familia, location: "Goiânia"),
        Person(name: "Maria Clara", circle: .familia, location: "São Paulo"),
        
        // Amigos Próximos (4)
        Person(name: "João Lucas", circle: .amigosProximos, location: "Brasília", lastInteraction: Date()),
        Person(name: "Fernanda Souza", circle: .amigosProximos, location: "Rio de Janeiro"),
        Person(name: "Carla Mendes", circle: .amigosProximos, location: "Curitiba"),
        Person(name: "Rafael Monteiro", circle: .amigosProximos, location: "Belo Horizonte"),
        
        // Profissionais / Terapia (2)
        Person(name: "Dra. Marina (Psicóloga)", circle: .profissionais, location: "Online", lastInteraction: Date()),
        Person(name: "Dr. Rafael (Psiquiatra)", circle: .profissionais, location: "Brasília"),
        
        // Trabalho (2)
        Person(name: "Carlos Eduardo", circle: .trabalho, location: "Brasília", lastInteraction: Date()),
        Person(name: "Aline Ribeiro", circle: .trabalho, location: "São Paulo")
    ]
    
    func people(in circle: CircleType) -> [Person] {
        people
            .filter { $0.circle == circle }
            .sorted { $0.name < $1.name }
    }
    
    func add(_ person: Person) {
        people.append(person)
    }
    
    func update(_ person: Person) {
        guard let index = people.firstIndex(where: { $0.id == person.id }) else { return }
        people[index] = person
    }
    
    func delete(_ person: Person) {
        people.removeAll { $0.id == person.id }
    }
    
    func count(in circle: CircleType) -> Int {
        people(in: circle).count
    }
}

