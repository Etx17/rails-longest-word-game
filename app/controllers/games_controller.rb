require 'json'
require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << rand(65..90).chr }
  end

  def score
    @letters = params[:letters]
    @word_submitted = params[:word].upcase
    @word_is_valid = word_is_valid(@word_submitted, @letters)
    @word_is_english = word_is_english(@word_submitted)
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
end
