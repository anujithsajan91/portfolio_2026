-- ====================================================================
-- Supabase SQL Schema for Anujith Sajan Portfolio
-- Instructions:
-- 1. Open your project on https://supabase.com
-- 2. Go to the "SQL Editor" in the left sidebar
-- 3. Click "New Query", paste this entire script, and click "Run"
-- ====================================================================

-- 1. Create table for Contact Form Messages
CREATE TABLE IF NOT EXISTS public.messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    message TEXT NOT NULL,
    read BOOLEAN NOT NULL DEFAULT false
);

-- Enable Row Level Security (RLS)
ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;

-- Allow anonymous visitors (anyone using your portfolio) to send messages
CREATE POLICY "Allow public insert messages"
ON public.messages
FOR INSERT
TO anon
WITH CHECK (true);

-- Allow public read so the portfolio Admin dashboard (password-protected with 9048) can fetch messages across all browsers/devices
CREATE POLICY "Allow public read messages"
ON public.messages
FOR SELECT
TO anon
USING (true);

-- Allow public delete messages so the admin can delete messages from any browser
CREATE POLICY "Allow public delete messages"
ON public.messages
FOR DELETE
TO anon
USING (true);

-- Allow authenticated admin (when logged into Supabase dashboard) full management
CREATE POLICY "Allow authenticated read messages"
ON public.messages
FOR SELECT
TO authenticated
USING (true);

CREATE POLICY "Allow authenticated update messages"
ON public.messages
FOR UPDATE
TO authenticated
USING (true);

CREATE POLICY "Allow authenticated delete messages"
ON public.messages
FOR DELETE
TO authenticated
USING (true);


-- 2. Create table for Site Likes (Backend Stored Counter)
CREATE TABLE IF NOT EXISTS public.site_likes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    client_id TEXT NOT NULL UNIQUE
);

-- Enable Row Level Security (RLS) for site_likes
ALTER TABLE public.site_likes ENABLE ROW LEVEL SECURITY;

-- Allow anonymous visitors to read live like count
CREATE POLICY "Allow public read site_likes"
ON public.site_likes
FOR SELECT
TO anon
USING (true);

-- Allow anonymous visitors to insert 1 like
CREATE POLICY "Allow public insert site_likes"
ON public.site_likes
FOR INSERT
TO anon
WITH CHECK (true);


-- 3. Create table for Page Views (Basic)
CREATE TABLE IF NOT EXISTS public.page_views (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    visited_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    page_path TEXT DEFAULT '/',
    user_agent TEXT
);

-- Enable Row Level Security (RLS) for page_views
ALTER TABLE public.page_views ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public insert page_views"
ON public.page_views
FOR INSERT
TO anon
WITH CHECK (true);

CREATE POLICY "Allow authenticated read page_views"
ON public.page_views
FOR SELECT
TO authenticated
USING (true);


-- 4. Create table for Comprehensive Visitor Logs & Recruiter Analytics
CREATE TABLE IF NOT EXISTS public.visitor_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    visited_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    ip TEXT,
    country TEXT,
    country_code TEXT,
    region TEXT,
    city TEXT,
    postal TEXT,
    org TEXT,
    isp TEXT,
    latitude NUMERIC,
    longitude NUMERIC,
    device_type TEXT,
    os TEXT,
    browser TEXT,
    screen_res TEXT,
    viewport TEXT,
    language TEXT,
    timezone TEXT,
    referrer TEXT,
    ref_tag TEXT,
    page_path TEXT,
    visit_count INTEGER DEFAULT 1,
    user_agent TEXT
);

-- Indexes for fast ordering & recruiter tag queries
CREATE INDEX IF NOT EXISTS idx_visitor_logs_visited_at ON public.visitor_logs(visited_at DESC);
CREATE INDEX IF NOT EXISTS idx_visitor_logs_ref_tag ON public.visitor_logs(ref_tag);

-- Enable Row Level Security (RLS) for visitor_logs
ALTER TABLE public.visitor_logs ENABLE ROW LEVEL SECURITY;

-- Allow anonymous visitors to log telemetry
CREATE POLICY "Allow public insert visitor_logs"
ON public.visitor_logs
FOR INSERT
TO anon
WITH CHECK (true);

-- Allow public read so the Admin view in your portfolio can display visitor analytics
CREATE POLICY "Allow public read visitor_logs"
ON public.visitor_logs
FOR SELECT
TO anon
USING (true);

-- Allow public delete so admin can manage or clear visitor logs
CREATE POLICY "Allow public delete visitor_logs"
ON public.visitor_logs
FOR DELETE
TO anon
USING (true);

-- Allow authenticated admin full management
CREATE POLICY "Allow authenticated manage visitor_logs"
ON public.visitor_logs
FOR ALL
TO authenticated
USING (true);

-- Done! You can view received messages, likes, and visitor logs anytime under "Table Editor" in Supabase.
