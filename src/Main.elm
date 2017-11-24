import Html exposing(..)
import Html.Attributes exposing (..)
import Html.Events exposing(onInput, onClick)


main =
  Html.beginnerProgram
    { model = model
    , update = update
    , view = view
    }

--model

type alias Model =
  { todo: String
  , todos: List String
  }

model =
  { todo = ""
  , todos = []
  }

type Msg
  = UpdateText String
  | AddItem
  | RemoveItem String

update msg model =
  case msg of
    UpdateText text ->
      { model | todo = text }

    AddItem ->
    { model | todos = model.todo :: model.todos }

    RemoveItem todo ->
    { model |
        todos =
          List.filter (\t -> t /= todo) model.todos }

--update

--view

todoItem todo =
  li [style[("list-style-type", "none")]]
    [ text todo
    , button [ onClick (RemoveItem todo), style[("margin-left","15px"), ("border-radius","3px"), ("font-size","8px")]] [ text "X" ]  
    ]


todoList todos =
  let
    children = List.map todoItem todos
  in
    ul [style[("margin","10px")]] children

view model =
  div [ style [
        ("padding","30px 0 10px 20px"), ("margin", "15px"), ("max-width","250px"), 
        ("background-color","#86caca"), ("border-radius","2px") ]
      ]
    [ input [ type_ "text"
            , onInput UpdateText
            , value model.todo
            , style[("margin-right", "10px"), ("border-radius","2px")]
            ] []
    , button [ onClick AddItem, style[("border-radius","2px")] ] [ text "Add Todo" ]
    -- , div [] [ text model.todo ]
    , todoList model.todos
    ]
 