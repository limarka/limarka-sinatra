# encoding: utf-8
require 'sinatra'
require 'json'
require 'yaml/store'



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


def store_name(filename, string)
  File.open(filename, "a+") do |file|
    file.puts(string+"\n")
  end
end

def store_yaml(filename, string)
  File.open(filename, "a+") do |file|
    #file.puts("---\n"+string+"\n\n---")
    file.puts(string)
  end
end

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
  return h
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
  h
end


get '/' do
  @titulo = 'Configuração inicial: Capa e Folha de Rosto'
  erb :capa
end


get '/folha' do
  @titulo = 'Folha de Rosto'
  ha = params.to_json
  ya = JSON.load(ha).to_yaml
  store_yaml("configuracao.yaml", ya)
  erb :folha
end

get '/siglas_simbolos' do
  @titulo = 'Lista de Siglas e Simbolos'
  ha = params.to_json
  ya = JSON.load(ha).to_yaml
  ya = ya[4...-1]  
  store_yaml("configuracao.yaml", ya)
  erb :siglas_simbolos
end

get '/resultados' do
  @titulo = 'Obrigado por utilizar este formulário e o Limarka!'
  ha = params['siglas']
  ya = lista_siglas(ha)
  ya = hash_to_yaml(ya)
  ya = ya[4...-1]  
  store_yaml("configuracao.yaml", ya)
  ha = params['simbolos']
  ya = lista_simbolos(ha)
  ya = hash_to_yaml(ya)
  ya = ya[4...-1]  
  store_yaml("configuracao.yaml", ya)
  erb :resultados
end
