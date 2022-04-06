require_relative 'pecas.rb'
class Jogador
    attr_reader :nome, :pontos, :indice
    def initialize(nome,indice)
        @nome = nome
        @pontos = 0
        @indice = indice
    end

end

