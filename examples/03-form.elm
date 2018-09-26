import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)

-- Goals
-- [] Lay out the HTML components in a table or using grid or flex

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
      [
      table []
            [ tr [] [ td [] [text "Name: "]
                    , td [] [viewInput "text" "Name" model.name Name]
                    ]
            , tr [] [ td [] [text "Password: "]
                    , td [] [viewInput "password" "Password" model.password Password]
                    ]
            , tr [] [td [] [text "Password confirmation: "]
                    , td [] [viewInput "password" "Re-enter Password"
                                 model.passwordAgain PasswordAgain]
                    ]
            ]
      , div [] [ viewValidation model ]
      ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []

hasUpper : String -> Bool
hasUpper str = String.any Char.isUpper str

hasLower : String -> Bool
hasLower str = String.any Char.isLower str

hasNumber : String -> Bool
hasNumber str = String.any Char.isDigit str

viewValidation : Model -> Html msg
viewValidation model =
  if model.password /= model.passwordAgain then
    button [ style "background-color" "pink" ] [ text "Passwords do not match!" ]
  else if String.length model.password < 8 then
    button [ style "background-color" "pink" ] [ text "Password too short" ]
  else if not (hasUpper model.password) then
    button [ style "background-color" "pink" ] [ text "Password must contain uppercase" ]
  else if not (hasLower model.password) then
    button [ style "background-color" "pink" ] [ text "Password must contain lowercase" ]
  else if not (hasNumber model.password) then
    button [ style "background-color" "pink" ] [ text "Password must contain number" ]
  else if String.length model.name < 3 then
    button [ style "background-color" "pink" ] [ text "Name length must be at least 3" ]
  else
    button [ style "background-color" "lightgreen" ] [ text "OK" ]
