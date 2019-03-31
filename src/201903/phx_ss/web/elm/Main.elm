module Main exposing(..)

import Browser
import Html exposing(..)
import Html.Events exposing(..)
import Http
import Json.Decode as Decode

main =
  Browser.sandbox { init = init, update = update, view = view }

type alias Model = 
  {datas : List Shop
  , edit : String
  }

type alias Shop = {shop : String}

init : ( Model, Cmd Msg )
init = (Model [Shop "koma"] "", Cmd.none)

type Msg
  = Editor String
  | GetShops
  | NewShops(Result Http.Error (List Shop))

update : Msg -> (Model, Cmd Msg) -> (Model, Cmd Msg)
update msg (model,_) = 
      case msg of
        GetShops -> (model, getShops)
        NewShops(Ok shops) -> (Model shops "ok", Cmd.none)
        NewShops(Err _) -> ({model | datas = [Shop "unti"]}, Cmd.none)
        Editor txt -> ({model | edit = txt}, Cmd.none)

view : (Model, Cmd Msg) -> Html Msg
view (mdl, _) = div []
  [ input [onInput Editor] []
  , button [onClick (GetShops)] [text "go"]
  , showList mdl
  ]

showList : Model -> Html msg
showList model = table []
                      ([thead[]
                        [th [][text "colume"]
                        ,th [][text model.edit]
                        ]
                      ]
                        ++ List.map toLi model.datas
                      )

toLi : Shop -> Html msg
toLi txt = tr [] 
                [td [][text <| txt.shop]
                ,td [][text <| String.fromInt 100]
                ]

getShops : Cmd Msg
getShops = 
  Http.send NewShops requestShops

requestShops : Http.Request (List Shop)
requestShops = 
    let
        url = "http://localhost:4000"
    in
      Debug.log "url"
      Http.get url (Decode.field "name"(Decode.list(Decode.map Shop Decode.string)))

logRequest : Http.Request (List Shop) -> Http.Request (List Shop)
logRequest req = 
            case req of
              {Ok shops} -> List.Map Debug.log (shops)
              {Err shops} -> List.Map Debug.log (shops)    