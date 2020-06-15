require 'sinatra/base'

module Sinatra
  module ViewHelpers

    def nivel_options
      ['Graduação', 'Especialização', 'Mestrado', 'Doutorado']
    end

    def tipo_do_trabalho_options
      ['Projeto ou Proposta para Qualificação/Avaliação', 'Trabalho final (em produção ou finalizado)']
    end

    def select_options(options, value)
      output = options.map do |option|
        puts "#{option}/#{value}/#{value == option}"
        "<option #{value == option ? "selected='selected" : ""} value='#{option}'>#{option}</option>"
      end

      output.join('')
    end
  end

  helpers ViewHelpers
end
