create table if not exists public.profiles (
  slug text primary key check (slug ~ '^[a-z0-9-]{1,40}$'),
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
create table if not exists public.site_settings (
  id integer primary key check (id=1),
  default_slug text not null
);
insert into public.site_settings(id,default_slug) values (1,'vedika')
on conflict (id) do nothing;

-- Create the public photo bucket. Uploads are performed only by the server using
-- the service-role key; the public URL lets the birthday website display images.
insert into storage.buckets(id,name,public,file_size_limit,allowed_mime_types)
values ('birthday-photos','birthday-photos',true,10485760,
 array['image/jpeg','image/png','image/webp','image/gif'])
on conflict (id) do update set public=true;