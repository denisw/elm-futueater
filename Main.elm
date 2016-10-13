import Html exposing (..)
import Html.App

main : Program Never
main =
  Html.App.beginnerProgram
    { model = { score = 0, board = initialBoard }
    , view = view
    , update = update
    }

initialBoard : Board
initialBoard =
  []

-- Model
type alias Entity =
  { x : Float
  , y : Float
  }

type Cell =
  Agent Entity
  | Wall
  | Food
  | Empty

type alias Board = List (List Cell)

type alias Model =
  { score : Int
  , board : Board
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
