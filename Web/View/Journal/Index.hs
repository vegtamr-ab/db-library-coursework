module Web.View.Journal.Index where
import Web.View.Prelude

data IndexView = IndexView { journal :: [Include' ["bookId", "clientId"] Journal] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={JournalAction}>Journal</a></li>
            </ol>
        </nav>
        <h1>Journal <a href={pathTo NewJournalAction} class="btn btn-primary ml-4">+ Lend out a book</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Book</th>
                        <th>Client</th>
                        <th>Date given</th>
                        <th>Return until</th>
                        <th>Date returned</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach journal renderJournal}</tbody>
            </table>
        </div>
        <div class="libNavButton">
            <div id="box1">
                <a href="/BookTypes" style="margin-top: 2rem; background-color: #268bd2; padding: 1rem; border-radius: 3px; color: hsla(205, 69%, 98%, 1); text-decoration: none; font-weight: bold; display: inline-block; box-shadow: 0 4px 6px hsla(205, 69%, 0%, 0.08);  transition: box-shadow 0.2s; transition: transform 0.2s;" target="_blank">
                    BookTypes
                </a>
            </div>
            <div id="box2">
                <a href="/Books" style="margin-top: 2rem; background-color: #268bd2; padding: 1rem; border-radius: 3px; color: hsla(205, 69%, 98%, 1); text-decoration: none; font-weight: bold; display: inline-block; box-shadow: 0 4px 6px hsla(205, 69%, 0%, 0.08);  transition: box-shadow 0.2s; transition: transform 0.2s;" target="_blank">
                    Books
                </a>
            </div>
            <div id="box3">
                <a href="/Clients" style="margin-top: 2rem; background-color: #268bd2; padding: 1rem; border-radius: 3px; color: hsla(205, 69%, 98%, 1); text-decoration: none; font-weight: bold; display: inline-block; box-shadow: 0 4px 6px hsla(205, 69%, 0%, 0.08);  transition: box-shadow 0.2s; transition: transform 0.2s;" target="_blank">
                    Clients
                </a>
            </div>
        </div>
    |]

renderJournal journal = [hsx|
    <tr>
        <td>{journal |> get #bookId |> get #name}</td>
        <td>{journal |> get #clientId |> get #firstName} {journal |> get #clientId |> get #lastName}</td>
        <td>{get #dateBeg journal}</td>
        <td>{get #dateEnd journal}</td>
        <td>{dateReturned}</td>
        <td><a href={DeleteJournalAction (get #id journal)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
    where
        dateReturned = case get #dateRet journal of
            Just dateRet -> [hsx|{dateRet}|]
            Nothing -> [hsx|<a href={ReturnJournalAction (get #id journal)} >Return</a>|]
