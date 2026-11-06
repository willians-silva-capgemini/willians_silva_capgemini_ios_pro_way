// Importação
import Foundation

// Modelo de Pacote de Viagem
// Identifiable -> utilizado nas listas
// Hashable     -> utilizado na navegação (NavigationLink(value:))
struct PacoteViagem: Identifiable, Hashable {
    let id = UUID()
    let titulo: String
    let diarias: Int
    let local: String
    let dataPartida: String
    let dataChegada: String
    let informacoesHotel: String
    let imagemNome: String
    let preco: Double
}

// Formatação de preço em reais com duas casas decimais (ex.: R$ 5.499,00)
extension Double {
    var emReais: String {
        self.formatted(
            .currency(code: "BRL")
            .locale(Locale(identifier: "pt_BR"))
            .precision(.fractionLength(2))
        )
    }
}

// Dados de exemplo (nacionais e internacionais)
// "static let" garante que os IDs sejam gerados uma única vez
extension PacoteViagem {
    static let exemplos: [PacoteViagem] = [
        PacoteViagem(
            titulo: "Magia em Paris",
            diarias: 7,
            local: "Paris, França",
            dataPartida: "10/05/2027",
            dataChegada: "17/05/2027",
            informacoesHotel: "Hotel Louvre Elegance - 4 Estrelas com café da manhã incluso.",
            imagemNome: "paris",
            preco: 5499.00
        ),
        PacoteViagem(
            titulo: "Verão em Londres",
            diarias: 10,
            local: "Londres, Inglaterra",
            dataPartida: "02/07/2027",
            dataChegada: "12/07/2027",
            informacoesHotel: "The Royal Thames Hotel - 4 Estrelas, próximo ao Big Ben, café da manhã incluso.",
            imagemNome: "londres",
            preco: 7800.00
        ),
        PacoteViagem(
            titulo: "Aventura em Kyoto",
            diarias: 8,
            local: "Kyoto, Japão",
            dataPartida: "25/03/2027",
            dataChegada: "02/04/2027",
            informacoesHotel: "Ryokan Sakura - hospedagem tradicional japonesa com café da manhã e jantar.",
            imagemNome: "kyoto",
            preco: 6200.00
        ),
        PacoteViagem(
            titulo: "Luzes de Nova York",
            diarias: 6,
            local: "Nova York, EUA",
            dataPartida: "15/12/2027",
            dataChegada: "21/12/2027",
            informacoesHotel: "Times Square Plaza Hotel - 4 Estrelas, a poucos passos da Broadway.",
            imagemNome: "novayork",
            preco: 6850.00
        ),
        PacoteViagem(
            titulo: "Sol em Roma",
            diarias: 7,
            local: "Roma, Itália",
            dataPartida: "05/09/2027",
            dataChegada: "12/09/2027",
            informacoesHotel: "Hotel Colosseo Antico - 3 Estrelas com café da manhã incluso.",
            imagemNome: "roma",
            preco: 4900.00
        ),
        PacoteViagem(
            titulo: "Inverno em Gramado",
            diarias: 4,
            local: "Gramado, Brasil",
            dataPartida: "18/07/2027",
            dataChegada: "22/07/2027",
            informacoesHotel: "Pousada Vale das Hortênsias - café colonial incluso e lareira no quarto.",
            imagemNome: "gramado",
            preco: 2350.00
        ),
        PacoteViagem(
            titulo: "Paraíso em Noronha",
            diarias: 5,
            local: "Fernando de Noronha, Brasil",
            dataPartida: "10/10/2027",
            dataChegada: "15/10/2027",
            informacoesHotel: "Pousada Mar de Dentro - vista para o mar, café da manhã e passeio de barco inclusos.",
            imagemNome: "noronha",
            preco: 4590.00
        ),
        PacoteViagem(
            titulo: "Cultura em Salvador",
            diarias: 5,
            local: "Salvador, Brasil",
            dataPartida: "20/02/2027",
            dataChegada: "25/02/2027",
            informacoesHotel: "Hotel Pelourinho Colonial - 4 Estrelas no Centro Histórico, café da manhã incluso.",
            imagemNome: "salvador",
            preco: 1890.00
        )
    ]
}
