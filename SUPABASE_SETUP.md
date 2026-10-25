# Supabase Backend Setup Guide

This portfolio includes a complete Supabase backend integration to store contact messages and visitor analytics directly in your Supabase database.

---

## 3-Minute Quick Setup

### Step 1: Create a Free Project on Supabase
1. Go to [https://supabase.com](https://supabase.com) and sign in or sign up.
2. Click **"New Project"**.
3. Choose a name (e.g., `portfolio-backend`), set a database password, and select your region (e.g., South Asia / Mumbai or Singapore).
4. Wait about 1-2 minutes for your project to provision.

---

### Step 2: Run the SQL Schema
1. In your Supabase Dashboard, click on **SQL Editor** from the left navigation bar (icon `>_`).
2. Click **"New Query"**.
3. Open [`SUPABASE_SETUP.sql`](./SUPABASE_SETUP.sql), copy all lines, paste them into the SQL Editor, and click **Run**.
4. You will see `Success. No rows returned`.
   - This creates the `messages` table with Row Level Security (RLS) properly configured so visitors can submit messages, and only you can read or delete them.
   - It also optionally creates a `page_views` table for tracking visits.

---

### Step 3: Add Credentials to `supabase-config.js`
1. In your Supabase Dashboard, click **Project Settings** (gear icon at the bottom of the left sidebar).
2. Go to **API**.
3. Copy:
   - **Project URL** (e.g. `https://your-project-id.supabase.co`)
   - **Project API Keys** -> `anon` / `public` key (a long string starting with `eyJ...`)
4. Open [`supabase-config.js`](./supabase-config.js) and paste them:

```javascript
window.SUPABASE_CONFIG = {
  url: 'https://your-project-id.supabase.co',
  anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...'
};
```

---

## How It Works

1. **Automatic Form Handling:**
   - When a visitor enters their name, email, and message on your portfolio and clicks **"Send Message"**, the data is inserted directly into the `messages` table in Supabase.
   - A real-time success confirmation appears right inside the form (`✓ Message sent successfully!`).
   - If Supabase credentials are not set yet, the form gracefully falls back to launching your default email client (`mailto:`) so no inquiries are ever lost!

2. **Viewing Messages:**
   - In Supabase, go to **Table Editor** -> `messages` to view all messages sent by recruiters, clients, or collaborators.
   - You can mark them as read, export them to CSV, or set up email/webhook notifications via Supabase Database Webhooks!

3. **Background Music:**
   - Ambient lo-fi background music is **default-on**.
   - Browsers with strict autoplay policies will seamlessly start playback as soon as the visitor interacts with the page (scrolling, clicking, or touching).
   - Visitors can pause or resume audio anytime via the animated Equalizer button at the top right.

4. **Visitor Telemetry & Analytics:**
   - As visitors browse your portfolio, telemetry is automatically captured and saved both locally and to the Supabase `visitor_logs` table.
   - **Captured Data Points**:
     - **Location & Network**: IP address, Country, City, State/Region, Postal Code, and ISP / Organization (e.g., Google, Amazon, Infosys corporate networks).
     - **Device & Software**: Device type (Desktop/Mobile), Operating System (Windows, macOS, iOS, Android), Browser & version (Chrome, Safari, Firefox, Edge), Screen resolution, Viewport size.
     - **Traffic & Recruiter Tracking**: Referrer URL (e.g. LinkedIn, GitHub), Timezone, Visit timestamp, and Custom recruiter tag (`?ref=...`).
   - **Recruiter Tracking Links**:
     - When submitting resumes or emailing recruiters, share tailored links like:
       - `https://your-domain.com/?ref=google`
       - `https://your-domain.com/?ref=microsoft`
       - `https://your-domain.com/?ref=linkedin`
     - When the recruiter opens the link, the Admin view (`?admin=1`, password `9048`) will prominently highlight them under the **👁️ Visitors** tab!


