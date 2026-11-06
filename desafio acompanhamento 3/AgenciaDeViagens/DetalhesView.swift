// Importação
import SwiftUI

// Tela de Detalhes do Pacote
struct DetalhesView: View {

    let pacote: PacoteViagem
    @Binding var favoritos: Set<UUID>

    // Controle do alerta de reserva (ilustrativo)
    @State private var exibirAlertaReserva = false

    // Body
    var body: some View {

        ScrollView {

            VStack(spacing: 20) {

                // Imagem de destaque + botão de favorito
                ZStack {
                    ImagemDestinoView(nome: pacote.imagemNome)
                        .frame(width: 260, height: 260)
                        .clipShape(RoundedRectangle(cornerRadius: 25))

                    BotaoFavoritoView(id: pacote.id, favoritos: $favoritos)
                        .font(.system(size: 34))
                        .frame(width: 70, height: 70)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                }
                .padding(12)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 32))

                // Localização + título
                VStack(alignment: .leading, spacing: 6) {
                    Label(pacote.local, systemImage: "mappin.and.ellipse")
                        .font(.headline)
                        .foregroundStyle(.blue)

                    Text(pacote.titulo)
                        .font(.largeTitle)
                        .bold()
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Divider()

                // Partida / Duração / Retorno
                HStack(alignment: .top) {
                    InformacaoView(titulo: "Partida", valor: pacote.dataPartida, alinhamento: .leading)

                    Spacer()

                    InformacaoView(titulo: "Duração", valor: "\(pacote.diarias) dias", alinhamento: .center)

                    Spacer()

                    InformacaoView(titulo: "Retorno", valor: pacote.dataChegada, alinhamento: .trailing)
                }

                Divider()

                // Hospedagem
                VStack(alignment: .leading, spacing: 8) {
                    Label("Hospedagem", systemImage: "bed.double")
                        .font(.headline)

                    Text(pacote.informacoesHotel)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

            }
            .padding()

        }
        .navigationTitle("Detalhes do Pacote")
        .navigationBarTitleDisplayMode(.inline)
        // Botão de reserva fixo na parte inferior
        .safeAreaInset(edge: .bottom) {
            Button {
                exibirAlertaReserva = true
            } label: {
                Text("Reservar por \(pacote.preco.emReais)")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .padding()
            .background(.bar)
        }
        .alert("Reserva solicitada", isPresented: $exibirAlertaReserva) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Sua solicitação para \"\(pacote.titulo)\" foi registrada. (Simulação - nenhum pagamento foi realizado.)")
        }

    }
}

// Componente reutilizável - bloco de informação (título + valor)
struct InformacaoView: View {

    let titulo: String
    let valor: String
    let alinhamento: HorizontalAlignment

    var body: some View {
        VStack(alignment: alinhamento, spacing: 4) {
            Text(titulo)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(valor)
                .font(.headline)
        }
    }
}

#Preview {
    NavigationStack {
        DetalhesView(pacote: PacoteViagem.exemplos[0], favoritos: .constant([]))
    }
}
