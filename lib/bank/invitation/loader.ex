defmodule Bank.Invitation.Loader do
  @moduledoc false

  import Ecto.Query

  alias Bank.Invitation
  alias Bank.Repo

  def get(referral_account_id),
    do: Repo.get_by(Invitation, referral_account_id: referral_account_id)

  def get_all_by(%{} = filters) do
    filters
    |> Enum.reduce(base_get_by(), &apply_where/2)
    |> Repo.all()
    |> format_response()
  end

  def get_by(%{} = filters) do
    filters
    |> Enum.reduce(base_get_by(), &apply_where/2)
    |> Repo.one()
    |> format_response()
  end

  defp base_get_by, do: from(a in Invitation)

  defp apply_where({_key, nil}, query), do: query

  defp apply_where({key, value}, query),
    do: from(q in query, where: field(q, ^key) == ^value)

  defp format_response([]), do: nil
  defp format_response(response), do: response
end
