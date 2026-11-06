// Importação
import SwiftUI

// Modelo de Aluno
struct Aluno: Identifiable {
    let id = UUID()
    let nome: String
    let nota1: Double
    let nota2: Double

    // Média final (calculada automaticamente)
    var media: Double {
        (nota1 + nota2) / 2
    }

    // Situação acadêmica
    var aprovado: Bool {
        media >= 7.0
    }

    var situacao: String {
        aprovado ? "Aprovado" : "Reprovado"
    }

    var corSituacao: Color {
        aprovado ? .green : .red
    }
}

// Tela Principal (única tela do aplicativo)
struct ContentView: View {

    // Campos do formulário
    @State private var nome = ""
    @State private var nota1 = ""
    @State private var nota2 = ""

    // Lista de alunos (somente em memória)
    @State private var alunos: [Aluno] = []

    // Mensagem de validação
    @State private var mensagemErro = ""

    // Resumo da turma (calculado a partir da lista)
    var totalAprovados: Int {
        alunos.filter { $0.aprovado }.count
    }

    var totalReprovados: Int {
        alunos.count - totalAprovados
    }

    // Body
    var body: some View {

        ScrollView {

            VStack(spacing: 30) {

                // Cabeçalho
                VStack(spacing: 10) {
                    Image(systemName: "graduationcap.fill")
                        .font(.system(size: 50))
                        .foregroundStyle(.orange)

                    Text("Minha Turma")
                        .font(.largeTitle)
                        .bold()

                    Text("Cadastre alunos e acompanhe os resultados.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.top)

                // Formulário de cadastro
                VStack(alignment: .leading, spacing: 12) {
                    Label("Cadastrar aluno", systemImage: "person.badge.plus")
                        .font(.title3)
                        .bold()

                    Text("Nome do aluno")
                        .font(.subheadline)

                    TextField("Digite o nome completo", text: $nome)
                        .textFieldStyle(.roundedBorder)

                    HStack(spacing: 12) {
                        VStack(alignment: .leading) {
                            Text("Nota 1")
                                .font(.subheadline)

                            TextField("0 a 10", text: $nota1)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.decimalPad)
                        }

                        VStack(alignment: .leading) {
                            Text("Nota 2")
                                .font(.subheadline)

                            TextField("0 a 10", text: $nota2)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.decimalPad)
                        }
                    }

                    // Mensagem de erro de validação
                    if !mensagemErro.isEmpty {
                        Label(mensagemErro, systemImage: "exclamationmark.triangle.fill")
                            .font(.caption)
                            .foregroundStyle(.red)
                    }

                    Button {
                        cadastrar()
                    } label: {
                        Label("Cadastrar aluno", systemImage: "plus.circle.fill")
                            .bold()
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.top, 8)
                }
                .padding()

                // Resumo da turma
                VStack(alignment: .leading, spacing: 15) {
                    Text("Resumo da turma")
                        .font(.title3)
                        .bold()

                    HStack {
                        ResumoItemView(icone: "person.3.fill", cor: .blue, valor: alunos.count, titulo: "Alunos")
                        ResumoItemView(icone: "checkmark.circle.fill", cor: .green, valor: totalAprovados, titulo: "Aprovados")
                        ResumoItemView(icone: "xmark.circle.fill", cor: .red, valor: totalReprovados, titulo: "Reprovados")
                    }
                }

                // Listagem dos alunos
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text("Alunos cadastrados")
                            .font(.title3)
                            .bold()

                        Spacer()

                        Text("\(alunos.count) \(alunos.count == 1 ? "registro" : "registros")")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    if alunos.isEmpty {
                        ContentUnavailableView(
                            "Nenhum aluno cadastrado",
                            systemImage: "person.crop.rectangle.stack",
                            description: Text("Os alunos cadastrados aparecerão aqui.")
                        )
                    } else {
                        ForEach(alunos) { aluno in
                            AlunoCardView(aluno: aluno) {
                                remover(aluno)
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .animation(.default, value: alunos.count)

    }

    // Converte o texto digitado em nota (aceita vírgula ou ponto)
    func converterNota(_ texto: String) -> Double? {
        let valor = texto
            .trimmingCharacters(in: .whitespaces)
            .replacingOccurrences(of: ",", with: ".")

        guard let nota = Double(valor), nota >= 0, nota <= 10 else {
            return nil
        }

        return nota
    }

    // Valida os campos e cadastra o aluno
    func cadastrar() {
        let nomeLimpo = nome.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !nomeLimpo.isEmpty else {
            mensagemErro = "Informe o nome do aluno."
            return
        }

        guard let n1 = converterNota(nota1) else {
            mensagemErro = "A nota 1 deve ser um número entre 0 e 10."
            return
        }

        guard let n2 = converterNota(nota2) else {
            mensagemErro = "A nota 2 deve ser um número entre 0 e 10."
            return
        }

        alunos.append(Aluno(nome: nomeLimpo, nota1: n1, nota2: n2))

        // Limpar os campos após o cadastro
        nome = ""
        nota1 = ""
        nota2 = ""
        mensagemErro = ""
    }

    // Remove somente o aluno selecionado
    func remover(_ aluno: Aluno) {
        alunos.removeAll { $0.id == aluno.id }
    }
}

// Componente reutilizável - item do resumo da turma
struct ResumoItemView: View {

    let icone: String
    let cor: Color
    let valor: Int
    let titulo: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Image(systemName: icone)
                .font(.title2)
                .foregroundStyle(cor)

            Text("\(valor)")
                .font(.largeTitle)
                .bold()

            Text(titulo)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// Componente reutilizável - card do aluno
struct AlunoCardView: View {

    let aluno: Aluno
    let aoRemover: () -> Void

    var body: some View {
        HStack(spacing: 15) {
            VStack(alignment: .leading, spacing: 6) {
                Text(aluno.nome)
                    .font(.headline)

                HStack(spacing: 12) {
                    Text("Nota 1: \(aluno.nota1, specifier: "%.1f")")
                    Text("Nota 2: \(aluno.nota2, specifier: "%.1f")")
                }
                .font(.caption)
                .foregroundStyle(.secondary)

                HStack(spacing: 10) {
                    Text("Média: \(aluno.media, specifier: "%.1f")")
                        .font(.subheadline)
                        .bold()

                    Text(aluno.situacao)
                        .font(.caption)
                        .bold()
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(aluno.corSituacao)
                        .clipShape(Capsule())
                }
            }

            Spacer()

            Button(role: .destructive) {
                aoRemover()
            } label: {
                Image(systemName: "trash")
                    .font(.title3)
                    .foregroundStyle(.red)
            }
            .buttonStyle(.borderless)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    ContentView()
}
