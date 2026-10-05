-- =========================================================
-- MamaQuilla · Instalación de la base de datos (Supabase)
-- Pegar todo en: Supabase → SQL Editor → New query → Run
-- ANTES: cambia el correo de la línea marcada con  <<< CAMBIAR
-- =========================================================

-- 1) Tabla con el contenido editable de la web (una sola fila)
create table if not exists public.sitio (
  id int primary key default 1 check (id = 1),
  datos jsonb not null default '{}'::jsonb,
  actualizado timestamptz not null default now()
);

-- 2) Lista de administradoras (correos que pueden editar)
create table if not exists public.admins (email text primary key);
insert into public.admins (email)
values (lower('correo-de-la-duena@gmail.com'))   -- <<< CAMBIAR
on conflict do nothing;

create or replace function public.es_admin()
returns boolean language sql stable security definer set search_path = public as $$
  select exists (select 1 from public.admins where email = lower(auth.jwt() ->> 'email'));
$$;

-- 3) Permisos: todos pueden LEER, solo las administradoras pueden EDITAR
alter table public.sitio  enable row level security;
alter table public.admins enable row level security;   -- nadie puede leer esta lista desde la web

drop policy if exists "sitio lectura publica" on public.sitio;
drop policy if exists "sitio admin inserta"  on public.sitio;
drop policy if exists "sitio admin edita"    on public.sitio;
create policy "sitio lectura publica" on public.sitio for select using (true);
create policy "sitio admin inserta"  on public.sitio for insert to authenticated with check (public.es_admin());
create policy "sitio admin edita"    on public.sitio for update to authenticated using (public.es_admin()) with check (public.es_admin());

insert into public.sitio (id) values (1) on conflict do nothing;

-- 4) Carpeta pública para las fotos
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('fotos', 'fotos', true, 5242880, array['image/jpeg','image/png','image/webp'])
on conflict (id) do nothing;

drop policy if exists "fotos lectura publica" on storage.objects;
drop policy if exists "fotos admin sube"      on storage.objects;
drop policy if exists "fotos admin borra"     on storage.objects;
create policy "fotos lectura publica" on storage.objects for select using (bucket_id = 'fotos');
create policy "fotos admin sube"  on storage.objects for insert to authenticated with check (bucket_id = 'fotos' and public.es_admin());
create policy "fotos admin borra" on storage.objects for delete to authenticated using (bucket_id = 'fotos' and public.es_admin());
