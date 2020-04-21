defmodule BankWeb.Plugs.Authorization do
  import Plug.Conn

  use Phoenix.Controller, namespace: BankWeb

  alias BankWeb.ErrorView
  alias BankWeb.Tokens.AuthenticationToken

  @impl true
  def init(opts), do: opts

  @impl true
  def call(conn, _opts) do
    conn
    |> get_req_header("authorization")
    |> validate_if_has_token()
    |> handle_response(conn)
  end

  defp validate_if_has_token(["Bearer " <> token]),
    do: AuthenticationToken.verify_and_validate(token)

  defp validate_if_has_token(_), do: {:error, :token_not_found}

  defp handle_response({:ok, _claims}, conn), do: conn

  defp handle_response({:error, :token_not_found}, conn) do
    conn
    |> put_view(ErrorView)
    |> put_status(:unauthorized)
    |> render("401.json")
    |> halt()
  end

  defp handle_response(_error, conn) do
    conn
    |> put_view(ErrorView)
    |> put_status(:forbidden)
    |> render("403.json")
    |> halt()
  end
end
