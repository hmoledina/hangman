defmodule Hangman.ComputerPlayer do
  use Bitwise

  alias Hangman.Game

  def play do
    game   = Game.new_game
    length = Game.word_length(game)
    list = ["e","s","i","a","r","n","t",
            "o","l","c","d","u","p","m",
            "g","h","b","y","f","v","k",
            "w","z","x","q","j"]
    #solver = %{
    #  candidate_words: load_words_of_length(length),
    #  letters_left:    (?a..?z) |>Enum.into([]),
    #}

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
  #  solver = remove_impossible(solver, game.word, guess)
    make_a_move(game,list)
  end

  def analyze_move(:bad_guess, game, guess,list) do
    IO.puts "#{inspect guess} was bad"
    IO.puts Game.word_as_string(game)
    IO.puts ""


  #  current = solver.candidate_words
  #  new_words = remove_words_with_letter(current, guess)
  #  |> remove_words_not_matching_pattern(game.word)

  #  solver = %{ solver | candidate_words: new_words }
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

  # We need to know whether there is any place that a guess could
  # fit. A new guess can only go where there's an underscore
  # in the game state, so we check all the candidate words to
  # see if our guess letter appears in any of them at any
  # open spot.





  # defp check_candidates_for_letter_in_slot([], _, _) do
  #   false
  # end
  #
  # defp check_candidates_for_letter_in_slot([ {candidate,_} | rest], guess, to_check) do
  #   chars = candidate |> String.codepoints
  #   if check_one_word_for_letter_in_slot(chars, to_check, guess) do
  #     true
  #   else
  #     check_candidates_for_letter_in_slot(rest, guess, to_check)
  #   end
  # end
  #
  # defp check_one_word_for_letter_in_slot([], [], _) do
  #   false
  # end
  #
  # defp check_one_word_for_letter_in_slot([actual | _rest_c],
  #                                       [true   | _rest_t],
  #                                       actual) do
  #   true
  # end
  #
  #
  #
  #
  # defp check_one_word_for_letter_in_slot([_    | rest_c],
  #                                       [_    | rest_t],
  #                                       actual) do
  #   check_one_word_for_letter_in_slot(rest_c, rest_t, actual)
  # end







end
