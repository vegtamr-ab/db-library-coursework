module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types

data WebApplication = WebApplication deriving (Eq, Show)


data StaticController = WelcomeAction deriving (Eq, Show, Data)

data BooksController
    = BooksAction
    | NewBookAction
    | ShowBookAction { bookId :: !(Id Book) }
    | CreateBookAction
    | EditBookAction { bookId :: !(Id Book) }
    | UpdateBookAction { bookId :: !(Id Book) }
    | DeleteBookAction { bookId :: !(Id Book) }
    deriving (Eq, Show, Data)

data ClientsController
    = ClientsAction
    | NewClientAction
    | ShowClientAction { clientId :: !(Id Client) }
    | CreateClientAction
    | EditClientAction { clientId :: !(Id Client) }
    | UpdateClientAction { clientId :: !(Id Client) }
    | DeleteClientAction { clientId :: !(Id Client) }
    deriving (Eq, Show, Data)

data BookTypesController
    = BookTypesAction
    | NewBookTypeAction
    | ShowBookTypeAction { bookTypeId :: !(Id BookType) }
    | CreateBookTypeAction
    | EditBookTypeAction { bookTypeId :: !(Id BookType) }
    | UpdateBookTypeAction { bookTypeId :: !(Id BookType) }
    | DeleteBookTypeAction { bookTypeId :: !(Id BookType) }
    deriving (Eq, Show, Data)

data JournalController
    = JournalAction
    | NewJournalAction
    | ShowJournalAction { journalId :: !(Id Journal) }
    | CreateJournalAction
    | EditJournalAction { journalId :: !(Id Journal) }
    | UpdateJournalAction { journalId :: !(Id Journal) }
    | DeleteJournalAction { journalId :: !(Id Journal) }
    | ReturnJournalAction { journalId :: !(Id Journal) }
    deriving (Eq, Show, Data)
