module Categories.Update where


import Data.Either (Either(..))
import Network.HTTP.Affjax (AJAX)
import Pux (EffModel, noEffects)

import Categories.Messages (Msg(..))
import Categories.Commands (fetchCategories)
import Categories.Models (CategoryData)

update :: forall e. Msg -> CategoryData -> EffModel CategoryData Msg (ajax :: AJAX | e)
update FetchCategories model =
    { state: model, effects: [ fetchCategories ] }
update (ReceiveCategories (Left _)) model =
    noEffects model
update (ReceiveCategories (Right newData)) _ =
    noEffects newData
update (ReceiveCategory (Left _)) model =
    noEffects model
update (ReceiveCategory (Right newData)) _ =
    noEffects newData
