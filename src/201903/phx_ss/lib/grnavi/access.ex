defmodule Grnavi.Access do

  def accesser(key) do

    url = "https://api.gnavi.co.jp/RestSearchAPI/v3/"
    prm = [keyid: "6e17ab013585e3e4682dc8566d4f408b",
        freeword: "インドカレー" <>","<> key,
        hit_per_page: "15"]

    HTTPoison.get!(url, [], params: prm)
  end

  def makeText(key) do

    accesser(key)
    |> getBody
    |> Poison.decode!
    |> getRes
  end

  def getBody(%{body: bd}) do bd end

  def getRes(%{"rest" => res}) do res |> getText end

  def getRes(%{"error" => [%{"message" => msg} | _]}) do msg end

  def getCate(%{"rest" => x}) do x end

  def getText(maps) do getText(maps, []) end

  def getText([], list) do list end

  def getText([head | tail], list) do

    # 変数の取得
    %{"id" => json_id, "name" => json_name} = head

    # キーワードリストに格納
    ret = [%{id: json_id, name: json_name}] ++ list
    getText(tail, ret)
  end

  def getDecodes(item) do
    case item do
      {:ok, rtn} -> rtn
      {_, _} -> "error"
    end
  end
end
