defmodule Grnavi.Access do

  def accesser(key) do

    url = "https://api.gnavi.co.jp/RestSearchAPI/v3/"
    prm = [keyid: "f6313561ae7bbcbd7c8c3df035c4317b", freeword: key, hit_per_page: "15"]
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

  def getCate(%{"rest" => x}) do x end

  def getText(maps) do getText(maps, []) end

  def getText([], list) do list end

  def getText([head | tail], list) do

    # 変数の取得
    %{"name" => x, "code" => y} = head
    %{"prefname" => prfnm, "prefcode" => prfcd} = y

    # キーワードリストに格納
    ret = [%{name: x, pref: prfnm, pcode: Util.Util.convStr2Int(prfcd)}] ++ list
    getText(tail, ret)
  end

  def getDecodes(item) do
    case item do
      {:ok, rtn} -> rtn
      {_, _} -> "error"
    end
  end
end
