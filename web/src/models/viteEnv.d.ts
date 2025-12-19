interface ImportMetaEnv {
  readonly VITE_JOSEKI_API_URL: string
  readonly VITE_JOSEKI_API_BEARER_TOKEN: string
}

interface ImportMeta {
  readonly env: ImportMetaEnv
}