defmodule WordFinderWeb.Plugs.RateLimiter do
  import Plug.Conn
  use WordFinderWeb, :controller

  alias WordFinder.IP
  require Logger

  @limit 5

  def init(options), do: options

  def call(conn, _opts) do
    ip = IP.getIP()

    case Hammer.check_rate(ip, 60_000, @limit) do
      {:allow, count} ->
        assign(conn, :requests_count, count)

      {:deny, _limit} ->
      #  Logger.debug("Rate limit exceeded for #{inspect(ip)}")
        error_response(conn)
    end
  end

  defp error_response(conn) do
    conn
    |> put_status(:service_unavailable)
    |> json(%{message: "Please wait before sending another request."})
    |> halt()
  end
end
