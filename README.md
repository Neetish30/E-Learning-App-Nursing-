# NurseEd — free mobile e-learning web app

Static site (HTML/CSS/JS, no build step) hosted on **GitHub Pages**, with **Supabase** (free tier) for accounts, database and file storage.

**Students:** sign up / log in, dashboard with progress, course catalogue and details, lessons (text, video, PDF, flash cards, pamphlets/images, links), assessments, profile.
**Admin:** sees every student (username, password, email), their courses and progress, resets passwords, and uploads/creates courses, modules, lessons and assessments.

## One-time setup (~15 minutes, all free, no credit card)

1. **Supabase project** — sign up at supabase.com → *New project*.
2. **Database** — *SQL Editor* → paste all of `supabase/schema.sql` → Run. (Optional: run `supabase/sample_content.sql` for a demo course.)
3. **Turn OFF email confirmation** — *Authentication → Sign In / Providers → Email* → disable **Confirm email**. (Otherwise students must click a mail link before logging in.)
4. **Keys** — *Project Settings → API*: copy **Project URL** and the **anon public** key into `js/config.js`. The anon key is meant to be public; never put the `service_role` key anywhere.
5. **GitHub Pages** — merge this branch into `main`, then repo *Settings → Pages → Deploy from a branch → main / (root)*. Your link: `https://<user>.github.io/E-Learning-App-Nursing-/`
   *(Note: GitHub Pages on a free account requires the repo to be public.)*
6. **Allow your site URL** — Supabase *Authentication → URL Configuration* → set Site URL to the link above.
7. **Make yourself admin** — open the site, sign up with your admin username, then in the SQL Editor run:
   ```sql
   update profiles set role = 'admin' where username = 'your_admin_username';
   ```
   Log out and in again. You'll see the admin console.

Share the link with your students. They create their own accounts.

## Adding content
Admin → **Courses** → New → open it → *Add module* → *Add lesson / content*. Choose the type:
| Type | How |
|---|---|
| Video | Paste a YouTube (use *Unlisted*), Google Drive or Vimeo link — free and unlimited. Or upload an .mp4 up to 50 MB. |
| PDF / Pamphlet / Image | Upload a file (≤ 50 MB) or paste a link |
| Text | Write notes (`# Heading`, `- bullets`, `**bold**`) |
| Flash cards | One per line: `Question \| Answer` |
Admin → **Tests** → New → add questions (multiple choice, with explanations).

## Free-tier limits to know
- Supabase free: 500 MB database, **1 GB file storage**, 50 MB per file, and projects **pause after 7 days of no activity** (restore with one click in the dashboard; 50 active students will keep it awake).
- Quiz answers are graded on the server, so students cannot read correct answers from the browser.

## ⚠️ About visible passwords
By request, the admin can see each student's password (stored in `profiles.password_plain`). This is a security trade-off: if the admin account is compromised, all passwords leak, and students who reuse passwords are at risk. The signup screen warns students not to reuse passwords. To switch it off later, run `update profiles set password_plain = null;` and delete the two `password_plain` lines in `js/app.js` — the admin can still reset passwords.
