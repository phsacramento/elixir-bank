defmodule BankWeb.AuthenticationHelper do
  use Plug.Test

  alias BankWeb.Tokens.AuthenticationToken

  def put_authentication_token(conn) do
    conn
    |> put_req_header(
      "authorization",
      "Bearer " <> token()
    )
  end

  defp token do
    {:ok, token, _} = AuthenticationToken.generate_and_sign()
    token
  end
end
