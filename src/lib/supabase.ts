import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error('Missing Supabase environment variables')
}

export const supabase = createClient(supabaseUrl, supabaseAnonKey)

export type Database = {
  public: {
    Tables: {
      links: {
        Row: {
          id: string
          user_id: string
          url: string
          title: string | null
          created_at: string
        }
        Insert: {
          id?: string
          user_id: string
          url: string
          title?: string | null
          created_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          url?: string
          title?: string | null
          created_at?: string
        }
      }
    }
  }
}