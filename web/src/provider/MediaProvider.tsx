import {
  createContext,
  useEffect,
  useState,
  type FC,
  type PropsWithChildren,
} from "react"

export const MediaContext = createContext<{
  isMobile: boolean
  setIsMobile: React.Dispatch<React.SetStateAction<boolean>>
}>({
  isMobile: false,
  setIsMobile: () => {},
})

const MediaProvider: FC<PropsWithChildren> = ({ children }) => {
  const [isMobile, setIsMobile] = useState<boolean>(false)

  useEffect(() => {
    if (
      window.matchMedia &&
      window.matchMedia("(max-device-width: 640px)").matches
    ) {
      setIsMobile(true)
    } else {
      setIsMobile(false)
    }
  }, [])

  return (
    <MediaContext.Provider value={{ isMobile, setIsMobile }}>
      {children}
    </MediaContext.Provider>
  )
}

export default MediaProvider
