module Categories.Edit exposing (..)


import Html exposing (Html, h1, div, text)

import Api.Models exposing (Category)
import Categories.Form
import Categories.Messages exposing (Msg)
import Categories.Models exposing (CategoryData)


view : Category -> CategoryData -> Html Msg
view category model =
    div []
        [ h1 [] [ text <| "Editing Category - " ++ category.name ]
        , Categories.Form.view model.categoryForm model.categories
        ]
