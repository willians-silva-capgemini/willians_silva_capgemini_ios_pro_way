class Livro: Documento {
    let id: Int
    private(set) var titulo: String
    private(set) var autor: String
    private(set) var anoPublicacao: Int
    private(set) var isEmprestado: Bool = false

    init(id: Int, titulo: String, autor: String, anoPublicacao: Int) {
        self.id = id
        self.titulo = titulo
        self.autor = autor
        self.anoPublicacao = anoPublicacao
    }

    func emprestar() -> Bool {
        if isEmprestado {
            return false
        }
        isEmprestado = true
        return true
    }

    func devolver() -> Bool {
        if !isEmprestado {
            return false
        }
        isEmprestado = false
        return true
    }

    func alterarTitulo(_ novoTitulo: String) {
        if !novoTitulo.isEmpty {
            titulo = novoTitulo
        }
    }

    func alterarAutor(_ novoAutor: String) {
        if !novoAutor.isEmpty {
            autor = novoAutor
        }
    }

    func alterarAno(_ novoAno: Int) {
        if novoAno > 0 {
            anoPublicacao = novoAno
        }
    }

    func exibirDetalhes() {
        print("ID: \(id)")
        print("Título: \(titulo)")
        print("Autor: \(autor)")
        print("Ano: \(anoPublicacao)")
        print("Status: \(isEmprestado ? "Emprestado" : "Disponível")")
    }
}
