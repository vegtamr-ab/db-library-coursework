module Web.View.BookTypes.Edit where
import Web.View.Prelude

data EditView = EditView { bookType :: BookType }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={BookTypesAction}>BookTypes</a></li>
                <li class="breadcrumb-item active">Edit BookType</li>
            </ol>
        </nav>
        <h1>Edit BookType</h1>
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
