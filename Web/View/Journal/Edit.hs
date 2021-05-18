module Web.View.Journal.Edit where
import Web.View.Prelude

data EditView = EditView { journal :: Journal }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={JournalAction}>Journals</a></li>
                <li class="breadcrumb-item active">Edit Journal</li>
            </ol>
        </nav>
        <h1>Edit Journal</h1>
        {renderForm journal}
    |]

renderForm :: Journal -> Html
renderForm journal = formFor journal [hsx|

    {submitButton}
|]
