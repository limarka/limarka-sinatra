require 'sinatra/base'

module Sinatra
  module AppHelpers

    def filename
      'configuracao.yaml'
    end

    def load_data
      return {} unless File.file?(filename)
      data = YAML.load(File.read(filename))
      data['siglas'] = hash_to_string(data['siglas']) if data['siglas']
      data['simbolos'] = hash_to_string(data['simbolos']) if data['simbolos']
      data
    end

    def hash_to_string(hashes)
      output = hashes.map do |hash|
        "#{hash['s']}: #{hash['d']}"
      end

      output.join("\n")
    end

    def save_data(data)
      File.open(filename,'w') { |h| h.write JSON.load(data.to_json).to_yaml }
    end

    def lista(sigla)
      sigla.split("\n").map do |linha|
        key, value = linha.split(':')
        { 's' => key.strip, 'd' => value ? value.strip : ''} if key
      end
    end
  end

  helpers AppHelpers
end
