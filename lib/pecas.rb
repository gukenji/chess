class Pecas
    attr_reader :texto, :tipo, :jogador

    def initialize (texto,jogador,tipo)
        @texto = texto
        @tipo = tipo
        @jogador = jogador

    end

    def self.peao(jogador)
        jogador == 1 ? Pecas.new('♟',jogador,'peao') : Pecas.new('♙',jogador,'peao')
    end
    

    def self.cavalo(jogador)
        jogador == 1 ? Pecas.new('♞',jogador,'cavalo') : Pecas.new('♘',jogador,'cavalo')
    end

    def self.torre(jogador)
        jogador == 1 ? Pecas.new('♜',jogador,'torre') : Pecas.new('♖',jogador,'torre')
    end

    def self.bispo(jogador)
        jogador == 1 ? Pecas.new('♝',jogador,'bispo') : Pecas.new('♗',jogador,'bispo')
    end

    def self.rainha(jogador)
        jogador == 1 ? Pecas.new('♛',jogador,'rainha') : Pecas.new('♕',jogador,'rainha')
    end

    def self.rei(jogador)
        jogador == 1 ? Pecas.new('♚',jogador,'rei') : Pecas.new('♔',jogador,'rei')
    end
end
