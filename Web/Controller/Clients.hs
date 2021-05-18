module Web.Controller.Clients where

import Web.Controller.Prelude
import Web.View.Clients.Index
import Web.View.Clients.New
import Web.View.Clients.Edit
import Web.View.Clients.Show

instance Controller ClientsController where
    action ClientsAction = do
        clients <- query @Client |> fetch
        numBooks <- forM clients \client -> do
            query @Journal
                |> filterWhere (#clientId, get #id client)
                |> fetchCount
        numBooksNow <- forM clients \client -> do
            query @Journal
                |> filterWhere (#clientId, get #id client)
                |> filterWhereSql (#dateRet, "IS NULL")
                |> fetchCount
        commonFines <- forM clients \client -> do
            query @Journal
                |> filterWhere (#clientId, get #id client)
                |> filterWhereSql (#bookId, "IN (SELECT ID FROM BOOKS WHERE TYPE_ID IN (SELECT ID FROM BOOK_TYPES WHERE FINE = 10))")
                |> filterWhereSql (#dateRet, "IS NULL")
                |> filterWhereSql (#dateEnd, "< CURRENT_DATE")
                |> fetchCount
        rareFines <- forM clients \client -> do
            query @Journal
                |> filterWhere (#clientId, get #id client)
                |> filterWhereSql (#bookId, "IN (SELECT ID FROM BOOKS WHERE TYPE_ID IN (SELECT ID FROM BOOK_TYPES WHERE FINE = 50))")
                |> filterWhereSql (#dateRet, "IS NULL")
                |> filterWhereSql (#dateEnd, "< CURRENT_DATE")
                |> fetchCount
        uniqueFines <- forM clients \client -> do
            query @Journal
                |> filterWhere (#clientId, get #id client)
                |> filterWhereSql (#bookId, "IN (SELECT ID FROM BOOKS WHERE TYPE_ID IN (SELECT ID FROM BOOK_TYPES WHERE FINE = 300))")
                |> filterWhereSql (#dateRet, "IS NULL")
                |> filterWhereSql (#dateEnd, "< CURRENT_DATE")
                |> fetchCount
        --commonDays :: [Int] <- forM clientIds \clientId -> do
        --    sqlQueryScalar "select sum(date_part) from (select date_part('day', current_date - date_end::timestamp) from journal where date_ret is null and date_end < current_date and book_id in (select id from books where type_id in (select id from book_types where fine = 10)) and client_id = ?) as days" (Only clientId)
        let fines' = zipWith (+) (map (*10) commonFines) (map (*50) rareFines)
        let fines = zipWith (+) fines' (map (*300) uniqueFines)

        render IndexView { .. }

    action NewClientAction = do
        let client = newRecord
        render NewView { .. }

    action ShowClientAction { clientId } = do
        client <- fetch clientId
        render ShowView { .. }

    action EditClientAction { clientId } = do
        client <- fetch clientId
        render EditView { .. }

    action UpdateClientAction { clientId } = do
        client <- fetch clientId
        client
            |> buildClient
            |> ifValid \case
                Left client -> render EditView { .. }
                Right client -> do
                    client <- client |> updateRecord
                    setSuccessMessage "Client updated"
                    redirectTo EditClientAction { .. }

    action CreateClientAction = do
        let client = newRecord @Client
        client
            |> buildClient
            |> validateIsUnique #passportNum
            >>= ifValid \case
                Left client -> render NewView { .. } 
                Right client -> do
                    client <- client |> createRecord
                    setSuccessMessage "Client created"
                    redirectTo ClientsAction

    action DeleteClientAction { clientId } = do
        client <- fetch clientId
        deleteRecord client
        setSuccessMessage "Client deleted"
        redirectTo ClientsAction

buildClient client = client
    |> fill @["firstName","lastName","patherName","passportSeria","passportNum"]
    |> validateField #firstName nonEmpty
    |> validateField #lastName nonEmpty
    |> validateField #passportSeria (validateAll([hasMinLength(4), hasMaxLength(4)]) |> withCustomErrorMessage "Passport serial number must be 4 characters")
    |> validateField #passportNum (validateAll([hasMinLength(6), hasMaxLength(6)]) |> withCustomErrorMessage "Passport unique number must be 6 characters")
