class Biblioteca {
    private var livros: [Livro] = []

    func adicionar(_ livro: Livro) -> Bool {
        if buscar(id: livro.id) != nil {
            return false
        }
        livros.append(livro)
        return true
    }

    func listar() -> [Livro] {
        return livros
    }

    func buscar(id: Int) -> Livro? {
        for livro in livros where livro.id == id {
            return livro
        }
        return nil
    }

    func buscar(titulo: String) -> [Livro] {
        return livros.filter { $0.titulo.lowercased().contains(titulo.lowercased()) }
    }

    func remover(id: Int) -> Bool {
        if let index = livros.firstIndex(where: { $0.id == id }) {
            livros.remove(at: index)
            return true
        }
        return false
    }
}
