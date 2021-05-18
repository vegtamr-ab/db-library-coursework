module Web.View.Journal.Show where
import Web.View.Prelude

data ShowView = ShowView { journal :: Journal }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={JournalAction}>Journal</a></li>
                <li class="breadcrumb-item active">Journal Entry</li>
            </ol>
        </nav>
        <h1>Journal Entry</h1>
    |]
