module Web.View.Books.Index where
import Web.View.Prelude

data IndexView = IndexView { books :: [Include "typeId" Book], numBorrowed :: [Int] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <script src="sortTable.js"></script>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={BooksAction}>Books</a></li>
            </ol>
        </nav>
        <h1>Books <a href={pathTo NewBookAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table id="dbTable" class="table">
                <thead>
                    <tr>
                        <th class="sortableTh" onclick="sortTableByLex(0)">Book</th>
                        <th class="sortableTh" onclick="sortTableByLex(1)">Type</th>
                        <th class="sortableTh" onclick="sortTableByNum(2)">Count</th>
                        <th class="sortableTh" onclick="sortTableByNum(3)">Times borrowed</th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach (zip books numBorrowed) renderBook}</tbody>
            </table>
        </div>
    |] where bookTable = "bookTable"


renderBook (book, numBorrowed) = [hsx|
    <tr>
        <td>{get #name book}</td>
        <td>{book |> get #typeId |> get #name}</td>
        <td>{get #count book}</td>
        <td>{numBorrowed}</td>
        <td><a href={EditBookAction (get #id book)} class="text-muted">Edit</a></td>
        <td><a href={DeleteBookAction (get #id book)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
