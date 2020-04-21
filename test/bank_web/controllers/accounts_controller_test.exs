defmodule BankWeb.AccountsControllerTest do
  @moduledoc false

  use BankWeb.ConnCase, async: true

  alias Bank.BankAccount.Loader, as: AccountLoader
  alias Bank.BankAccount.Mutator, as: AccountMutator
  alias Bank.Invitation.Loader, as: InvitationLoader
  alias Bank.ReferralCode.Loader, as: ReferralCodeLoader

  @moduletag capture_log: true

  describe "POST /api/accounts [create]" do
    test "without authentication token", %{conn: conn} do
      response =
        conn
        |> put_req_header("content-type", "application/json")
        |> post(Routes.accounts_path(conn, :create), %{})
        |> json_response(401)

      expected_error = %{"errors" => %{"detail" => "Unauthorized"}}
      assert response == expected_error
    end

    test "create an account with valid cpf", %{conn: conn} do
      cpf = "853.479.740-44"

      body_request = %{
        cpf: cpf,
        name: "Paulo Henrique dos Santos Sacramento",
        birth_date: "06/01/2990",
        country: "BR",
        email: "contato@henriquesacramento.net",
        gender: "MALE",
        state: "BA",
        city: "Teixeira de Freitas"
      }

      response =
        conn
        |> put_authentication_token()
        |> put_req_header("content-type", "application/json")
        |> post(Routes.accounts_path(conn, :create), body_request)
        |> json_response(201)

      assert %{
               "id" => id,
               "status" => "COMPLETE",
               "invitation_code" => invitation_code
             } = response

      assert cpf |> AccountLoader.get()
      assert invitation_code
    end

    test "create an account with a empty cpf", %{conn: conn} do
      cpf = ""

      body_request = %{
        cpf: cpf,
        name: "Paulo Henrique dos Santos Sacramento",
        birth_date: "06/01/2990",
        country: "BR",
        email: "contato@henriquesacramento.net",
        gender: "MALE",
        state: "BA",
        city: "Teixeira de Freitas"
      }

      response =
        conn
        |> put_authentication_token()
        |> put_req_header("content-type", "application/json")
        |> post(Routes.accounts_path(conn, :create), body_request)
        |> json_response(422)

      assert %{
               "errors" => [
                 %{"cpf" => "can't be blank"}
               ]
             } = response
    end

    test "create an account with a invalid cpf", %{conn: conn} do
      cpf = "12312312312"

      body_request = %{
        cpf: cpf,
        name: "Paulo Henrique dos Santos Sacramento",
        birth_date: "06/01/2990",
        country: "BR",
        email: "contato@henriquesacramento.net",
        gender: "MALE",
        state: "BA",
        city: "Teixeira de Freitas"
      }

      response =
        conn
        |> put_authentication_token()
        |> put_req_header("content-type", "application/json")
        |> post(Routes.accounts_path(conn, :create), body_request)
        |> json_response(422)

      assert %{
               "errors" => [
                 %{"cpf" => "Invalid Cpf"}
               ]
             } = response
    end

    test "validate duplicated cpf", %{conn: conn} do
      cpf = "853.479.740-44"

      body_request = %{
        cpf: cpf,
        name: "Paulo Henrique dos Santos Sacramento",
        birth_date: "06/01/2990",
        country: "BR",
        email: "contato@henriquesacramento.net",
        gender: "MALE",
        state: "BA",
        city: "Teixeira de Freitas"
      }

      {:ok, _} = AccountMutator.create_or_update(body_request)

      response =
        conn
        |> put_authentication_token()
        |> put_req_header("content-type", "application/json")
        |> post(Routes.accounts_path(conn, :create), body_request)
        |> json_response(422)

      assert %{
               "errors" => [
                 %{"cpf" => "There is already an account for the cpf informed"}
               ]
             } = response
    end

    test "test a invitation", %{conn: conn} do
      cpf = "853.479.740-44"

      attrs = %{
        cpf: cpf,
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

      body_request = %{
        cpf: "215.918.660-06",
        name: "Paulo Henrique dos Santos Sacramento",
        birth_date: "06/01/2990",
        country: "BR",
        email: "contato@henriquesacramento.net",
        gender: "MALE",
        city: "Teixeira de Freitas",
        referral_code: referral_code.code
      }

      response =
        conn
        |> put_authentication_token()
        |> put_req_header("content-type", "application/json")
        |> post(Routes.accounts_path(conn, :create), body_request)
        |> json_response(201)

      assert %{
               "id" => id,
               "status" => "PENDING",
               "invitation_code" => ""
             } = response

      account = AccountLoader.get("215.918.660-06")

      assert account

      assert InvitationLoader.get_by(%{
               referral_account_id: referral_account.id,
               account_id: account.id
             })
    end
  end
end
