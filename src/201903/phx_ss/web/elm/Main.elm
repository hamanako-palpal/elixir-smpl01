module Main exposing(..)

import Browser
import Html exposing(..)
import Html.Events exposing(..)
import Http
import Json.Decode as Decode
import Dict

main : Program () Model Msg
main =
  Browser.element
     { init = init
     , update = update
     , view = view
     , subscriptions = \_ -> Sub.none
     }

type alias Model = 
  {datas : List Shop
  , edit : String
  }

type alias Shop = {shop : String}

init : () -> ( Model, Cmd Msg )
init _ = (Model [Shop "ShowList"] "", Cmd.none)

type Msg
  = Editor String
  | GetShops
  | NewShops(Result Http.Error (List Shop))

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
      case msg of
        GetShops -> (model, getShops)
        NewShops res ->
          case res of
            Ok shops ->
              ({model | datas = shops}, Cmd.none)
            Err reason ->
              ({model | datas = [Shop (httpErrorToString reason)]}, Cmd.none)
        Editor txt -> ({model | edit = txt}, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

view : Model -> Html Msg
view mdl = div []
  [ input [onInput Editor] []
  , button [onClick (GetShops)] [text "go"]
  , showList mdl
  ]

showList : Model -> Html msg
showList model = table []
                      [thead[]
                        [th [][text "colume"]
                        ,th [][text model.edit]
                        ]
                      ,tbody[] <| List.map toLi model.datas
                      ]

toLi : Shop -> Html msg
toLi txt = Debug.log txt.shop
              tr []
                [td [][text <| txt.shop]
                ,td [][text <| String.fromInt 100]
                ]

getShops : Cmd Msg
getShops =
    Http.request
      { method = "GET"
        , headers =
            [ Http.header "Accept" "application/json"
            , Http.header "Content-Type" "application/json"
            ]
      , url = "http://localhost:4000/update"
      , expect = Http.expectJson NewShops(decoders)
      , body = Http.emptyBody
      , timeout = Nothing
      , tracker = Nothing 
      }

decoders : Decode.Decoder (List Shop)
decoders =
  Decode.list decoder

decoder : Decode.Decoder (Shop)
decoder =
  Decode.map Shop(Decode.field "name" Decode.string)

httpErrorToString : Http.Error -> String
httpErrorToString err =
    case err of
        Http.BadUrl _ ->
            "BadUrl"

        Http.Timeout ->
            "Timeout"

        Http.NetworkError ->
            "NetworkError"

        Http.BadStatus _ ->
            "BadStatus"

        Http.BadBody s ->
            "BadBody: " ++ s
