class Pecas
    attr_reader :texto, :tipo, :jogador

    def initialize (texto,jogador,tipo)
        @texto = texto
        @tipo = tipo
        @jogador = jogador

    end

    def self.peao(jogador,indice)
        indice == 1 ? Pecas.new('♟',jogador,'peao') : Pecas.new('♙',jogador,'peao')
    end
    

    def self.cavalo(jogador,indice)
        indice == 1 ? Pecas.new('♞',jogador,'cavalo') : Pecas.new('♘',jogador,'cavalo')
    end

    def self.torre(jogador,indice)
        indice == 1 ? Pecas.new('♜',jogador,'torre') : Pecas.new('♖',jogador,'torre')
    end

    def self.bispo(jogador,indice)
        indice == 1 ? Pecas.new('♝',jogador,'bispo') : Pecas.new('♗',jogador,'bispo')
    end

    def self.rainha(jogador,indice)
        indice == 1 ? Pecas.new('♛',jogador,'rainha') : Pecas.new('♕',jogador,'rainha')
    end

    def self.rei(jogador,indice)
        indice == 1 ? Pecas.new('♚',jogador,'rei') : Pecas.new('♔',jogador,'rei')
    end
end
