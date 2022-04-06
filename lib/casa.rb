require 'pry-byebug'

 class Casa
    attr_reader :posicao, :peca, :posicoes_possiveis, :capturas_possiveis

    def initialize(posicao,peca = nil)
        @posicao = posicao
        @peca = peca
        @posicoes_possiveis = []
        @capturas_possiveis =[]
    end

    def retirar_rei
        @peca = nil
        @posicoes_possiveis = []
        @capturas_possiveis = []
    end


    def incluir_peca(peca)
        @peca = peca
    end

    def atualizar_posicoes_possiveis(tabuleiro)
        tipo = @peca.tipo
        case tipo
        when 'peao'
            atualizar_peao(tabuleiro)
        when 'cavalo' 
            atualizar_cavalo(tabuleiro)
        when 'torre'
            atualizar_torre(tabuleiro)
        when 'bispo'
            atualizar_bispo(tabuleiro)
        when 'rainha'
            atualizar_rainha(tabuleiro)
        when 'rei'
            atualizar_rei(tabuleiro)
        end
    end

    def atualizar_peao(tabuleiro)
        @posicoes_possiveis = []
        @capturas_possiveis = []
        jogador = @peca.jogador
        indice = jogador.indice
        if indice == 1
            atualizar_posicao(movimento_vertical(1),tabuleiro)
            casa = movimento_misto(1,1)
            atualizar_captura(casa,tabuleiro)
            casa = movimento_misto(-1,1)
            atualizar_captura(casa,tabuleiro)

        else
            atualizar_posicao(movimento_vertical(-1),tabuleiro)
            casa = movimento_misto(1,-1)
            atualizar_captura(casa,tabuleiro)
            casa = movimento_misto(-1,-1)
            atualizar_captura(casa,tabuleiro)
        end
        @posicoes_possiveis.uniq!
    
    end

    def atualizar_torre(tabuleiro)
        #movimentos
        cima, baixo, direita, esquerda = true
        @posicoes_possiveis = []
        @capturas_possiveis = []
        for i in 1..8 
            unless cima == false
                casa = movimento_vertical(i)
                if tabuleiro.movimentacao_invalida?(casa)
                    cima = false
                    atualizar_captura(casa,tabuleiro)
                else
                    @posicoes_possiveis << casa
                end
            end
            unless baixo == false
                casa = movimento_vertical(-i)
                if tabuleiro.movimentacao_invalida?(casa)
                    baixo = false
                    atualizar_captura(casa,tabuleiro)
                else
                    @posicoes_possiveis << casa
                end
            end
            unless direita == false
                casa = movimento_horizontal(i)
                if tabuleiro.movimentacao_invalida?(casa)
                    direita = false
                    atualizar_captura(casa,tabuleiro)
                else
                    @posicoes_possiveis << casa
                end
            end
            unless esquerda == false
                casa = movimento_horizontal(-i)
                if tabuleiro.movimentacao_invalida?(casa)
                    esquerda = false
                    atualizar_captura(casa,tabuleiro)
                else
                    @posicoes_possiveis << casa
                end
            end
            @posicoes_possiveis.uniq!
        end

        
    end

    def atualizar_cavalo(tabuleiro)
        @posicoes_possiveis = []
        @capturas_possiveis = []

        casa = movimento_misto(1,2)
        atualizar_captura(casa,tabuleiro)
        atualizar_posicao(casa,tabuleiro)

        casa = movimento_misto(-1,2)
        atualizar_captura(casa,tabuleiro)
        atualizar_posicao(casa,tabuleiro)

        casa = movimento_misto(1,-2)
        atualizar_captura(casa,tabuleiro)
        atualizar_posicao(casa,tabuleiro)

        casa = movimento_misto(-1,-2)
        atualizar_captura(casa,tabuleiro)
        atualizar_posicao(casa,tabuleiro)

        casa = movimento_misto(2,1)
        atualizar_captura(casa,tabuleiro)
        atualizar_posicao(casa,tabuleiro)

        casa = movimento_misto(-2,1)
        atualizar_captura(casa,tabuleiro)
        atualizar_posicao(casa,tabuleiro)

        casa = movimento_misto(2,-1)
        atualizar_captura(casa,tabuleiro)
        atualizar_posicao(casa,tabuleiro)

        casa = movimento_misto(-2,-1)
        atualizar_captura(casa,tabuleiro)
        atualizar_posicao(casa,tabuleiro)
        @posicoes_possiveis.uniq!

    end



    def atualizar_bispo(tabuleiro)
        @posicoes_possiveis = []
        @capturas_possiveis = []


        diag_cima_esq, diag_cima_dir, diag_baixo_esq, diag_baixo_dir = true
        for i in 1..8
            unless diag_cima_esq == false
                casa = movimento_misto(-i,i)
                if tabuleiro.movimentacao_invalida?(casa)
                    diag_cima_esq = false
                    atualizar_captura(casa,tabuleiro)
                else
                    @posicoes_possiveis << casa
                end
            end
            unless diag_cima_dir == false
                casa = movimento_misto(i,i)
                if tabuleiro.movimentacao_invalida?(casa)
                    diag_cima_dir = false
                    atualizar_captura(casa,tabuleiro)
                else
                    @posicoes_possiveis << casa
                end
            end
            unless diag_baixo_esq == false
                casa = movimento_misto(-i,-i)
                if tabuleiro.movimentacao_invalida?(casa)
                    diag_baixo_esq = false
                    atualizar_captura(casa,tabuleiro)
                else
                    @posicoes_possiveis << casa
                end
            end
            unless diag_baixo_dir == false
                casa = movimento_misto(i,-i)
                if tabuleiro.movimentacao_invalida?(casa)
                    diag_baixo_dir = false
                    atualizar_captura(casa,tabuleiro)
                else
                    @posicoes_possiveis << casa
                end
            end
        end
        @posicoes_possiveis.uniq!


    end

    def atualizar_rei(tabuleiro)
        @posicoes_possiveis = []
        @capturas_possiveis = []

        #movimento
        casa = movimento_vertical(1)
        atualizar_posicao(casa,tabuleiro)
        atualizar_captura(casa,tabuleiro)
        
        casa = movimento_vertical(-1)
        atualizar_posicao(casa,tabuleiro)
        atualizar_captura(casa,tabuleiro)
        
        casa = movimento_horizontal(1)
        atualizar_posicao(casa,tabuleiro)
        atualizar_captura(casa,tabuleiro)

        casa = movimento_horizontal(-1)
        atualizar_posicao(casa,tabuleiro)
        atualizar_captura(casa,tabuleiro)

        casa = movimento_misto(1,1)
        atualizar_posicao(casa,tabuleiro)
        atualizar_captura(casa,tabuleiro)

        casa = movimento_misto(1,-1)
        atualizar_posicao(casa,tabuleiro)
        atualizar_captura(casa,tabuleiro)

        casa = movimento_misto(-1,-1)
        atualizar_posicao(casa,tabuleiro)
        atualizar_captura(casa,tabuleiro)

        casa = movimento_misto(-1,1)
        atualizar_posicao(casa,tabuleiro)
        atualizar_captura(casa,tabuleiro)

        @posicoes_possiveis.uniq!


    end

    def atualizar_rainha(tabuleiro)
        @posicoes_possiveis = []
        @capturas_possiveis = []


        diag_cima_esq, diag_cima_dir, diag_baixo_esq, diag_baixo_dir, cima, baixo, direita, esquerda = true
        for i in 1..8
            unless diag_cima_esq == false
                casa = movimento_misto(-i,i)
                if tabuleiro.movimentacao_invalida?(casa)
                    diag_cima_esq = false
                    atualizar_captura(casa,tabuleiro)
                else
                    @posicoes_possiveis << casa
                end
            end
            unless diag_cima_dir == false
                casa = movimento_misto(i,i)
                if tabuleiro.movimentacao_invalida?(casa)
                    diag_cima_dir = false
                    atualizar_captura(casa,tabuleiro)
                else
                    @posicoes_possiveis << casa
                end
            end
            unless diag_baixo_esq == false
                casa = movimento_misto(-i,-i)
                if tabuleiro.movimentacao_invalida?(casa)
                    diag_baixo_esq = false
                    atualizar_captura(casa,tabuleiro)
                else
                    @posicoes_possiveis << casa
                end
            end
            unless diag_baixo_dir == false
                casa = movimento_misto(i,-i)
                if tabuleiro.movimentacao_invalida?(casa)
                    diag_baixo_dir = false
                    atualizar_captura(casa,tabuleiro)
                else
                    @posicoes_possiveis << casa
                end
            end
            unless cima == false
                casa = movimento_vertical(i)
                if tabuleiro.movimentacao_invalida?(casa)
                    cima = false
                    atualizar_captura(casa,tabuleiro)
                else
                    @posicoes_possiveis << casa
                end
            end
            unless baixo == false
                casa = movimento_vertical(-i)
                if tabuleiro.movimentacao_invalida?(casa)
                    baixo = false
                    atualizar_captura(casa,tabuleiro)
                else
                    @posicoes_possiveis << casa
                end
            end
            unless direita == false
                casa = movimento_horizontal(i)
                if tabuleiro.movimentacao_invalida?(casa)
                    direita = false
                    atualizar_captura(casa,tabuleiro)
                else
                    @posicoes_possiveis << casa
                end
            end
            unless esquerda == false
                casa = movimento_horizontal(-i)
                if tabuleiro.movimentacao_invalida?(casa)
                    esquerda = false
                    atualizar_captura(casa,tabuleiro)
                else
                    @posicoes_possiveis << casa
                end
            end
        end
        @posicoes_possiveis.uniq!
    end


    def atualizar_captura(casa,tabuleiro)
        jogador = @peca.jogador
        indice = jogador.indice
        indice_posicao_captura = tabuleiro.retornar_jogador_indice_casa(casa)
        (indice_posicao_captura != nil && indice_posicao_captura != indice) ? @capturas_possiveis << casa : nil
    end

    def atualizar_posicao(casa,tabuleiro)
        @posicoes_possiveis << casa unless tabuleiro.movimentacao_invalida?(casa)
    end



    def movimento_vertical(deslocamento, casa = @posicao)
        coluna = casa[0].slice(0)
        linha = casa[0].slice(1).to_i
        linha_deslocada = linha + deslocamento
        return casa_deslocada = "#{coluna}#{linha_deslocada}"
        
    end

    def movimento_horizontal(deslocamento, casa = @posicao)
        coluna = casa[0].slice(0).ord
        linha = casa[0].slice(1).to_i
        coluna_deslocada = (coluna + deslocamento).chr
        return casa_deslocada = "#{coluna_deslocada}#{linha}"
    end

    def movimento_misto(desloc_horizontal, desloc_vertical , casa = @posicao)
        coluna = casa[0].slice(0).ord
        coluna_deslocada = (coluna + desloc_horizontal).chr
        linha = casa[0].slice(1).to_i
        linha_deslocada = linha + desloc_vertical
        return casa_deslocada = "#{coluna_deslocada}#{linha_deslocada}"
    end

end

