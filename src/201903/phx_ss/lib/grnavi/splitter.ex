defmodule Grnavi.Splitter do
  # 単語を形態素解析し、計上する
  def splitText(word) do
    word
    |> makeText
    |> getBody
    |> requestCheck
  end

  def makeText(word) do

    api_key = "64536d482f5351676257354755514f4b705355676a71636f6962776937596f75385777527a6b4952363735"
    url = "https://api.apigw.smt.docomo.ne.jp/gooLanguageAnalysis/v1/morph?"

    headers = [{"Content-Type", "application/json;charset=UTF-8"}]
    body = Poison.encode!(%{
      request_id: "record001",
      sentence: word,
      info_filter: "form"
    })
    prm = [APIKEY: api_key]
    HTTPoison.post(url,body,headers,[])

  end

  def getBody({:ok, %{body: bd}}) do bd end

  def requestCheck(%{"word_list"=> li}) do li end

end
