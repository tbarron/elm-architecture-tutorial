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
  | Reset
  | NewFace Int


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      ( { model | history = model.history ++ [ model.dieFace ] }
      , Random.generate NewFace (Random.int 1 6)
      )

    Reset ->
      ( { model | history = [] }
      , Random.generate NewFace (Random.int 1 6)
      )

    NewFace newFace ->
      ( { model | dieFace = newFace }
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

-- dieFace1 =
--    svg [ svg.width "60" , svg.height "60" , Cmd.none ]

view : Model -> Html Msg
view model =
  div []
      [ -- text (String.join "," (List.map String.fromInt model.history))
            -- h1 [] [ text (String.fromInt model.dieFace) ]
      table [ style "width" "500px"
              -- , style "border" "solid"
              -- , style "margin" "auto"
              -- , style "justify" "center"
              ]
              [ tr []
                   [ td [] [h1 [] [ text (String.fromInt model.dieFace) ]]]
              , tr []
                   [ td []
                        [button [ onClick Roll] [ text "Roll" ]]
                   , td []
                        [button [ onClick Reset ] [ text "Reset" ]]
                   ]
              , tr []
                   [ td [] [text (history model)]
                   ]
              ]
      ]
