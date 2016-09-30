import Html exposing (..)
import Html.App

main : Program Never
main =
  Html.App.beginnerProgram
    { model = { player = { x = 0, y = 0 }, invaders = [] }
    , view = view
    , update = update
    }

-- Model
type alias Drawable =
  { x : Float
  , y : Float
  }

type alias Model =
  { player : Drawable
  , invaders : List Drawable
  }

-- Update
type Msg = NoOp

update : Msg -> Model -> Model
update msg model =
  model

-- View
view : Model -> Html.Html Msg
view model =
  div []
    [ h1 [] [ text "FutuInvaders" ]
    ]
