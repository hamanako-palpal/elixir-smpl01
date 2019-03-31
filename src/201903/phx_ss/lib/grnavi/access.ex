defmodule Grnavi.Access do
  def makeText do
    url = "https://api.gnavi.co.jp/RestSearchAPI/v3/"

    prm = [keyid: "f6313561ae7bbcbd7c8c3df035c4317b", freeword: "寺"]
    HTTPoison.get!(url, [], params: prm)
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
    %{"name" => x} = head
    ret = [%{name: x}] ++ list
    getText(tail, ret)
  end

  def getDecodes(item) do
    case item do
      {:ok, rtn} -> rtn
      {_, _} -> "error"
    end
  end
end
