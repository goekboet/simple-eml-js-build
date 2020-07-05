module Main exposing (main)

import Browser
import Html exposing (h1, p, div, text)


-- MAIN

type alias Flags = String

main : Program Flags Model Msg
main =
  Browser.document 
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL

type alias Model = String

init : Flags -> (Model, Cmd Msg)
init f =
  (f, Cmd.none)


-- UPDATE

type Msg = NoOp

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = (model, Cmd.none)


-- VIEW

view : Model -> Browser.Document Msg
view model =
    { title = "Publish"
    , body =
        [ div []
          [ h1 [] [ text "Next christmas" ]
          , p [] [ text model ] 
          ] 
        ]
    }
  

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions _ = Sub.none