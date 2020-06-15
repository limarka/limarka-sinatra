require 'sinatra/base'

module Sinatra
  module AppHelpers

    def nome_arquivo
      'configuracao.yaml'
    end

    def carrega_dados
      return {} unless File.file?(nome_arquivo)
      dados = YAML.load(File.read(nome_arquivo))
      dados['siglas'] = hash_para_string(dados['siglas']) if dados['siglas']
      dados['simbolos'] = hash_para_string(dados['simbolos']) if dados['simbolos']
      dados
    end

    def hash_para_string(hashes)
      hashes.map { |hash| "#{hash['s']}: #{hash['d']}" }.join("\n")
    end

    def salva_dados(dados)
      File.open(nome_arquivo,'w') { |h| h.write JSON.load(dados.to_json).to_yaml }
    end

    def lista(texto)
      texto.split("\n").map do |linha|
        chave, valor = linha.split(':')
        { 's' => chave.strip, 'd' => valor ? valor.strip : ''} if chave
      end
    end
  end

  helpers AppHelpers
end
