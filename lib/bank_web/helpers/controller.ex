defmodule BankWeb.Helpers.Controller do
  use Phoenix.Controller, namespace: BankWeb

  alias Ecto.Changeset

  import Plug.Conn

  def inject_response({:no_content, _response}, conn),
    do: send_resp(conn, :no_content, "")

  def inject_response({status, response}, conn) do
    conn
    |> put_status(status)
    |> json(response)
  end

  def parse_response(data, success_state \\ :ok)
  def parse_response({:ok, resp}, success_state), do: {success_state, clear_ecto_meta(resp)}

  def parse_response({:error, errors}, _success_state),
    do: {:unprocessable_entity, %{errors: parse_changeset_errors(errors)}}

  def parse_response(%{} = resp, success_state), do: {success_state, clear_ecto_meta(resp)}
  def parse_response(nil, _success_state), do: {:not_found, %{errors: "not found"}}

  def format_return(%{} = data), do: {:ok, data}

  defp clear_ecto_meta(%{__meta__: _} = map), do: Map.drop(map, [:__meta__, :__struct__])
  defp clear_ecto_meta(any), do: any

  defp parse_changeset_errors(%Changeset{} = changeset) do
    Changeset.traverse_errors(changeset, fn {message, opts} ->
      Enum.reduce(opts, message, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end

  defp parse_changeset_errors(any), do: any
end
