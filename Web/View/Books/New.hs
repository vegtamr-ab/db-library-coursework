module Web.View.Books.New where
import Web.View.Prelude

data NewView = NewView { book :: Book, bookTypes :: [BookType] }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={BooksAction}>Books</a></li>
                <li class="breadcrumb-item active">New Book</li>
            </ol>
        </nav>
        <h1>New Book</h1>
        {renderForm book bookTypes}
    |]

instance CanSelect BookType where
    type SelectValue BookType = Id BookType
    selectValue = get #id
    selectLabel = get #name

renderForm :: Book -> [BookType] -> Html
renderForm book bookTypes = formFor book [hsx|
    {(textField #name)}
    {(textField #count)}
    {(selectField #typeId bookTypes)}
    {submitButton}
|]