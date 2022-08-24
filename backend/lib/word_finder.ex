defmodule WordFinder do
  @moduledoc """
  WordFinder keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  @spec get_words(String.t()) :: <<_::128>> | list
  def get_words(word) do
    proposed_word = word

    common_word_stream =
      File.stream!(Path.join(:code.priv_dir(:word_finder), "static/english_words.txt"))
      |> Stream.filter(fn common_word ->
        # String.contains?(common_word, proposed_word)
        String.starts_with?(common_word, proposed_word)
      end)
      |> Enum.to_list()
      |> Enum.map(&String.replace_suffix(&1, "\n", ""))

    if length(common_word_stream) == 0 do
      "No words matched"
    else
      IO.inspect(length(common_word_stream), label: "length")
      common_word_stream
    end
  end
end
