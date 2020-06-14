require 'sinatra/base'

module Sinatra
  module ViewHelpers

    def titulacao_options
      ['Graduação', 'Especialização', 'Mestrado', 'Doutorado']
    end

    def tipo_options
      ['Projeto ou Proposta para Qualificação/Avaliação', 'Trabalho final (em produção ou finalizado)']
    end

    def select_options(options, value)
      output = options.map do |option|
        "<option #{value == option ? "selected='selected" : ""} value='#{option}'>#{option}</option>"
      end

      output.join('')
    end
  end

  helpers ViewHelpers
end
