require_relative 'cores.rb'
require_relative 'pecas.rb'
require_relative 'casa.rb'
require 'pry-byebug'
# binding.pry


class Tabuleiro
    attr_reader :casas

    def initialize 
        @casas = self.criar_tabuleiro
    end
    
    private
    def criar_tabuleiro
        casas = []
        for i in 'a' .. 'h' #linha
            for j in 1 .. 8 #coluna
                posicao = ["#{i}#{j}"]
                casas << Casa.new(posicao)
            end
        end
        casas
    end

    public
    def encontrar_posicao(posicao)
        casa = nil
        @casas.each do |valor|
            break if casa != nil
            valor.posicao[0] == posicao ? casa = valor : next
        end
        casa
    end

    public
    def colocar_pecas
        linha = 1
        for i in 1..2
            array = [Pecas.torre(i),Pecas.cavalo(i),Pecas.bispo(i),Pecas.rainha(i),Pecas.rei(i),Pecas.bispo(i),Pecas.cavalo(i),Pecas.torre(i)]
            contador = 0
            for j in 'a'..'h'
                casa = encontrar_posicao("#{j}#{linha}")
                casa.incluir_peca(array[contador])
                casa = encontrar_posicao("#{j}2")
                casa.incluir_peca(Pecas.peao(1))
                casa = encontrar_posicao("#{j}7")
                casa.incluir_peca(Pecas.peao(2)) 
                contador += 1
            end
        linha = 8
        end
    end


    def visualizar_tabuleiro
        preto = 'preto'
        cinza = 'cinza'
        cor_atual = preto
        8.downto(1) do |j| #linha
            print "#{j} "
            for i in 'a'..'h' #coluna
            casa = encontrar_posicao("#{i}#{j}")
            peca = casa.peca
                peca.class == NilClass ? texto = nil : texto = peca.texto
                print("#{Cores.fundo(cor_atual,texto)}")
                cor_atual == preto ? cor_atual = cinza : cor_atual = preto
            end
            puts ""
            cor_atual == preto ? cor_atual = cinza : cor_atual = preto
        end
        puts "   a  b  c  d  e  f  g  h "
    end

    def mover_peca(casa_inicial,casa_final)
        if existe_peca?(casa_inicial)
           casa_inicial = encontrar_posicao(casa_inicial)
        else  
            puts("Não existe nenhuma peça sua aqui!")
            return visualizar_tabuleiro
        end
        casa_final = encontrar_posicao(casa_final)
        casa_final.incluir_peca(casa_inicial.peca)
        casa_inicial.incluir_peca(nil)
    end

    def existe_peca? (casa)
        casa = encontrar_posicao(casa)
        casa.peca != nil ? true : false
    end


    def atualizar_movimentacoes_permitidas
        @casas.each do |casa|
            casa.peca == nil ? casa.atualizar_posicao_vazia : casa.atualizar_posicoes_possiveis(self)
            p casa
        end

    end

end

tabuleiro = Tabuleiro.new
tabuleiro.colocar_pecas
tabuleiro.visualizar_tabuleiro
tabuleiro.mover_peca("a2","a3")
puts "------------------------"
tabuleiro.visualizar_tabuleiro
puts "------------------------"
tabuleiro.mover_peca("a7","a4")
tabuleiro.atualizar_movimentacoes_permitidas
tabuleiro.mover_peca("b2","b3")
tabuleiro.atualizar_movimentacoes_permitidas
tabuleiro.mover_peca("b3","b4")
tabuleiro.atualizar_movimentacoes_permitidas
tabuleiro.visualizar_tabuleiro
