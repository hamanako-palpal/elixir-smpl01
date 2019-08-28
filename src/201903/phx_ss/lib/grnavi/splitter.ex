defmodule Grnavi.Splitter do
  # 単語を要素ごとに分解して、計上する
    def splitter() do
      Mecab.parse("委託販売で届いた本や雑誌がお金を刷るように売れてた時期からやってた本屋は努力とか言う言葉を知らないので潰れるのは当たり前")
    end

    def makeText do

      url = "https://api.apigw.smt.docomo.ne.jp/gooLanguageAnalysis/v1/morph"
      api_key = "64536d482f5351676257354755514f4b705355676a71636f6962776937596f75385777527a6b4952363735"
      headers = [{"Content-Type", "application/json"}]
      body = Poison.encode!(%{
        request_id: "record001",
        sentence: "日本語を分析します。",
        info_filter: "form"
      })
      HTTPoison.post!(url,body,headers, [APIKEY: api_key])
      |> getBody
      |> requestCheck

    end

    def getBody(%{body: bd}) do bd end

    def requestCheck(%{"word_list": li}) do li end

end
