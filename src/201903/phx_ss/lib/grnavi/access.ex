defmodule Grnavi.Access do

  def accesser(key) do

    url = "https://api.gnavi.co.jp/RestSearchAPI/v3/"
    prm = [keyid: "f6313561ae7bbcbd7c8c3df035c4317b", freeword: "インドカレー" <>" "<> key, hit_per_page: "15"]
    HTTPoison.get!(url, [], params: prm)
  end

  def makeText do

    url = "https://api.gnavi.co.jp/RestSearchAPI/v3/"
    prm = [keyid: "f6313561ae7bbcbd7c8c3df035c4317b", freeword: "釈迦", hit_per_page: "3"]
    HTTPoison.get!(url, [], params: prm)
    |> getBody
    |> Poison.decode!
    |> getRes
    |> getText
  end

  def makeText(key) do

    accesser(key)
    |> getBody
    |> Poison.decode!
    |> getRes
    |> getText
  end

  def getBody(%{body: bd}) do bd end

  def getRes(%{"rest" => res}) do res end

  def getRes(%{"error" => %{"message" => msg}}) do msg end

  def getCate(%{"rest" => x}) do x end

  # def getText(msg) do [msg] end

  def getText(maps) do getText(maps, []) end

  def getText([], list) do list end

  def getText([head | tail], list) do

    # 変数の取得
    %{"name" => nm, "code" => cds} = head
    %{"prefname" => prfnm, "prefcode" => prfcd} = cds

    # キーワードリストに格納
    ret = [%{name: nm, pref: prfnm, pcode: Util.Util.convStr2Int(prfcd)}] ++ list
    getText(tail, ret)
  end

  def getDecodes(item) do
    case item do
      {:ok, rtn} -> rtn
      {_, _} -> "error"
    end
  end
end
