module Page.Counter exposing (Model, Msg(..), init, update, view)

import Data.Counter exposing (Counter)
import Data.Session exposing (Session)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Route


type alias Model =
    { counter : Counter
    }


type Msg
    = Add
    | Substract
    | SetInterval Int


init : ( Model, Cmd Msg )
init =
    { counter = { value = 1, interval = 5 } } ! []


update : Session -> Msg -> Model -> ( Model, Cmd Msg )
update session msg ({ counter } as model) =
    case msg of
        Add ->
            { model | counter = { counter | value = counter.value + counter.interval } } ! []

        Substract ->
            { model | counter = { counter | value = counter.value - counter.interval } } ! []

        SetInterval interval ->
            { model | counter = { counter | interval = interval } } ! []


onInputInterval : String -> Msg
onInputInterval str =
    str
        |> String.toInt
        |> Result.withDefault 0
        |> SetInterval


view : Session -> Model -> Html Msg
view session ({ counter } as model) =
    div []
        [ h2 [] [ text "Counter" ]
        , div [ class "counter" ]
            [ img [ src "https://gist.githubusercontent.com/n1k0/6c67e2734bcd387ebec26cce23ee2c13/raw/44eff26fe13f8d827b28f193fdf7db1828ec366a/demo.svg" ] []
            , p []
                [ button [ onClick <| Substract ] [ text "-" ]
                , strong [] [ text <| toString counter.value ]
                , button [ onClick <| Add ] [ text "+" ]
                ]
            , p []
                [ text "Amount = "
                , text <| toString counter.interval
                , input
                    [ type_ "range"
                    , onInput onInputInterval
                    , value <| toString counter.interval
                    , Html.Attributes.min "1"
                    , Html.Attributes.max "10"
                    , size 3
                    ]
                    []
                ]
            ]
        , p [] [ a [ Route.href Route.Home ] [ text "Back to home" ] ]
        ]
