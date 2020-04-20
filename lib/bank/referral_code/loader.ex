defmodule Bank.ReferralCode.Loader do
  @moduledoc false

  import Ecto.Query

  alias Bank.ReferralCode
  alias Bank.Repo

  def get(code), do: Repo.get_by(ReferralCode, code: code)

  def get_by(%{} = filters) do
    filters
    |> Enum.reduce(base_get_by(), &apply_where/2)
    |> Repo.one()
    |> format_response()
  end

  defp base_get_by, do: from(a in ReferralCode)

  defp apply_where({_key, nil}, query), do: query

  defp apply_where({key, value}, query),
    do: from(q in query, where: field(q, ^key) == ^value)

  defp format_response([]), do: nil
  defp format_response(response), do: response
end
