module Web.FrontController where

import IHP.RouterPrelude
import Web.Controller.Prelude
import Web.View.Layout (defaultLayout)

-- Controller Imports
import Web.Controller.Journal
import Web.Controller.BookTypes
import Web.Controller.Clients
import Web.Controller.Books
import Web.Controller.Static

instance FrontController WebApplication where
    controllers = 
        [ startPage WelcomeAction
        -- Generator Marker
        , parseRoute @JournalController
        , parseRoute @BookTypesController
        , parseRoute @ClientsController
        , parseRoute @BooksController
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh
