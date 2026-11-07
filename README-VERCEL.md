# Birthday website — Vercel deployment

## What changed
- Replaced the PHP admin backend with Vercel Node.js API routes.
- Added `/admin` dashboard with password login, multi-profile management, photo upload, captions/order, letter and page-content editing.
- Profile JSON and uploaded photos are stored in Supabase, not on Vercel's temporary filesystem.
- Existing public birthday page, CSS, photos and animations are retained.

## 1. Create the Supabase database
1. Create a project at https://supabase.com.
2. Open **SQL Editor**, paste `supabase-setup.sql`, and run it.
3. In **Table Editor → profiles**, add two rows using the original JSON files:
   - `slug`: `vedika`, `data`: contents of `profiles/vedika.json`
   - `slug`: `akanksha`, `data`: contents of `profiles/akanksha.json`
4. Set `site_settings.default_slug` to `vedika` if needed.
5. In Project Settings → API, copy the Project URL and **service_role** key. Never expose the service role key in frontend code.

## 2. Deploy to Vercel
1. Upload this project folder to a GitHub repository.
2. Import that repository into https://vercel.com/new.
3. In Vercel → Project → Settings → Environment Variables, add:
   - `SUPABASE_URL`
   - `SUPABASE_SERVICE_ROLE_KEY`
   - `ADMIN_PASSWORD` (your own strong admin password)
   - `SESSION_SECRET` (random secret, at least 32 characters)
4. Redeploy after adding variables.

Generate a secret locally with:
`node -e "console.log(require('crypto').randomBytes(48).toString('hex'))"`

## 3. Use it
- Public site: your Vercel URL
- Admin: `https://YOUR-VERCEL-DOMAIN/admin`
- Share a specific profile: `https://YOUR-VERCEL-DOMAIN/?for=vedika`

## Notes
- PHP files are not used by this Vercel version.
- The `profiles/*.json` files are kept as source/reference copies, but the live site reads from Supabase.
- The first page load falls back to the built-in defaults if Supabase is not configured. The admin will show a configuration error until all environment variables and SQL setup are complete.
- Keep the Supabase service-role key private. Do not put it in `script.js`, HTML, GitHub README, or any `NEXT_PUBLIC_` variable.