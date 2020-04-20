defmodule Bank.Invitation.Changeset do
  @moduledoc """
  Provides Invitation database related functions.
  """

  import Ecto.Changeset

  alias Bank.Invitation

  @params_required ~w(referral_code_id account_id)a
  @params_optional ~w()a

  @doc false
  def build(struct \\ %Invitation{}, attrs) do
    struct
    |> cast(attrs, @params_required ++ @params_optional)
    |> validate_required(@params_required)
  end
end
