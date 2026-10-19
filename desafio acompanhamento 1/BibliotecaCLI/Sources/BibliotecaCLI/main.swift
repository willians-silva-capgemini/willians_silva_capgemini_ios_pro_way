import Foundation

let biblioteca = Biblioteca()

_ = biblioteca.adicionar(Livro(id: 1, titulo: "Dom Casmurro", autor: "Machado de Assis", anoPublicacao: 1899))
_ = biblioteca.adicionar(Livro(id: 2, titulo: "O Cortiço", autor: "Aluísio Azevedo", anoPublicacao: 1890))
_ = biblioteca.adicionar(LivroDigital(id: 3, titulo: "Clean Code", autor: "Robert C. Martin", anoPublicacao: 2008, tamanhoEmMB: 4.7))

func lerTexto(_ mensagem: String) -> String {
    print(mensagem, terminator: "")
    guard let linha = readLine() else {
        exit(0)
    }
    return linha.trimmingCharacters(in: .whitespaces)
}

func lerNumero(_ mensagem: String) -> Int {
    while true {
        if let numero = Int(lerTexto(mensagem)) {
            return numero
        }
        print("Valor inválido, digite um número.")
    }
}

func cadastrar() {
    let id = lerNumero("ID: ")
    if biblioteca.buscar(id: id) != nil {
        print("Já existe um livro com esse ID.")
        return
    }

    let titulo = lerTexto("Título: ")
    let autor = lerTexto("Autor: ")
    if titulo.isEmpty || autor.isEmpty {
        print("Título e autor são obrigatórios.")
        return
    }
    let ano = lerNumero("Ano de publicação: ")

    let livro: Livro
    if lerTexto("É digital? (s/n): ").lowercased() == "s" {
        let tamanho = Double(lerTexto("Tamanho em MB: ").replacingOccurrences(of: ",", with: ".")) ?? 0
        livro = LivroDigital(id: id, titulo: titulo, autor: autor, anoPublicacao: ano, tamanhoEmMB: tamanho)
    } else {
        livro = Livro(id: id, titulo: titulo, autor: autor, anoPublicacao: ano)
    }

    if biblioteca.adicionar(livro) {
        print("Livro cadastrado!")
    }
}

func listar() {
    let livros = biblioteca.listar()
    if livros.isEmpty {
        print("Nenhum livro cadastrado.")
        return
    }
    for livro in livros {
        print("--------------------")
        livro.exibirDetalhes()
    }
    print("--------------------")
    print("Total: \(livros.count) livro(s)")
}

func buscarPorId() {
    let id = lerNumero("ID do livro: ")
    if let livro = biblioteca.buscar(id: id) {
        livro.exibirDetalhes()
    } else {
        print("Livro não encontrado.")
    }
}

func buscarPorTitulo() {
    let texto = lerTexto("Digite o título (ou parte dele): ")
    let encontrados = biblioteca.buscar(titulo: texto)
    if encontrados.isEmpty {
        print("Nenhum livro encontrado.")
        return
    }
    for livro in encontrados {
        print("--------------------")
        livro.exibirDetalhes()
    }
}

func editar() {
    let id = lerNumero("ID do livro: ")
    guard let livro = biblioteca.buscar(id: id) else {
        print("Livro não encontrado.")
        return
    }

    print("Deixe em branco para não alterar.")
    livro.alterarTitulo(lerTexto("Novo título (\(livro.titulo)): "))
    livro.alterarAutor(lerTexto("Novo autor (\(livro.autor)): "))
    if let ano = Int(lerTexto("Novo ano (\(livro.anoPublicacao)): ")) {
        livro.alterarAno(ano)
    }

    let status = lerTexto("Emprestado? (s/n): ").lowercased()
    if status == "s" {
        _ = livro.emprestar()
    } else if status == "n" {
        _ = livro.devolver()
    }

    print("Livro atualizado!")
}

func emprestar() {
    let id = lerNumero("ID do livro: ")
    guard let livro = biblioteca.buscar(id: id) else {
        print("Livro não encontrado.")
        return
    }
    if livro.emprestar() {
        print("Livro emprestado!")
    } else {
        print("Esse livro já está emprestado.")
    }
}

func devolver() {
    let id = lerNumero("ID do livro: ")
    guard let livro = biblioteca.buscar(id: id) else {
        print("Livro não encontrado.")
        return
    }
    if livro.devolver() {
        print("Livro devolvido!")
    } else {
        print("Esse livro não estava emprestado.")
    }
}

func remover() {
    let id = lerNumero("ID do livro: ")
    if biblioteca.remover(id: id) {
        print("Livro removido.")
    } else {
        print("Livro não encontrado.")
    }
}

var rodando = true

while rodando {
    print("\n===== BIBLIOTECA =====")
    print("1 - Cadastrar livro")
    print("2 - Listar livros")
    print("3 - Buscar por ID")
    print("4 - Buscar por título")
    print("5 - Editar livro")
    print("6 - Emprestar livro")
    print("7 - Devolver livro")
    print("8 - Remover livro")
    print("0 - Sair")

    let opcao = lerNumero("Opção: ")
    print()

    switch opcao {
    case 1: cadastrar()
    case 2: listar()
    case 3: buscarPorId()
    case 4: buscarPorTitulo()
    case 5: editar()
    case 6: emprestar()
    case 7: devolver()
    case 8: remover()
    case 0:
        rodando = false
        print("Saindo...")
    default:
        print("Opção inválida!")
    }
}
