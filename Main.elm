module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App
import AnimationFrame exposing (diffs)
import Keyboard exposing (downs)
import Time exposing (inSeconds)


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


type alias Agent =
    { position : Point
    , direction : Direction
    }


type alias Wall =
    { columnNumber : Int
    , rowNumber : Int
    }


type alias Map =
    List Wall


type alias Model =
    { score : Int
    , player : Agent
    , map : Map
    }


init : ( Model, Cmd Msg )
init =
    ( { score = 0
      , player =
            { position = { x = 0, y = 0 }
            , direction = Right
            }
      , map = initialMap
      }
    , Cmd.none
    )


initialMap : Map
initialMap =
    [ { columnNumber = 10, rowNumber = 10 }
    , { columnNumber = 11, rowNumber = 10 }
    , { columnNumber = 12, rowNumber = 10 }
    , { columnNumber = 10, rowNumber = 11 }
    , { columnNumber = 12, rowNumber = 11 }
    , { columnNumber = 10, rowNumber = 12 }
    , { columnNumber = 12, rowNumber = 12 }
    ]



-- Update


type Msg
    = Tick Float
    | ChangeDirection Direction


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        player =
            model.player
    in
        case msg of
            Tick time ->
                let
                    moveDistance =
                        playerSpeed * Time.inSeconds time

                    newPlayer =
                        moveAgent player moveDistance
                in
                    ( { model | player = newPlayer }, Cmd.none )

            ChangeDirection direction ->
                ( { model | player = { player | direction = direction } }, Cmd.none )


{-| Takes an agent and a distance and moves the agent according to its
direction.
-}
moveAgent : Agent -> Float -> Agent
moveAgent agent distance =
    let
        newPosition =
            case agent.direction of
                Left ->
                    shiftPoint agent.position -distance 0

                Right ->
                    shiftPoint agent.position distance 0

                Up ->
                    shiftPoint agent.position 0 distance

                Down ->
                    shiftPoint agent.position 0 -distance
    in
        { agent | position = newPosition }


{-| Takes a point, a horizontal offset and a vertical offset and shifts the
point according to the two given offsets.
-}
shiftPoint : Point -> Float -> Float -> Point
shiftPoint point xOffset yOffset =
    { x = point.x + xOffset, y = point.y + yOffset }


{-| The player speed constant.
-}
playerSpeed : Float
playerSpeed =
    100



-- View


view : Model -> Html Msg
view model =
    background
        [ div []
            ([ player model.player ]
                ++ (walls model.map)
            )
        ]


background : List (Html Msg) -> Html Msg
background content =
    div
        [ style
            [ ( "backgroundColor", "black" )
            , ( "width", "100%" )
            , ( "height", "100%" )
            ]
        ]
        content


player : Agent -> Html Msg
player { position, direction } =
    div
        [ style
            [ ( "backgroundColor", "yellow" )
            , ( "width", "30px" )
            , ( "height", "30px" )
            , ( "borderRadius", "15px" )
            , ( "position", "absolute" )
            , ( "left", toString position.x ++ "px" )
            , ( "top", toString position.y ++ "px" )
            ]
        ]
        []


walls : Map -> List (Html Msg)
walls walls =
    let
        drawWall { columnNumber, rowNumber } =
            div
                [ style
                    [ ( "backgroundColor", "blue" )
                    , ( "width", "30px" )
                    , ( "height", "30px" )
                    , ( "position", "absolute" )
                    , ( "top", (columnNumber |> gridToPixels |> toString) ++ "px" )
                    , ( "left", (rowNumber |> gridToPixels |> toString) ++ "px" )
                    ]
                ]
                []
    in
        List.map drawWall walls



-- Position Helpers


gridPixelRatio : Int
gridPixelRatio =
    30


gridToPixels : Int -> Int
gridToPixels value =
    value * gridPixelRatio


pixelsToGrid : Int -> Int
pixelsToGrid value =
    value // gridPixelRatio



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    let
        directionForKey keyCode =
            case keyCode of
                37 ->
                    Left

                38 ->
                    Down

                39 ->
                    Right

                40 ->
                    Up

                _ ->
                    model.player.direction
    in
        Sub.batch
            [ AnimationFrame.diffs Tick
            , Keyboard.downs (\key -> ChangeDirection (directionForKey key))
            ]
