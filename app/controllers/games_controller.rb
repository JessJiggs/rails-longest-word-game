require "json"
require "open-uri"

class GamesController < ApplicationController
  # new grid
  def new
    grid_range = ('a'..'z').to_a
    @letters = grid_range.sample(10)
  end

  # # if else etc
  def score
    @guess = params[:guess]

    @guess.chars.each do |char|
      if letters.include?(char)
        letters.delete_at(letters.index(char))
      else
        result = "no match - you used stray letters"
      end
    end

    url = "https://wagon-dictionary.herokuapp.com/#{@guess}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)
    if user[:found] && result == nil
      @score = "yeaaahh you're a winner"
    elsif !user[:found]
      @score = "sorry not a engrish word"
    else
      @score = result
    end
  end

end


# def answer # goes through the block below - and sends the output to the html file "answer" - which is rendered on broswer
#   @question = params[:question]

#   @answer = if @question == "I am going to work"
#               "Great!"
#             elsif @question.include? "?"
#               "Silly question, get dressed and go to work!"
#             else
#               "I don't care, get dressed and go to work!"
#             end
# end
