#!/usr/bin/env ruby
# encoding: utf-8
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/session'
require 'json'
require 'yaml/store'


set :static, true
set :public_folder, "Public"
set :views, "views"

before do
  content_type :html, 'charset' => 'utf-8'
end

# Para futuros testes 
=begin
ListaIlu = {
  'false' => 'Desativar Lista de Ilustrações',
  'true' => 'Gerar Lista de Ilustrações',
}

ListaTab = {
  'false' => 'Desativar Lista de Ilustrações',
  'true' => 'Gerar Lista de Ilustrações',
}
=end

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

def sig_form(sig_simbolo)
	sig = sig_simbolo.gsub("---\n", "")
	sig = sig.gsub("- s: ", "")
	return sig.gsub("\nd", "")
end




get '/' do
  session!
  @titulo = 'Formulário em HTML para o Limarka '
  @author            =  session[:author].to_json
  @nivel             =  session[:nivel]
  @tipo              =  session[:tipo]
  @instituicao       =  session[:instituicao].to_json
  @title             =  session[:title].to_json
  @local             =  session[:local].to_json
  @date              =  session[:date].to_json
  @siglas            =  session[:siglas]
  @simbolos          =  session[:simbolos]
  @orientador        =  session[:orientador].to_json
  @coorientador      =  session[:coorientador].to_json
  @area_concentracao =  session[:area_concentracao].to_json
  @titulacao         =  session[:titulacao].to_json
  @curso             =  session[:curso].to_json
  @programa          =  session[:programa].to_json
  @linha_de_pesquisa =  session[:linha_de_pesquisa].to_json
  @proposito         =  session[:proposito]
  erb :index
end


get '/login' do
  if session?
    redirect '/'
  else
    erb :index
  end
end
 
post '/login' do
  if params[:tipo]
    @titulo = 'Formulário em HTML para o Limarka ' 
    session_start!
    session[:author]            = params[:author]
    session[:nivel]             = params[:nivel]
    session[:tipo]              = params[:tipo]
    session[:instituicao]       = params[:instituicao]
    session[:title]             = params[:title]
    session[:local]             = params[:local]
    session[:date]              = params[:date]
    session[:siglas]            = params[:siglas]
    session[:simbolos]          = params[:simbolos]
    session[:orientador]        = params[:orientador]
    session[:coorientador]      = params[:coorientador]
    session[:area_concentracao] = params[:area_concentracao]
    session[:titulacao]         = params[:titulacao]
    session[:curso]             = params[:curso]
    session[:programa]          = params[:programa]
    session[:linha_de_pesquisa] = params[:linha_de_pesquisa]
    session[:proposito]         = params[:proposito]

    sig = params['siglas']
    sig = lista_siglas(sig) 
    sim = params['simbolos']
    sim = lista_simbolos(sim)  
    params['siglas'] = sig
    params['simbolos'] = sim

    ha = params.to_json
    ha = JSON.load(ha)
    File.open('configuracao.yaml','w') do |h| 
      h.write ha.to_yaml
    end     
    redirect '/'
  else
    redirect '/login'
  end


end

get '/logout' do
  session_end!
  redirect '/'
end