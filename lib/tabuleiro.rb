require_relative 'cores.rb'
require_relative 'pecas.rb'
require 'pry-byebug'
require_relative 'casa.rb'

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
    def colocar_pecas(jogador)
        indice = jogador.indice
        contador = 0
        array = [Pecas.torre(jogador,indice),Pecas.cavalo(jogador,indice),Pecas.bispo(jogador,indice),Pecas.rainha(jogador,indice),Pecas.rei(jogador,indice),Pecas.bispo(jogador,indice),Pecas.cavalo(jogador,indice),Pecas.torre(jogador,indice)]
        for j in 'a'..'h'
            indice == 1 ? casa = encontrar_posicao("#{j}2") : casa = encontrar_posicao("#{j}7")
            casa.incluir_peca(Pecas.peao(jogador,indice))
            indice == 1 ? linha = 1 : linha = 8
            casa = encontrar_posicao("#{j}#{linha}")
            casa.incluir_peca(array[contador])
            contador += 1
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
        p
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

    def retornar_jogador_indice_casa(casa)
        casa = encontrar_posicao(casa)
        casa != nil ? peca = casa.peca : peca = nil
        peca != nil ? jogador = peca.jogador : jogador = nil
        jogador != nil ? indice = jogador.indice : indice = nil
    end
    
    def movimentacao_invalida? (casa)
        encontrar_posicao(casa) == nil || existe_peca?(casa)
    end

    def atualizar_movimentacoes_permitidas
        @casas.each do |casa|
            casa.peca == nil ? next : casa.atualizar_posicoes_possiveis(self)
        end
    end

end

