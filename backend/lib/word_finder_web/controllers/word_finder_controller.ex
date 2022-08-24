defmodule WordFinderWeb.WordFinderController do
  use WordFinderWeb, :controller

  alias WordFinder

  def index(conn, %{"word" => word}) do
    suggested_words = WordFinder.get_words(word)

    conn
    |> put_status(200)
    |> json(%{
      words: suggested_words
    })
  end
end
