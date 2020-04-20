defmodule Bank.Invitation.Loader do
  @moduledoc false

  alias Bank.Invitation
  alias Bank.Repo

  def get(referral_code_id), do: Repo.get_by(Invitation, referral_code_id: referral_code_id)
end
