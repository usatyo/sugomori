import LoadingProvider from "./LoadingProvider"
import MediaProvider from "./MediaProvider"

const Provider = ({ children }: { children: React.ReactNode }) => {
  return (
    <MediaProvider>
      <LoadingProvider>{children}</LoadingProvider>
    </MediaProvider>
  )
}

export default Provider
