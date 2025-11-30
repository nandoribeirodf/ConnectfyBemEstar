//
//  CirclesMenuView.swift
//  Connectfy Bem Estar
//
//  Created by Fernando Araujo Ribeiro
//

import SwiftUI

struct CirclesMenuView: View {
    @EnvironmentObject var appState: AppState
    
    // Grid 2 colunas
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ZStack {
            // Fundo com gradiente suave
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.35),
                    Color.white
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            GeometryReader { geo in
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 28) {
                        
                        // Cabeçalho de marca
                        headerView
                        
                        // Grid de círculos
                        LazyVGrid(columns: columns, spacing: 18) {
                            ForEach(CircleType.allCases) { circle in
                                NavigationLink {
                                    PeopleListView(circle: circle)
                                } label: {
                                    CircleCard(
                                        circle: circle,
                                        count: appState.count(in: circle)
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    // Centraliza mais o conteúdo na vertical
                    .frame(minHeight: geo.size.height, alignment: .center)
                }
            }
        }
        // Esconde a navigation bar nesta tela pra deixar o cabeçalho livre
        .toolbar(.hidden, for: .navigationBar)
    }
    
    // MARK: - Header
    
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Marca principal
            Text("Connectfy")
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
            
            // Subproduto + selo ODS
            HStack(spacing: 10) {
                Text("Bem-Estar")
                    .font(.system(.subheadline, design: .rounded).weight(.semibold))
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(.ultraThinMaterial)
                    .overlay(
                        Capsule()
                            .stroke(Color.white.opacity(0.7), lineWidth: 0.8)
                    )
                    .clipShape(Capsule())
                
                Spacer()
                
                Text("ODS 3 • Saúde e Bem-Estar")
                    .font(.system(.caption, design: .rounded))
                    .foregroundColor(.secondary)
            }
            
            Text("Organize sua rede de apoio e lembre-se de quem faz bem para você.")
                .font(.system(.subheadline, design: .rounded))
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

// MARK: - Card de Círculo

struct CircleCard: View {
    let circle: CircleType
    let count: Int
    
    var body: some View {
        ZStack {
            // “Vidro” com leve gradiente e borda
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.75),
                            Color.white.opacity(0.55)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .background(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(.ultraThinMaterial)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(circle.color.opacity(0.9), lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.12),
                        radius: 10, x: 0, y: 6)
            
            VStack(spacing: 12) {
                // Ícone
                Image(systemName: circle.systemImageName)
                    .font(.system(size: 30, weight: .semibold))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(circle.color)
                    .padding(.top, 8)
                
                // Nome do círculo
                Text(circle.rawValue)
                    .font(.system(.headline, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
                    .minimumScaleFactor(0.85)
                    .lineLimit(2)
                
                // Quantidade de contatos
                Text("\(count) contato\(count == 1 ? "" : "s")")
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.secondary)
                    .padding(.bottom, 10)
            }
            .padding(.horizontal, 10)
        }
        .frame(maxWidth: .infinity, minHeight: 150)
    }
}

