defmodule BankWeb.Controllers.ReferralsControllerTest do
  @moduledoc false

  use BankWeb.ConnCase, async: true

  alias Bank.BankAccount.Mutator, as: AccountMutator
  alias Bank.ReferralCode.Loader, as: ReferralCodeLoader

  @moduletag capture_log: true

  describe "POST /api/referrals [index]" do
    test "list referrals for a valid account", %{conn: conn} do
      cpf1 = "853.479.740-44"

      attrs = %{
        cpf: cpf1,
        name: "Paulo Henrique dos Santos Sacramento",
        birth_date: "06/01/2990",
        country: "BR",
        email: "contato@henriquesacramento.net",
        gender: "MALE",
        state: "BA",
        city: "Teixeira de Freitas"
      }

      {:ok, referral_account} = AccountMutator.create_or_update(attrs)

      referral_code = ReferralCodeLoader.get_by(%{account_id: referral_account.id})

      cpf2 = "296.761.660-57"

      attrs2 = %{
        cpf: cpf2,
        name: "Henrique Sacramento",
        birth_date: "06/01/2990",
        country: "BR",
        email: "contato@henriquesacramento.net",
        gender: "MALE",
        state: "BA",
        city: "Teixeira de Freitas",
        referral_code: referral_code.code
      }

      AccountMutator.create_or_update(attrs2)

      body_request = %{
        cpf: cpf1
      }

      response =
        conn
        |> put_req_header("content-type", "application/json")
        |> post(Routes.referrals_path(conn, :index), body_request)
        |> json_response(200)

      assert [
               %{
                 "account_id" => _,
                 "email" => "contato@henriquesacramento.net",
                 "inserted_at" => _
               }
             ] = response
    end

    test "list referrals for a invalid account", %{conn: conn} do
      cpf1 = "853.479.740-44"

      attrs = %{
        cpf: cpf1,
        name: "Paulo Henrique dos Santos Sacramento",
        birth_date: "06/01/2990",
        email: "contato@henriquesacramento.net",
        gender: "MALE",
        state: "BA",
        city: "Teixeira de Freitas"
      }

      AccountMutator.create_or_update(attrs)

      body_request = %{
        cpf: cpf1
      }

      response =
        conn
        |> put_req_header("content-type", "application/json")
        |> post(Routes.referrals_path(conn, :index), body_request)
        |> json_response(422)

      assert %{
               "errors" => [
                 %{"cpf" => "Unable to show referrals for pending activation accounts"}
               ]
             } = response
    end
  end
end
