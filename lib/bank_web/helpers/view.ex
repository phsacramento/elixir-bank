defmodule BankWeb.Helpers.View do
  use Phoenix.Controller, namespace: BankWeb

  def render_bad_request(conn), do: handle_bad_request(nil, conn)

  def render_index(nil, conn) do
    conn
    |> put_view(HermesApi.ErrorView)
    |> put_status(:not_found)
    |> render("404.json")
  end

  def render_index({:error, %{errors: errors}}, conn),
    do: handle_unprocessable_entity(errors, conn)

  def render_index([], conn) do
    conn
    |> put_view(HermesApi.ErrorView)
    |> put_status(:not_found)
    |> render("404.json")
  end

  def render_index(index, conn), do: render(conn, "index.json", index: index)

  def render_create({:ok, created}, conn) do
    conn
    |> put_status(:created)
    |> render("create.json", created: created)
  end

  def render_create({:error, :params_missing, params}, conn),
    do: handle_bad_request(params, conn)

  def render_create({:error, %{errors: errors}}, conn),
    do: handle_unprocessable_entity(errors, conn)

  defp handle_unprocessable_entity(errors, conn) do
    conn
    |> put_view(BankWeb.ErrorView)
    |> put_status(:unprocessable_entity)
    |> render("422.json", errors: errors)
  end

  defp handle_bad_request(params, conn) do
    conn
    |> put_view(BankWeb.ErrorView)
    |> put_status(:bad_request)
    |> render("400.json", params: params)
  end
end
