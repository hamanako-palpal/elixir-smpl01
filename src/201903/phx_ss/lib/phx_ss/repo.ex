defmodule PhxSs.Repo do
  use Ecto.Repo,
      otp_app: :phx_ss,
      adapter: Mongo.Ecto
end
