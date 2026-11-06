// Importação
import SwiftUI

// Tela Inicial - Explorar Viagens
struct ContentView: View {

    // Pacotes disponíveis
    let pacotes = PacoteViagem.exemplos

    // IDs dos pacotes favoritados (estado compartilhado entre as telas)
    @State private var favoritos: Set<UUID> = []

    // Body
    var body: some View {

        // NavigationStack
        NavigationStack {

            List(pacotes) { pacote in
                NavigationLink(value: pacote) {
                    PacoteLinhaView(pacote: pacote, favoritos: $favoritos)
                }
            }
            .navigationTitle("Explorar Viagens")
            .navigationDestination(for: PacoteViagem.self) { pacote in
                DetalhesView(pacote: pacote, favoritos: $favoritos)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        FavoritosView(pacotes: pacotes, favoritos: $favoritos)
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: favoritos.isEmpty ? "heart" : "heart.fill")
                                .foregroundStyle(.red)

                            Text("\(favoritos.count)")
                                .bold()
                                .foregroundStyle(.primary)
                        }
                    }
                    .accessibilityLabel("Favoritos: \(favoritos.count)")
                }
            }

        }

    }
}

// Tela de Favoritos - Meus Favoritos
struct FavoritosView: View {

    let pacotes: [PacoteViagem]
    @Binding var favoritos: Set<UUID>

    // Somente os pacotes favoritados
    var pacotesFavoritos: [PacoteViagem] {
        pacotes.filter { favoritos.contains($0.id) }
    }

    // Body
    var body: some View {

        Group {
            if pacotesFavoritos.isEmpty {
                ContentUnavailableView(
                    "Nenhum favorito ainda",
                    systemImage: "heart.slash",
                    description: Text("Toque no coração de um pacote para adicioná-lo aos seus favoritos.")
                )
            } else {
                List(pacotesFavoritos) { pacote in
                    NavigationLink(value: pacote) {
                        PacoteLinhaView(pacote: pacote, favoritos: $favoritos)
                    }
                }
            }
        }
        .navigationTitle("Meus Favoritos")
        .animation(.default, value: favoritos)

    }
}

// Componente reutilizável - linha da lista de pacotes
struct PacoteLinhaView: View {

    let pacote: PacoteViagem
    @Binding var favoritos: Set<UUID>

    var body: some View {

        HStack(spacing: 15) {

            ImagemDestinoView(nome: pacote.imagemNome)
                .frame(width: 90, height: 90)
                .clipShape(RoundedRectangle(cornerRadius: 15))

            VStack(alignment: .leading, spacing: 4) {
                Text(pacote.titulo)
                    .font(.headline)

                Text(pacote.local)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text("\(pacote.diarias) diárias • \(pacote.preco.emReais)")
                    .font(.caption)
                    .bold()
                    .foregroundStyle(.blue)
            }

            Spacer()

            BotaoFavoritoView(id: pacote.id, favoritos: $favoritos)
                .font(.title2)
        }
        .padding(.vertical, 6)

    }
}

// Componente reutilizável - botão de favoritar/desfavoritar
struct BotaoFavoritoView: View {

    let id: UUID
    @Binding var favoritos: Set<UUID>

    var favoritado: Bool {
        favoritos.contains(id)
    }

    var body: some View {
        Button {
            if favoritado {
                favoritos.remove(id)
            } else {
                favoritos.insert(id)
            }
        } label: {
            Image(systemName: favoritado ? "heart.fill" : "heart")
                .foregroundStyle(favoritado ? .red : .gray)
                .contentTransition(.symbolEffect(.replace))
        }
        // .borderless evita que o toque no botão abra a tela de detalhes
        .buttonStyle(.borderless)
        .accessibilityLabel(favoritado ? "Remover dos favoritos" : "Adicionar aos favoritos")
    }
}

// Componente reutilizável - imagem do destino
// Usa a imagem do Assets.xcassets; se não existir, exibe um símbolo no lugar
struct ImagemDestinoView: View {

    let nome: String

    var body: some View {
        if let imagem = UIImage(named: nome) {
            Image(uiImage: imagem)
                .resizable()
                .scaledToFill()
        } else {
            ZStack {
                LinearGradient(colors: [.blue, .teal], startPoint: .topLeading, endPoint: .bottomTrailing)

                Image(systemName: "airplane.departure")
                    .resizable()
                    .scaledToFit()
                    .padding(22)
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    ContentView()
}
