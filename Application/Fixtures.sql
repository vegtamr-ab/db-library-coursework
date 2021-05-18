

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.book_types DISABLE TRIGGER ALL;

INSERT INTO public.book_types (id, name, cnt, fine, day_count) VALUES ('5d5509b7-6072-4f2b-9412-97e28c889e30', 'Обычный', 0, 10, 60);
INSERT INTO public.book_types (id, name, cnt, fine, day_count) VALUES ('5db3536f-3eb9-4b15-948d-ad69bb76e036', 'Редкий', 0, 50, 21);
INSERT INTO public.book_types (id, name, cnt, fine, day_count) VALUES ('38ecd256-b794-4a12-91cf-d1bafccb8477', 'Уникальный', 0, 300, 7);


ALTER TABLE public.book_types ENABLE TRIGGER ALL;


ALTER TABLE public.books DISABLE TRIGGER ALL;

INSERT INTO public.books (id, name, count, type_id) VALUES ('99126fc2-7966-4c44-841c-aab50f7b2256', 'Игра в классики', 6, '5db3536f-3eb9-4b15-948d-ad69bb76e036');
INSERT INTO public.books (id, name, count, type_id) VALUES ('7513e869-a49c-416d-9b20-68d40997d701', 'Война и мир', 32, '5d5509b7-6072-4f2b-9412-97e28c889e30');
INSERT INTO public.books (id, name, count, type_id) VALUES ('4a9991ef-690b-4b75-a480-56039a7fe3c4', 'Анна Каренина', 12, '5d5509b7-6072-4f2b-9412-97e28c889e30');
INSERT INTO public.books (id, name, count, type_id) VALUES ('44e68ef2-977a-45b0-9f9f-b0246670d3c3', '62. Модель для сборки', 2, '38ecd256-b794-4a12-91cf-d1bafccb8477');
INSERT INTO public.books (id, name, count, type_id) VALUES ('bc012c16-c63d-4a2f-9ca7-d0c3ec95c277', 'Гиперболоид инженера Гарина', 4, '5db3536f-3eb9-4b15-948d-ad69bb76e036');
INSERT INTO public.books (id, name, count, type_id) VALUES ('dd116aa3-d9c3-47d6-bb70-5c78d5c4c6a8', 'Улисс', 2, '38ecd256-b794-4a12-91cf-d1bafccb8477');
INSERT INTO public.books (id, name, count, type_id) VALUES ('64df5ba5-4419-4808-8418-79f26b9291fd', 'Гроздья Гнева', 38, '5d5509b7-6072-4f2b-9412-97e28c889e30');
INSERT INTO public.books (id, name, count, type_id) VALUES ('2a1d4804-ac97-492d-8d0b-3c31e6321e9c', 'Learn You a Haskell for Great Good!', 0, '38ecd256-b794-4a12-91cf-d1bafccb8477');


ALTER TABLE public.books ENABLE TRIGGER ALL;


ALTER TABLE public.clients DISABLE TRIGGER ALL;

INSERT INTO public.clients (id, first_name, last_name, pather_name, passport_seria, passport_num) VALUES ('e6a2184b-e4bf-498f-8285-77027810faa1', 'Сергей', 'Витте', 'Юльевич', '1234', '567891');
INSERT INTO public.clients (id, first_name, last_name, pather_name, passport_seria, passport_num) VALUES ('ef8f188e-6eb8-4447-b832-b9f6196228b9', 'Петр', 'Столыпин', 'Аркадьевич', '2232', '339653');


ALTER TABLE public.clients ENABLE TRIGGER ALL;


ALTER TABLE public.journal DISABLE TRIGGER ALL;

INSERT INTO public.journal (id, book_id, client_id, date_beg, date_end, date_ret) VALUES ('4d7d8d4a-233f-48b0-a467-f81c7cccf968', 'dd116aa3-d9c3-47d6-bb70-5c78d5c4c6a8', 'e6a2184b-e4bf-498f-8285-77027810faa1', '2021-05-06', '2021-05-13', '2021-05-07');
INSERT INTO public.journal (id, book_id, client_id, date_beg, date_end, date_ret) VALUES ('d343646e-de39-4f30-b498-f616fe3e4110', '44e68ef2-977a-45b0-9f9f-b0246670d3c3', 'e6a2184b-e4bf-498f-8285-77027810faa1', '2021-05-07', '2021-05-14', '2021-05-07');
INSERT INTO public.journal (id, book_id, client_id, date_beg, date_end, date_ret) VALUES ('4b3264a6-7883-40d4-b481-bc643e0dc9b6', '99126fc2-7966-4c44-841c-aab50f7b2256', 'e6a2184b-e4bf-498f-8285-77027810faa1', '2021-05-07', '2021-05-28', '2021-05-07');
INSERT INTO public.journal (id, book_id, client_id, date_beg, date_end, date_ret) VALUES ('336acb0c-9376-4385-8901-9e9cd22de5a4', '4a9991ef-690b-4b75-a480-56039a7fe3c4', 'e6a2184b-e4bf-498f-8285-77027810faa1', '2021-05-07', '2021-08-07', '2021-05-17');
INSERT INTO public.journal (id, book_id, client_id, date_beg, date_end, date_ret) VALUES ('c179332d-15c6-4e67-96a0-29a9b597b438', '44e68ef2-977a-45b0-9f9f-b0246670d3c3', 'ef8f188e-6eb8-4447-b832-b9f6196228b9', '2021-05-18', '2021-05-25', NULL);
INSERT INTO public.journal (id, book_id, client_id, date_beg, date_end, date_ret) VALUES ('e834997f-7f8d-48ba-9f24-0256e71ebe1f', '7513e869-a49c-416d-9b20-68d40997d701', 'e6a2184b-e4bf-498f-8285-77027810faa1', '2021-05-18', '2021-08-31', NULL);
INSERT INTO public.journal (id, book_id, client_id, date_beg, date_end, date_ret) VALUES ('e631986a-2e6d-4b79-8657-73a9a494c020', 'bc012c16-c63d-4a2f-9ca7-d0c3ec95c277', 'ef8f188e-6eb8-4447-b832-b9f6196228b9', '2021-04-01', '2021-04-22', NULL);
INSERT INTO public.journal (id, book_id, client_id, date_beg, date_end, date_ret) VALUES ('42d19ad0-6510-48d4-bc72-ef402e570f6b', '64df5ba5-4419-4808-8418-79f26b9291fd', 'ef8f188e-6eb8-4447-b832-b9f6196228b9', '2021-02-01', '2021-05-01', NULL);


ALTER TABLE public.journal ENABLE TRIGGER ALL;


