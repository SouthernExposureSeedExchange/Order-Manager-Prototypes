port module Categories.Commands exposing (..)

import Json.Decode as Decode exposing ((:=))
import Api.Decoders exposing (categoryDecoder, productDecoder)
import Api.Http exposing (..)
import Api.Models exposing (CategoryId, Category, Product, initialCategory)
import Categories.Form exposing (initialErrors)
import Categories.Messages exposing (..)
import Categories.Models exposing (CategoryData)


port confirmCategoryDeletion : ( CategoryId, String ) -> Cmd msg


port categoryDeleteWasConfirmed : (CategoryId -> msg) -> Sub msg


fetchAll : Cmd Msg
fetchAll =
    get CategoriesEndpoint categoriesDecoder FetchAllFail FetchAllDone


fetchOne : CategoryId -> Cmd Msg
fetchOne categoryId =
    get (CategoryEndpoint categoryId) categoriesDecoder FetchOneFail (FetchOneDone categoryId)


deleteOne : CategoryId -> Cmd Msg
deleteOne categoryId =
    delete (CategoryEndpoint categoryId) (Decode.succeed categoryId) DeleteOneFail DeleteOneDone


categoriesDecoder : Decode.Decoder CategoryData
categoriesDecoder =
    Decode.object4 CategoryData
        ("category" := Decode.list categoryDecoder)
        ("product" := Decode.list productDecoder)
        (Decode.succeed initialCategory)
        (Decode.succeed initialErrors)
