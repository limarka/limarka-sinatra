require 'sinatra/base'

module Sinatra
  module ViewHelpers

    def nivel_opcoes
      ['Graduação', 'Especialização', 'Mestrado', 'Doutorado']
    end

    def tipo_do_trabalho_opcoes
      ['Projeto ou Proposta para Qualificação/Avaliação', 'Trabalho final (em produção ou finalizado)']
    end

    def select_opcoes(opcoes, valor)
      resultado = opcoes.map do |opcao|
        "<option #{valor == opcao ? "selected='selected" : ""} value='#{opcao}'>#{opcao}</option>"
      end

      resultado.join('')
    end
  end

  helpers ViewHelpers
end
