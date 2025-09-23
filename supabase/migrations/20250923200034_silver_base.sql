/*
  # Create links table for NoteKeeper

  1. New Tables
    - `links`
      - `id` (uuid, primary key)
      - `user_id` (uuid, foreign key to auth.users)
      - `url` (text, the saved URL)
      - `title` (text, optional title for the link)
      - `created_at` (timestamp)

  2. Security
    - Enable RLS on `links` table
    - Add policy for users to read their own links
    - Add policy for users to insert their own links
    - Add policy for users to delete their own links
*/

CREATE TABLE IF NOT EXISTS links (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  url text NOT NULL,
  title text,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE links ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can read own links"
  ON links
  FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own links"
  ON links
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete own links"
  ON links
  FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id);