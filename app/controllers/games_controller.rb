require 'json'
require 'open-uri'
class GamesController < ApplicationController
  # session[:points] = 0

  def new
    if session[:points]
      @points = session[:points]
    else
      session[:points] = 0
      @points = session[:points]
    end
    @letters = []
    10.times { @letters << rand(65..90).chr }
  end

  def score
    @letters = params[:letters]
    @word_submitted = params[:word].upcase
    @word_is_valid = word_is_valid(@word_submitted, @letters)
    @word_is_english = word_is_english(@word_submitted)
    @points = session[:points]

    if @word_is_english
     session[:points] += @word_submitted.length
     @points = session[:points]
    end
  end

  def word_is_valid(word, letters)
    word = word.split('')
    arr_letters = letters.split('')

    word.each do |letter|
      if arr_letters.include?(letter)
        arr_letters.delete_at(arr_letters.find_index(letter))
      else
        return false
      end
    end
    true
  end

  def word_is_english(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word.downcase}"
    word_serialized = URI.open(url).read
    result = JSON.parse(word_serialized)
    result["found"]
  end

  private

  def set_session
    session[:points] = 0
  end
end
