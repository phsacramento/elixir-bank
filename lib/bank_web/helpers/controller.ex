defmodule BankWeb.Helpers.Controller do
  use Phoenix.Controller, namespace: BankWeb

  alias Ecto.Changeset

  def parse_response(data, success_state \\ :ok)
  def parse_response({:ok, resp}, success_state), do: {success_state, clear_ecto_meta(resp)}

  def parse_response({:error, errors}, _success_state),
    do: {:unprocessable_entity, %{errors: parse_changeset_errors(errors)}}

  def parse_response(%{} = resp, success_state), do: {success_state, clear_ecto_meta(resp)}
  def parse_response(nil, _success_state), do: {:not_found, %{errors: "not found"}}

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
