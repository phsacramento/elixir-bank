defmodule Bank.Invitation.LoaderTest do
  @moduledoc false

  use Bank.DataCase, async: true

  alias Bank.Invitation.Loader
  alias Bank.Invitation.Mutator

  describe "get/1" do
    test "get a invitation by referral code" do
      referral_code_id = Ecto.UUID.generate()
      account_id = Ecto.UUID.generate()

      attrs = %{
        account_id: account_id,
        referral_code_id: referral_code_id
      }

      Mutator.create(attrs)

      referral_code = Loader.get(referral_code_id)
      assert referral_code
      assert referral_code.referral_code_id == referral_code_id
    end

    test "when not found" do
      code = Ecto.UUID.generate()

      refute Loader.get(code)
    end
  end
end
