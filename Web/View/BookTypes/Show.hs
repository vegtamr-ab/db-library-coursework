module Web.View.BookTypes.Show where
import Web.View.Prelude

data ShowView = ShowView { bookType :: Include "books" BookType }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={BookTypesAction}>BookTypes</a></li>
                <li class="breadcrumb-item active">{get #name bookType}</li>
            </ol>
        </nav>
        <h1>{get #name bookType}</h1>
        <p>Days to return: {get #dayCount bookType}</p>
        <p>Fine: {get #fine bookType}</p>
        <h3>Books with this type:</h3>
        <div class="table-responsive">
            <table class="table">
                <thead>
                </thead>
                <tbody>{forEach (bookType |> get #books) renderBook}</tbody>
            </table>
        </div>
    |]

renderBook book = [hsx|
    <tr>
        <td>{get #name book}</td>
    </tr>
|]