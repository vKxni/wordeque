defmodule WordFinder.Base do
  use HTTPoison.Base

  @moduledoc """
  This handles HTTP requests without api key (basic requests).
  """

  def process_request_headers(headers) do
    [{"Content-Type", "application/json"} | headers]
  end
end
