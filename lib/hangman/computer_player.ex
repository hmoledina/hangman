defmodule Hangman.ComputerPlayer do
  use Bitwise

  alias Hangman.Game

  def play do
    game   = Game.new_game
    length = Game.word_length(game)
    list = get_list(length)
    make_a_move(game,list)
  end

  def make_a_move(game,list) do

    {guess,list} = get_guess(game,list)

    { game, status, guess } = Game.make_move(game, guess)

    analyze_move(status, game, guess,list)
  end

  def analyze_move(:good_guess, game, guess,list) do
    IO.puts "#{inspect guess} was good"
    IO.puts Game.word_as_string(game)
    IO.puts ""
    make_a_move(game,list)
  end

  def analyze_move(:bad_guess, game, guess,list) do
    IO.puts "#{inspect guess} was bad"
    IO.puts Game.word_as_string(game)
    IO.puts ""
    make_a_move(game,list)
  end

  def analyze_move(:won, game,  _guess,_list) do
    IO.puts "I won! The word was: #{Game.word_as_string(game)}"
  end

  def analyze_move(:lost, game, _guess,_list) do
    IO.puts "I lost. The word was: #{Game.word_as_string(game, true)}"
  end

  def get_guess(game,list) do
    v = List.first(list)
    list=List.delete_at(list, 0)
    {v,list}
  end

#get list takes all the words with particular length, calculates the frequencies
#and sorts them according to their frequencies. It then returns a list with the
#highest to lowest frequency alphabets

  defp get_list(length) do
    candidate_words = load_words_of_length(length)
    list = conv_char(candidate_words)
    |> List.flatten
    |> Enum.filter(fn c -> c =~ ~r/[a-z]/ end)
    |> Enum.reduce(Map.new, fn c,acc -> Map.update(acc, c, 1, &(&1+1)) end)
    |> Enum.sort_by(fn {_k,v} -> -v end)
    |> make_list
    |>List.flatten
  end

  defp load_words_of_length(len) do
    Hangman.Dictionary.words_of_length(len)
  end

  defp conv_char([h|t]) do
    list2 = [String.codepoints(h)|conv_char(t)]
  end

  defp conv_char([]), do: []

  defp make_list([]), do: []

  defp make_list([h|t]) do
    list3 = [Tuple.to_list(Tuple.delete_at(h, 1))|make_list(t)]
  end


end
