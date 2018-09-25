import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  }


init : Model
init =
  Model "" "" ""



-- UPDATE


type Msg
  = Name String
  | Password String
  | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ div [] [
           text "Name: "
           , viewInput "text" "Name" model.name Name ]
    , div [] [
           text "Password: "
           , viewInput "password" "Password" model.password Password ]
    , div [] [
           text "Password confirmation: "
           , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain ]
    , div [] [ viewValidation model ]
    ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []

isUpperChar c = String.contains c "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

isUpper str = map isUpperChar (String.toList str)

viewValidation : Model -> Html msg
viewValidation model =
  if String.length model.password < 8 then
    button [ style "background-color" "pink" ] [ text "Password too short" ]
  else if 
  else if model.password /= model.passwordAgain then
    button [ style "background-color" "pink" ] [ text "Passwords do not match!" ]
  else
    button [ style "background-color" "lightgreen" ] [ text "OK" ]
