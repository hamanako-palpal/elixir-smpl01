defmodule Util.Util do

  def extractNum(txt)do
    txt |> String.replace(~r/[^\d]/, "")
  end

  def convStr2Int(txt)do
    txt
    |> extractNum
    |> String.to_integer
  end
end
