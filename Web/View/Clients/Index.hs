module Web.View.Clients.Index where
import Web.View.Prelude

data IndexView = IndexView { clients :: [Client], numBooks :: [Int], numBooksNow :: [Int], fines :: [Int] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <script src="sortTable.js"></script>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={ClientsAction}>Clients</a></li>
            </ol>
        </nav>
        <h1>Clients <a href={pathTo NewClientAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table id="dbTable" class="table">
                <thead>
                    <tr>
                        <th class="sortableTh" onclick="sortTableByLex(0)">Client</th>
                        <th>Passport</th>
                        <th class="sortableTh" onclick="sortTableByNum(2)">Fine</th>
                        <th class="sortableTh" onclick="sortTableByNum(3)">Books borrowed</th>
                        <th class="sortableTh" onclick="sortTableByNum(4)">Books at disposal</th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach (zip4 clients numBooks numBooksNow fines) renderClient}</tbody>
            </table>
        </div>
    |]


renderClient (client, numBooks, numBooksNow, fine) = [hsx|
    <tr>
        <td>{get #firstName client} {middleName} {get #lastName client}</td>
        <td>{get #passportSeria client} {get #passportNum client}</td>
        <td>{fine}</td>
        <td>{numBooks}</td>
        <td>{numBooksNow}</td>
        <td><a href={EditClientAction (get #id client)} class="text-muted">Edit</a></td>
        <td><a href={DeleteClientAction (get #id client)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
    where
        middleName = case get #patherName client of
            Just middle -> [hsx|{middle}|]
            Nothing -> [hsx||]
