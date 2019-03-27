module Main exposing(..)

import Browser
import Html exposing(..)
import Html.Events exposing(..)

main =
  Browser.sandbox { init = init, update = update, view = view }

type alias Model = 
  {datas : List String
  , edit : String
  }

init : Model
init = {
  datas = []
  , edit = ""
  }

type Msg =
  Editor String
  | Increase 

update : Msg -> Model -> Model
update msg model = 
      case msg of
        Increase -> {model | datas = model.datas ++ [model.edit]}
        Editor txt -> {model | edit = txt}

view : Model -> Html Msg
view mdl = div [] 
  [ input [onInput Editor] []
  , button [onClick (Increase)] [text "go"]
  , showList mdl
  ]

showList : Model -> Html msg
showList model = table []
                      ([thead[]
                        [th [][text "colume"]
                        ,th [][text "number"]
                        ]
                      ]
                        ++ List.map toLi model.datas
                      )

toLi : String -> Html msg
toLi txt = tr [] 
                [td [][text txt]
                ,td [][text <| String.fromInt 100]
                ]