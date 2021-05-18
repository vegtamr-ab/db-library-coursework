module Web.Controller.Books where

import Web.Controller.Prelude
import Web.View.Books.Index
import Web.View.Books.New
import Web.View.Books.Edit
import Web.View.Books.Show

instance Controller BooksController where
    action BooksAction = do
        books <- query @Book |> fetch
            >>= collectionFetchRelated #typeId
        numBorrowed <- forM books \book -> do
            query @Journal
                |> filterWhere (#bookId, get #id book)
                |> fetchCount
        render IndexView { .. }

    action NewBookAction = do
        bookTypes <- query @BookType |> fetch
        let typeId = headMay bookTypes |> maybe def (get #id)
        let book = newRecord @Book |> set #typeId typeId
        render NewView { .. }

    action ShowBookAction { bookId } = do
        book <- fetch bookId
            >>= fetchRelated #typeId
        render ShowView { .. }

    action EditBookAction { bookId } = do
        book <- fetch bookId
        bookTypes <- query @BookType |> fetch
        render EditView { .. }

    action UpdateBookAction { bookId } = do
        book <- fetch bookId
        bookTypes <- query @BookType |> fetch
        book
            |> buildBook
            |> ifValid \case
                Left book -> render EditView { .. }
                Right book -> do
                    book <- book |> updateRecord
                    setSuccessMessage "Book updated"
                    redirectTo EditBookAction { .. }

    action CreateBookAction = do
        let book = newRecord @Book
        bookTypes <- query @BookType |> fetch
        book
            |> buildBook
            |> ifValid \case
                Left book -> render NewView { .. } 
                Right book -> do
                    book <- book |> createRecord
                  --  books <- query @Book |> fetch
                  --  let typeId = last books |> def (get #typeId)
                  --  let newCount = last books |> def (get #count)
                  --  oldCount :: Int <- sqlQueryScalar "SELECT cnt FROM bookTypes WHERE id = typeId" ()
                  --  bookType <- query @BookType |> findBy #id typeId
                  --  bookType
                  --      |> set #count (oldCount + newCount)
                    setSuccessMessage "Book created"
                    redirectTo BooksAction

    action DeleteBookAction { bookId } = do
        book <- fetch bookId
        deleteRecord book
        setSuccessMessage "Book deleted"
        redirectTo BooksAction

buildBook book = book
    |> fill @["name","count","typeId"]
    |> validateField #name nonEmpty
    |> validateField #count (isGreaterThan (-1) |> withCustomErrorMessage "Count should be 0 or more")
