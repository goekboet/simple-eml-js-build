module Main exposing (main)

import Browser
import Html exposing (Html, h1, p, div, text, a)
import Html.Events exposing (onClick)
import Html.Attributes as Attr exposing (class, href)


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

type alias Item = String

type alias Model = (Int, List Item)

add : Model -> Model
add (n, is) = ( n + 1, String.fromInt n :: is)

remove : Model -> Item -> Model
remove (n, is) i = (n, List.filter (\x -> i /= x) is)

init : Flags -> (Model, Cmd Msg)
init f =
  ((0, []), Cmd.none)


-- UPDATE

type Msg 
  = Add
  | Remove Item

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
  case msg of
     Add      -> (add model, Cmd.none)
     Remove i -> (remove model i, Cmd.none)


-- VIEW
homelink : Html msg
homelink =
    div [ class "content"
        , class "heavy" 
        ] 
        [ h1 [] 
          [ a
            [ href "/"
            ]
            [ text "Template" ]
          ]
        ]

itemView : Item -> Html Msg
itemView i = Html.li [] 
  [ Html.h3 [] [ text i ]
  , Html.button [ onClick (Remove i)] [ text "Remove" ] ]

loremIpsum : Html Msg
loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." |> text

formlink : Html Msg -> Html Msg
formlink label = Html.form
            [ Attr.action "/"
            , Attr.method "post"
            , class "formlink"
            ]
            [ Html.button
                [ Attr.type_ "submit"
                ]
                [ label ]
            , Html.input
                [ Attr.type_ "hidden"
                , Attr.name "__RequestVerificationToken"
                , Attr.value "someToken"
                ]
                []
            ]

view : Model -> Browser.Document Msg
view (n, is) =
  { title = "Publish"
    , body =
        [ div 
        [ class "root-view" ] 
        [ homelink 
        , div 
          [ class "content"
          , class "light"
          , class "app-view" 
          ] 
          [ Html.h2 [] [ text "Fill me up" ]
          , Html.p [] [ loremIpsum ]
          , Html.p [] 
            [ text "A paragraph the purpose of which is to demonstrate an inline " 
            , a [] [ text "link" ]
            , text ". Links such as these are quite common and it's tremendously important that they find their place in the flow of things elegently."]
          , Html.hr [] []
          , Html.p [] 
           [ text "For " 
           , text "login" |> formlink
           , text " we need inline form."
           ] 
          , Html.hr [] []
          , Html.span [ class "templateInput" ] 
            [ Html.label [] [ Html.text "Sample input" ]
            , Html.input [ Attr.type_ "text", Attr.placeholder "placeholder" ] []
            ]
          , Html.hr [] []
          , Html.span [ class "templateAdd" ] 
            [ Html.label [] [ Html.text "This buttons adds elements below:"]
            , Html.button [ onClick Add ] [ Html.text ("Add: " ++ String.fromInt n)] ]
          , Html.hr [ class "line" ] []
          , Html.ul [ class "templateItems" ] ( List.map itemView is )
          ]
           
        ] 
      ]
    }
  

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions _ = Sub.none