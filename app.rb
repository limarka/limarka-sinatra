#!/usr/bin/env ruby
# encoding: utf-8
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/session'
require 'json'
require 'yaml/store'
require './helpers/view_helpers.rb'
require './helpers/app_helpers.rb'

set :static, true
set :public_folder, 'public'
set :views, 'views'

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

get '/' do
  @data = load_data
  erb :index
end

post '/update' do
    @titulo = 'Formulário em HTML para o Limarka '

    params['siglas'] = lista(params['siglas'])
    params['simbolos'] = lista(params['simbolos'])

    save_data(params)
    redirect '/'
end

get '/logout' do
  session_end!
  redirect '/'
end
