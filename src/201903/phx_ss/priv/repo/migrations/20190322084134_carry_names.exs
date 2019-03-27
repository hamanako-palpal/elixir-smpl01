defmodule PhxSs.Repo.Migrations.CarryNames do
  use Ecto.Migration

  def change do

    create table(:curry) do
      add :shopId, :string
      add :title, :string
      add :pref, :string
    end
  end
end
