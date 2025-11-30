# Connectfy Bem Estar 🌿

**Connectfy Bem Estar** é um subproduto do ecossistema Connectfy, focado em ajudar a organizar a sua **rede de apoio**: família, amigos próximos, contatos de trabalho e profissionais/terapeutas.

A ideia é simples: lembrar de quem faz bem pra você e manter esses vínculos ativos, sem virar mais um fardo caótica.

---

## ✨ Funcionalidades

- Tela inicial com **menu de círculos sociais**:
  - 👨‍👩‍👧 **Família**
  - 🤝 **Amigos Próximos**
  - 💼 **Trabalho**
  - 🧠 **Profissionais / Terapia**

- Cada círculo exibe:
  - Quantidade de contatos
  - Visual com gradientes suaves

- Lista de pessoas por círculo:
  - Nome, localidade e informação de última interação
  - Indicador visual de “faz tempo” / “precisa de contato”
  - Acesso rápido para edição do contato

- Formulário de pessoa:
  - Nome
  - Círculo
  - Localidade
  - Data da última interação (opcional)
  - Exclusão de contato (modo edição)

---

## 🧱 Stack técnica

- **Plataforma:** iOS (Swift)
- **UI:** SwiftUI
- **Persistência futura:** espaço reservado para evoluir de estado em memória para **SwiftData** ou outra camada de dados atualmente em implementacao.

---

## 📂 Estrutura do projeto

ConnectfyBemEstar/
├─ Connectfy_Bem_EstarApp.swift   # Ponto de entrada do app
├─ ContentView.swift              # View padrão do template
├─ Models.swift                   # Modelos: CircleType, Person, AppState (em fase DEV)
├─ CirclesMenuView.swift          # Tela inicial com os círculos
├─ PeopleListView.swift           # Lista de pessoas por círculo
├─ PersonFormView.swift           # Form de criação/edição de pessoa
├─ Assets.xcassets                # Cores, ícones, etc.
└─ Tests/                         # Testes automáticos gerados pelo Xcode
