import LoadingProvider from "./LoadingProvider"
import MediaProvider from "./MediaProvider"

const Provider = ({ children }: { children: React.ReactNode }) => {
  return (
    <LoadingProvider>
      <MediaProvider>{children}</MediaProvider>
    </LoadingProvider>
  )
}

export default Provider
