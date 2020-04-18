defmodule BankWeb.Helpers.Parameters do
  def filter(params, filters) do
    required = Keyword.get(filters, :required, [])
    optional = Keyword.get(filters, :optional, [])

    params
    |> ensure_required_fields(required)
    |> filter_by(required, optional)
  end

  def atomize_keys(%{} = map) do
    map
    |> Enum.into(%{}, fn {k, v} -> {String.to_atom(k), atomize_keys(v)} end)
  end

  def atomize_keys([head | rest]), do: [atomize_keys(head) | atomize_keys(rest)]
  def atomize_keys(not_a_map), do: not_a_map

  defp ensure_required_fields(params, required) do
    params
    |> Map.keys()
    |> diff(required)
    |> format_response(params)
  end

  defp diff(params_keys, required), do: required -- params_keys

  defp filter_by(%{} = params, required, optional) do
    params
    |> take_fields(required)
    |> Map.merge(take_fields(params, optional))
  end

  defp filter_by(any, _requireds, _optionals), do: any

  defp format_response([], params), do: params
  defp format_response(missing_keys, _params), do: {:error, :params_missing, missing_keys}

  defp take_fields(%{} = params, fields), do: Map.take(params, fields)
end
