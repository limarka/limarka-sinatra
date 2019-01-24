#!/usr/bin/env ruby
# encoding: utf-8
require 'sinatra'
#require "sinatra/config_file"
require 'json'
require 'yaml/store'
require 'yaml'


#set :port, 8080
set :static, true
set :public_folder, "Public"
set :views, "views"
#session :enable, true

before do
  content_type :html, 'charset' => 'utf-8'
end


ListaIlu = {
  'false' => 'Desativar Lista de Ilustrações',
  'true' => 'Gerar Lista de Ilustrações',
}

ListaTab = {
  'false' => 'Desativar Lista de Ilustrações',
  'true' => 'Gerar Lista de Ilustrações',
}


def hash_to_yaml(h)
  s = StringIO.new
  s << h.to_yaml
  s.string
end

def lista_siglas(sigla)
  h = {}
  ['siglas'].each do |campo|
    str = sigla
    if (str) then
      sa = [] # sa: s-array
      str.each_line do |linha|
        s,d = linha.split(":")
        sa << { 's' => s.strip, 'd' => d ? d.strip : ""} if s
      end
      h[campo] = sa.empty? ? nil : sa
    end
  end
  return h['siglas']
end

def lista_simbolos(simbolo)
  h = {}
  ['simbolos'].each do |campo|
    str = simbolo
    if (str) then
      sa = [] # sa: s-array
      str.each_line do |linha|
        s,d = linha.split(":")
        sa << { 's' => s.strip, 'd' => d ? d.strip : ""} if s
      end
      h[campo] = sa.empty? ? nil : sa
    end
  end
  return h['simbolos']
end


get '/' do
  @titulo = 'Formulário em HTML para o Limarka. '
  erb :index
end

get '/resultados' do
  @titulo = 'Obrigado por utilizar este formulário e o Limarka!'
  ha = params.to_json
  ha = JSON.load(ha)
  File.open('configuracao.yaml','w') do |h| 
    h.write ha.to_yaml
  end  
  config = YAML.load_file('configuracao.yaml')
  sig = params['siglas']
  sig = lista_siglas(sig) 
  sim = params['simbolos']
  sim = lista_simbolos(sim)  
  config['siglas'] = sig
  config['simbolos'] = sim
  File.open('configuracao.yaml','w') do |h| 
    h.write config.to_yaml 
  end 
  erb :resultados
end
