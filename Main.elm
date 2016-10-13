module Main exposing (..)

import Html exposing (..)
import Html.App


-- Main


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- Model


type Direction
    = Left
    | Right
    | Up
    | Down


type alias Point =
    { x : Float
    , y : Float
    }


type alias Entity =
    { position : Point
    , direction : Direction
    }


type alias Model =
    { score : Int
    , player : Entity
    }


init : ( Model, Cmd Msg )
init =
    ( { score = 0, player = { position = { x = 0, y = 0 }, direction = Right } }
    , Cmd.none
    )



-- Update


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



-- View


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "FutuInvaders" ]
        ]



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
