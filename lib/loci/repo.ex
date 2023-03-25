defmodule Loci.Repo do
  use Ecto.Repo,
    otp_app: :loci,
    adapter: Ecto.Adapters.Postgres
end
