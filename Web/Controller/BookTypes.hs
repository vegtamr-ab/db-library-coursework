module Web.Controller.BookTypes where

import Web.Controller.Prelude
import Web.View.BookTypes.Index
import Web.View.BookTypes.New
import Web.View.BookTypes.Edit
import Web.View.BookTypes.Show

instance Controller BookTypesController where
    action BookTypesAction = do
        bookTypes <- query @BookType |> fetch
        render IndexView { .. }

    action NewBookTypeAction = do
        let bookType = newRecord
        render NewView { .. }

    action ShowBookTypeAction { bookTypeId } = do
        bookType <- fetch bookTypeId
            >>= fetchRelated #books
        render ShowView { .. }

    action EditBookTypeAction { bookTypeId } = do
        bookType <- fetch bookTypeId
        render EditView { .. }

    action UpdateBookTypeAction { bookTypeId } = do
        bookType <- fetch bookTypeId
        bookType
            |> buildBookType
            |> ifValid \case
                Left bookType -> render EditView { .. }
                Right bookType -> do
                    bookType <- bookType |> updateRecord
                    setSuccessMessage "BookType updated"
                    redirectTo EditBookTypeAction { .. }

    action CreateBookTypeAction = do
        let bookType = newRecord @BookType
        bookType
            |> buildBookType
            |> ifValid \case
                Left bookType -> render NewView { .. } 
                Right bookType -> do
                    bookType <- bookType |> createRecord
                    setSuccessMessage "BookType created"
                    redirectTo BookTypesAction

    action DeleteBookTypeAction { bookTypeId } = do
        bookType <- fetch bookTypeId
        deleteRecord bookType
        setSuccessMessage "BookType deleted"
        redirectTo BookTypesAction

buildBookType bookType = bookType
    |> fill @["name","cnt","fine","dayCount"]
    |> validateField #name nonEmpty
    |> validateField #cnt (isGreaterThan (-1) |> withCustomErrorMessage "Count should be 0 or more")
    |> validateField #fine (isGreaterThan (-0.01) |> withCustomErrorMessage "Fine should be 0.0 or more")
    |> validateField #dayCount (isGreaterThan (-1) |> withCustomErrorMessage "Days to return should be 0 or more")
