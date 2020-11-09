require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @guess = params[:word].upcase
    @grid = params[:letters]
    @message = ""
    url = "https://wagon-dictionary.herokuapp.com/#{@guess}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    if !@guess.chars.all? { |letter| @guess.count(letter) <= @grid.count(letter) }
      @message = "Sorry but #{@guess} can't be build out of #{@grid.capitalize}"
    elsif user["found"]
      @message = "Congratulations! #{@guess.capitalize} is a valid English word!"
    else
      @message = "Sorry but #{@guess.capitalize} does not seem to be a valid English word..."
    end
  end
end
