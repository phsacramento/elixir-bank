defmodule BankWeb.AuthenticationHelper do
  use Plug.Test

  def put_authentication_token(conn) do
    conn
    |> put_req_header(
      "authorization",
      "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJKb2tlbiIsImV4cCI6MTU4NzQzNTAzMCwiaWF0IjoxNTg3NDI3ODMwLCJpc3MiOiJKb2tlbiIsImp0aSI6IjJvM3FxY3Nua292ZGxqN3ZtZzAwMDIyMiIsIm5iZiI6MTU4NzQyNzgzMH0.cUwLvGZFFJ0t3d1KGygjCpEcStn5Uny7EiyRO7L3fjM"
    )
  end
end
