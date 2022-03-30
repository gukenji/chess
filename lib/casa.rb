require 'pry-byebug'
require_relative 'tabuleiro.rb'

 class Casa
    attr_reader :posicao, :peca, :posicoes_possiveis
    def initialize(posicao,peca = nil)
        @posicao = posicao
        @peca = peca
        @posicoes_possiveis = []
    end

    def incluir_peca(peca)
        @peca = peca
    end

    def atualizar_posicao_vazia
        @posicoes_possiveis = []
    end

    def atualizar_posicoes_possiveis(tabuleiro)
        tipo = @peca.tipo
        case tipo
        when 'peao'
            atualizar_peao(tabuleiro)
        when 'cavalo' 
            atualizar_cavalo(tabuleiro)
        end
    end

    def atualizar_peao(tabuleiro)
        jogador = @peca.jogador
        coluna_possivel = @posicao[0].slice(0)
        jogador == 1 ? linha_possivel = @posicao[0].slice(1).to_i+1 : linha_possivel = @posicao[0].slice(1).to_i-1
        casa_possivel = "#{coluna_possivel}#{linha_possivel}"
        @posicoes_possiveis << casa_possivel unless tabuleiro.existe_peca?(casa_possivel)
        @posicoes_possiveis.uniq!
    end

    def atualizar_cavalo(tabuleiro)
        coluna_atual = @posicao[0].slice(0)
        linha_atual = @posicao[0].slice(1).to_i

        @posicoes_possiveis << "#{(coluna_atual.ord+1).chr}#{linha_atual + 2}" unless (coluna_atual.ord+1) > 104 || linha_atual + 2 > 8 || tabuleiro.existe_peca?("#{(coluna_atual.ord+1).chr}#{linha_atual + 2}")
        @posicoes_possiveis << "#{(coluna_atual.ord+1).chr}#{linha_atual - 2}" unless (coluna_atual.ord+1) > 104 || linha_atual - 2 < 1 || tabuleiro.existe_peca?("#{(coluna_atual.ord+1).chr}#{linha_atual - 2}") 
        @posicoes_possiveis << "#{(coluna_atual.ord-1).chr}#{linha_atual + 2}" unless (coluna_atual.ord-1) < 97 || linha_atual + 2 > 8 || tabuleiro.existe_peca?("#{(coluna_atual.ord-1).chr}#{linha_atual + 2}")
        @posicoes_possiveis << "#{(coluna_atual.ord-1).chr}#{linha_atual - 2}" unless (coluna_atual.ord-1) < 97 || linha_atual - 2 < 1 || tabuleiro.existe_peca?("#{(coluna_atual.ord-1).chr}#{linha_atual - 2}")
        @posicoes_possiveis << "#{(coluna_atual.ord+2).chr}#{linha_atual + 1}" unless (coluna_atual.ord+2) > 104 || linha_atual + 1 > 8 || tabuleiro.existe_peca?("#{(coluna_atual.ord+2).chr}#{linha_atual + 1}")
        @posicoes_possiveis << "#{(coluna_atual.ord+2).chr}#{linha_atual - 1}" unless (coluna_atual.ord+2) > 104 || linha_atual - 1 < 1 || tabuleiro.existe_peca?("#{(coluna_atual.ord+2).chr}#{linha_atual - 1}")
        @posicoes_possiveis << "#{(coluna_atual.ord-2).chr}#{linha_atual + 1}" unless (coluna_atual.ord-2) < 97 || linha_atual + 1 > 8 || tabuleiro.existe_peca?("#{(coluna_atual.ord-2).chr}#{linha_atual + 1}")
        @posicoes_possiveis << "#{(coluna_atual.ord-2).chr}#{linha_atual - 1}" unless (coluna_atual.ord-2) < 97 || linha_atual - 1 < 1 || tabuleiro.existe_peca?("#{(coluna_atual.ord-2).chr}#{linha_atual - 1}")

        @posicoes_possiveis.uniq!
    end

    def atualizar_torre(tabuleiro)
        jogador = @peca.jogador
        coluna_atual = @posicao[0].slice(0)
        linha_atual = @posicao[0].slice(1).to_i


    end

end
