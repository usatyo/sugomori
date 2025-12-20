import { createContext, useState, type FC, type PropsWithChildren } from "react"

export const LoadingContext = createContext<{
  loading: boolean
  setLoading: React.Dispatch<React.SetStateAction<boolean>>
}>({
  loading: false,
  setLoading: () => {},
})

const LoadingProvider: FC<PropsWithChildren> = ({ children }) => {
  const [loading, setLoading] = useState<boolean>(false)

  return (
    <LoadingContext.Provider value={{ loading, setLoading }}>
      {children}
    </LoadingContext.Provider>
  )
}

export default LoadingProvider
