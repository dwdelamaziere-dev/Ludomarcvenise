-- A coller dans Supabase : menu de gauche "SQL Editor" > "New query" > Run.

create table if not exists entries (
  key        text primary key,
  value      jsonb not null,
  updated_at timestamptz not null default now()
);

alter table entries enable row level security;

-- Tout visiteur du site peut lire et ecrire. C'est voulu : les invites n'ont pas
-- de compte. Cela signifie aussi que toute personne disposant de l'adresse du
-- site peut lire et modifier les reponses.
drop policy if exists "acces invites" on entries;
create policy "acces invites" on entries
  for all to public
  using (true) with check (true);

grant select, insert, update, delete on table entries to anon, authenticated;
