defmodule Bank.Invitation.MutatorTest do
  @moduledoc false

  use Bank.DataCase, async: true

  alias Bank.Invitation.Loader
  alias Bank.Invitation.Mutator

  describe "create/1" do
    test "with valid attributes" do
      referral_code_id = Ecto.UUID.generate()
      account_id = Ecto.UUID.generate()

      attrs = %{
        account_id: account_id,
        referral_code_id: referral_code_id
      }

      assert {:ok, %{referral_code_id: referral_code_id}} = Mutator.create(attrs)
      assert Loader.get(referral_code_id)
    end

    test "with invalid referral_code_id" do
      account_id = Ecto.UUID.generate()
      attrs = %{referral_code_id: nil, account_id: account_id}
      assert {:error, %{}} = Mutator.create(attrs)
    end

    test "with invalid account_id" do
      referral_code_id = Ecto.UUID.generate()
      attrs = %{referral_code_id: referral_code_id, account_id: ""}
      assert {:error, %{}} = Mutator.create(attrs)
    end
  end
end
