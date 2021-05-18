module Web.Controller.Journal where

import Web.Controller.Prelude
import Web.View.Journal.Index
import Web.View.Journal.New
import Web.View.Journal.Edit
import Web.View.Journal.Show

instance Controller JournalController where
    action JournalAction = do
        journal <- query @Journal |> fetch
            >>= collectionFetchRelated #bookId
            >>= collectionFetchRelated #clientId
        render IndexView { .. }

    action NewJournalAction = do
        let journal = newRecord
        books <- query @Book
            |> filterWhereSql (#count, "> 0")
            |> fetch
        clients <- query @Client |> fetch
        render NewView { .. }

    action ShowJournalAction { journalId } = do
        journal <- fetch journalId
        render ShowView { .. }

    action EditJournalAction { journalId } = do
        journal <- fetch journalId
        render EditView { .. }

    action UpdateJournalAction { journalId } = do
        journal <- fetch journalId
        journal
            |> buildJournal
            |> ifValid \case
                Left journal -> render EditView { .. }
                Right journal -> do
                    journal <- journal |> updateRecord
                    setSuccessMessage "Journal updated"
                    redirectTo EditJournalAction { .. }

    action CreateJournalAction = do
        let journal = newRecord @Journal
        books <- query @Book
            |> filterWhereSql (#count, "> 0")
            |> fetch
        clients <- query @Client |> fetch
        let bookId = param @(Id Book) "bookId"
        journal
            |> buildJournal
            |> ifValid \case
                Left journal -> render NewView { .. } 
                Right journal -> do
                    journal <- journal |> createRecord
                    setSuccessMessage "Journal created"
                    redirectTo JournalAction

    action DeleteJournalAction { journalId } = do
        journal <- fetch journalId
        deleteRecord journal
        setSuccessMessage "Entry deleted"
        redirectTo JournalAction

    action ReturnJournalAction { journalId } = do
        journal <- fetch journalId
        now <- getCurrentTime
        let (year, month, day) = toGregorian $ utctDay now
        journal
            |> set #dateRet (fromGregorianValid year month day)
            |> updateRecord
        setSuccessMessage "Book returned"
        redirectTo JournalAction

buildJournal journal = journal
    |> fill @'["bookId","clientId","dateBeg","dateEnd","dateRet"]
