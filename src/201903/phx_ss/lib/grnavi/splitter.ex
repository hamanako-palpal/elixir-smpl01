defmodule Grnavi.Splitter do
  # 単語を形態素解析し、計上する
    def makeText do

      api_key = "64536d482f5351676257354755514f4b705355676a71636f6962776937596f75385777527a6b4952363735"
      url = "https://api.apigw.smt.docomo.ne.jp/gooLanguageAnalysis/v1/morph?APIKEY="<>api_key

      headers = [{"Content-Type", "application/json;charset=UTF-8"}]
      body = Poison.encode!(%{
        request_id: "record001",
        sentence: "日本語を分析します。",
        info_filter: "form"
      })
      HTTPoison.post(url,body,headers,[])
      |> getBody
      |> Poison.decode!
      |> requestCheck

    end

    def getBody({:ok, %{body: bd}}) do bd end

    def requestCheck(%{"word_list"=> li}) do li end

end
