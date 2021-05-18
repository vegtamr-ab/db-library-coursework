module Web.View.BookTypes.Index where
import Web.View.Prelude

data IndexView = IndexView { bookTypes :: [BookType] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={BookTypesAction}>BookTypes</a></li>
            </ol>
        </nav>
        <h1>Book Types <a href={pathTo NewBookTypeAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>BookType</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach bookTypes renderBookType}</tbody>
            </table>
        </div>
    |]


renderBookType bookType = [hsx|
    <tr>
        <td>{get #name bookType}</td>
        <td><a href={ShowBookTypeAction (get #id bookType)}>Show</a></td>
        <td><a href={EditBookTypeAction (get #id bookType)} class="text-muted">Edit</a></td>
        <td><a href={DeleteBookTypeAction (get #id bookType)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
