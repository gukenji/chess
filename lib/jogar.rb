
require_relative 'jogador.rb'
require_relative 'tabuleiro.rb'

class Jogar

    attr_reader :jogador_1, :jogador_2, :vez_turno, :tabuleiro
    def iniciar_jogo
        criar_jogadores
        sortear_jogador
        montar_tabuleiro
        until check_mate?
            jogada
        end
        puts "FIM"
    end


    def criar_jogadores
        puts "Por favor, digite o nome do jogador 1:"
        nome = gets.chomp.to_s
        @jogador_1 = Jogador.new(nome,1)
        puts "Por favor, digite o nome do jogador 2:"
        nome = gets.chomp.to_s
        @jogador_2 = Jogador.new(nome,2)
    end

    def sortear_jogador
        puts "Sorteando o jogador a jogar..."
        @vez_turno = public_send("jogador_#{Random.rand(1..2)}".to_sym) 
        puts "O jogo começará com o jogador #{@vez_turno.indice} -  #{@vez_turno.nome} "
    end

    def montar_tabuleiro
        @tabuleiro = Tabuleiro.new
        @tabuleiro.colocar_pecas(@jogador_1)
        @tabuleiro.colocar_pecas(@jogador_2)
        @tabuleiro.atualizar_movimentacoes_permitidas
    end

    def mudar_turno
        @vez_turno == @jogador_1 ? @vez_turno = @jogador_2 : @vez_turno = @jogador_1
    end

    def jogada
        @tabuleiro.visualizar_tabuleiro
        puts "Por favor #{@vez_turno.nome}, escolha a posição inicial da  peça que queira movimentar:"
        posicao_inicial = gets.chomp
        casa = @tabuleiro.encontrar_posicao(posicao_inicial)
        peca = casa.peca unless casa == nil
        posicoes_possiveis = casa.posicoes_possiveis unless casa == nil
        capturas_possiveis = casa.capturas_possiveis unless casa == nil
        until peca != nil && peca.jogador == @vez_turno && (posicoes_possiveis.length >= 1 || capturas_possiveis.length >= 1)
            puts "Escolha uma posicão que tenha uma peça sua e que possua movimentaçoes possiveis!"
            posicao_inicial = gets.chomp
            casa = @tabuleiro.encontrar_posicao(posicao_inicial)
            peca = casa.peca unless casa == nil
            posicoes_possiveis = casa.posicoes_possiveis unless casa == nil
            capturas_possiveis = casa.capturas_possiveis unless casa == nil
        end

        puts "Por favor #{@vez_turno.nome}, escolha a posição final da  peça que queira movimentar:"
        posicao_final = gets.chomp
        until posicoes_possiveis.any?(posicao_final) || capturas_possiveis.any?(posicao_final)
            puts "Por favor, selecione apenas movimentações validas!"
            puts "Posiçoes permitidas: #{posicoes_possiveis}"
            puts "Capturas permitidas: #{capturas_possiveis}"
            posicao_final = gets.chomp
        end
        @tabuleiro.mover_peca(posicao_inicial,posicao_final)
        @tabuleiro.atualizar_movimentacoes_permitidas
        @tabuleiro.visualizar_tabuleiro
    end

    def check_mate?
        if check?

            rei = check?
            casa = @tabuleiro.encontrar_posicao(rei)
            peca = casa.peca
            posicoes_possiveis = casa.posicoes_possiveis
            #retirar rei#
            casa.retirar_rei
            if (posicoes_possiveis.length < 1 || existe_movimento_rei?(posicoes_possiveis) == false)
                puts "Check-mate!"
                return true
            else
                puts("Check! Rei em perigo! Posição #{rei.upcase}")
                posicoes_possiveis = existe_movimento_rei?(posicoes_possiveis)
                #recolocar rei#
                casa.incluir_peca(peca)
                mudar_turno
                puts "#{@vez_turno.nome}, por favor, tire o Rei da posição de check."
                puts "Posiçoes permitidas: #{posicoes_possiveis}"
                escolha = gets.chomp
                until posicoes_possiveis.any?(escolha)
                    puts "Escolha apenas o que é permitido!"
                    escolha = gets.chomp
                end
                @tabuleiro.mover_peca(rei,escolha)
                mudar_turno
                return false
            end
        else
            mudar_turno
            return false
        end
    end

    def check?
        @tabuleiro.casas.each do |casa|
            capturas_possiveis = casa.capturas_possiveis
            if capturas_possiveis.length > 0
                peca_captura = []
                for i in 0..(capturas_possiveis.length-1)
                    casa = @tabuleiro.encontrar_posicao(capturas_possiveis[i])
                    tipo = casa.peca.tipo unless casa.peca == nil
                    if tipo == 'rei'
                        return capturas_possiveis[i]
                    else
                        next
                    end
                end
            else
                next
            end
        end
        return false
    end

    def existe_movimento_rei?(posicoes)
        @tabuleiro.atualizar_movimentacoes_permitidas
        check = true
        @vez_turno == jogador_1 ? jogador = jogador_2 : jogador = jogador_1

        posicoes_possiveis_jogador1 = []
        posicoes_possiveis_jogador2 = []

        @tabuleiro.casas.each do |casa|
            peca = casa.peca
            indice = peca.jogador.indice unless peca == nil
            posicoes_possiveis_jogador1 << casa.posicoes_possiveis if indice == 1
            posicoes_possiveis_jogador2 << casa.posicoes_possiveis if indice == 2
        end
        posicoes_possiveis_jogador1.flatten!.uniq!
        posicoes_possiveis_jogador2.flatten!.uniq!
        if jogador == jogador_1
            resultado = posicoes - posicoes_possiveis_jogador2 
            resultado.length == 0 ? check = false : nil
        else
            resultado = posicoes - posicoes_possiveis_jogador1 
            resultado.length == 0 ? check = false : nil
        end
        check == true ? resultado : check
    end

end

a = Jogar.new
a.iniciar_jogo