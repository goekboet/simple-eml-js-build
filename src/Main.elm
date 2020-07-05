module Main exposing (main)

import Browser
import Html exposing (button, div, text)
import Html.Events exposing (onClick)



-- MAIN

type alias Flags = Int

main : Program Flags Model Msg
main =
  Browser.document 
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL

type alias Model = Int

init : Flags -> (Model, Cmd Msg)
init f =
  (0, Cmd.none)


-- UPDATE

type Msg = Increment | Decrement

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Increment ->
      (model + 1, Cmd.none)

    Decrement ->
      (model - 1, Cmd.none)


-- VIEW

view : Model -> Browser.Document Msg
view model =
    { title = "Publish"
    , body =
        [ div []
          [ button [ onClick Decrement ] [ text "-" ]
          , div [] [ text (String.fromInt model) ]
          , button [ onClick Increment ] [ text "+" ]
          ] 
        ]
    }
  

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions _ = Sub.none