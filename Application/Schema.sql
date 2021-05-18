-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE book_types (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    cnt INT NOT NULL,
    fine REAL NOT NULL,
    day_count INT NOT NULL
);
CREATE TABLE clients (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    pather_name TEXT DEFAULT NULL,
    passport_seria TEXT NOT NULL,
    passport_num TEXT NOT NULL
);
CREATE TABLE books (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    count INT NOT NULL,
    type_id UUID DEFAULT uuid_generate_v4() NOT NULL
);
CREATE TABLE journal (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    book_id UUID NOT NULL,
    client_id UUID NOT NULL,
    date_beg DATE DEFAULT NOW() NOT NULL,
    date_end DATE NOT NULL,
    date_ret DATE DEFAULT NULL
);
ALTER TABLE books ADD CONSTRAINT books_ref_type_id FOREIGN KEY (type_id) REFERENCES book_types (id) ON DELETE NO ACTION;
ALTER TABLE journal ADD CONSTRAINT journal_ref_book_id FOREIGN KEY (book_id) REFERENCES books (id) ON DELETE NO ACTION;
ALTER TABLE journal ADD CONSTRAINT journal_ref_client_id FOREIGN KEY (client_id) REFERENCES clients (id) ON DELETE NO ACTION;
