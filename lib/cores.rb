require 'colorize'

class Cores
    def self.fundo (cor,texto)
        {
            'preto' => texto != nil ? " #{texto} ".on_black : "   ".on_black,
            'cinza' => texto != nil ? " #{texto} ".on_light_black : "   ".on_light_black,
            'verde' => texto != nil ? " #{texto} ".on_green : "   ".on_green,
            'vermelho' => texto != nil ? " #{texto} ".on_red : "   ".on_red
         }[cor]
    end
end

