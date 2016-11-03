module Agent exposing (..)

import Time


type Direction
    = Left
    | Right
    | Up
    | Down


type alias Point =
    { x : Float
    , y : Float
    }


type alias Size =
    { width : Float
    , height : Float
    }


type alias Model =
    { position : Point
    , size : Size
    , speed : Float
    , direction : Direction
    }



-- Update


type Msg
    = Move Time.Time
    | UpdateDirection Direction


update : Msg -> Model -> ( Model, Cmd Msg )
