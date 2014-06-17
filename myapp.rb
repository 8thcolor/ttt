require 'sinatra'
require 'sinatra/reloader' if development?

require './lib/game'



get '/' do
  'Hello world!'
end

get '/game/:id' do |id|
  game = Game.new(1)
  game.place(1,1)
  
  erb :index, locals: {game: game}
end

helpers do
  def show_cell(x, y, value)
    if value == '-'
      "<a href='x=#{x}&y=#{y}'>#{value}</a>"
    else
      value
    end
  end
end