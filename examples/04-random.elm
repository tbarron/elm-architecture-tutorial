import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Random
import Svg exposing (svg)


-- MAIN


main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }



-- MODEL


type alias Model =
  { history : List Int
    , dieFace : Int
  }


init : () -> (Model, Cmd Msg)
init _ =
  ( Model [] 3
  , Cmd.none
  )



-- UPDATE


type Msg
  = Roll
  | NewFace Int


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      ( { model | history = model.history ++ [ model.dieFace ] }
      , Random.generate NewFace (Random.int 1 6)
      )
      , Random.generate NewFace (Random.int 1 6)
      )

    NewFace newFace ->
      ( Model newFace
      , Cmd.none
      )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

history : Model -> String
history model =
    case model.history of
        [] ->
            "history: []"

        first :: rest ->
            "history: [ " ++ (String.join "," (List.map String.fromInt model.history)) ++ " ]"


-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text (String.fromInt model.dieFace) ]
    , button [ onClick Roll ] [ text "Roll" ]
    ]      , p [] [ text (history model) ]
      , p [] [ text (history model) ]
