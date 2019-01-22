# coding: utf-8
#require "bundler/gem_tasks"
#require "rspec/core/rake_task"
require 'rake/clean'



task :default => [:configuracao_padrao, 'spec']


desc "Inicia aplicação"
task :run do
	puts "Acesse http://localhost:4567"
	sh "bundle exec ruby app.rb"
end

CLEAN.include(['tmp'])
