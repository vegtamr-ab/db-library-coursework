module Web.View.BookTypes.New where
import Web.View.Prelude

data NewView = NewView { bookType :: BookType }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={BookTypesAction}>BookTypes</a></li>
                <li class="breadcrumb-item active">New BookType</li>
            </ol>
        </nav>
        <h1>New BookType</h1>
        {renderForm bookType}
    |]

renderForm :: BookType -> Html
renderForm bookType = formFor bookType [hsx|
    {(textField #name)}
    {(textField #cnt)}
    {(textField #fine)}
    {(textField #dayCount)}
    {submitButton}
|]
