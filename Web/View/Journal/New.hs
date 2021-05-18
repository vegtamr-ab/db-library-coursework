module Web.View.Journal.New where
import Web.View.Prelude
import Data.Time.Clock
import Data.Time.Calendar

data NewView = NewView { journal :: Journal, books :: [Book], clients :: [Client] }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={JournalAction}>Journal</a></li>
                <li class="breadcrumb-item active">New Journal Entry</li>
            </ol>
        </nav>
        <h1>New Journal Entry</h1>
        {renderForm journal books clients}
    |]

instance CanSelect Book where
    type SelectValue Book = Id Book
    selectValue = get #id
    selectLabel = get #name

instance CanSelect Client where
    type SelectValue Client = Id Client
    selectValue = get #id
    selectLabel = (get #firstName) ++ (get #lastName)

renderForm :: Journal -> [Book] -> [Client] -> Html
renderForm journal books clients = formFor journal [hsx|
    {(selectField #bookId books)}
    {(selectField #clientId clients)}
    <div class="form-group" id="form-group-journal_date_beg">
        <label for="journal_dateBeg">Date Borrowed</label>
        <input type="date" name="dateBeg" id="journal_dateBeg" class="form-control" />
    </div>
    <div class="form-group" id="form-group-journal_date_end">
        <label for="journal_dateEnd">To Be Returned Before</label>
        <input type="date" name="dateEnd" id="journal_dateEnd" class="form-control" />
    </div>
    <script>
        var today = new Date();
        var dd = String(today.getDate()).padStart(2, '0');
        var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
        var yyyy = today.getFullYear();

        today = yyyy + '-' + mm + '-' + dd;
        document.getElementById('journal_dateBeg').value = today
    </script>
    <script>
        var today = new Date();
        var dd = String(today.getDate()).padStart(2, '0');
        var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
        var yyyy = today.getFullYear();

        today = yyyy + '-' + mm + '-' + dd;
        document.getElementById('journal_dateEnd').value = today
    </script>
    {(dateField #dateRet) { fieldLabel = "Date Returned", helpText = "Leave empty if not adding an entry retroactively" } }
    {submitButton}
|]
    where
        currentDate = do
            now <- getCurrentTime
            let today = utctDay now
            return $ show today
