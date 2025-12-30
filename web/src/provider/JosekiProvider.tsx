import {
  createContext,
  useContext,
  useEffect,
  useState,
  type FC,
  type PropsWithChildren,
} from "react"
import { Joseki, type StoneColor } from "../models/joseki"
import { MediaContext } from "./MediaProvider"

export const JosekiContext = createContext<{
  joseki: Joseki
  setJoseki: React.Dispatch<React.SetStateAction<Joseki>>
  nextColor: StoneColor
  setNextColor: React.Dispatch<React.SetStateAction<StoneColor>>
  isEditable: boolean
  setIsEditable: React.Dispatch<React.SetStateAction<boolean>>
  isZooming: boolean
  setIsZooming: React.Dispatch<React.SetStateAction<boolean>>
}>({
  joseki: new Joseki([]),
  setJoseki: () => {},
  nextColor: "black",
  setNextColor: () => {},
  isEditable: true,
  setIsEditable: () => {},
  isZooming: false,
  setIsZooming: () => {},
})

const JosekiProvider: FC<PropsWithChildren> = ({ children }) => {
  const { isMobile } = useContext(MediaContext)
  const [joseki, setJoseki] = useState<Joseki>(new Joseki([]))
  const [nextColor, setNextColor] = useState<StoneColor>("black")
  const [isEditable, setIsEditable] = useState<boolean>(true)
  const [isZooming, setIsZooming] = useState<boolean>(false)

  useEffect(() => {
    if (isMobile) {
      setIsZooming(true)
    }
  }, [isMobile])

  return (
    <JosekiContext.Provider
      value={{
        joseki,
        setJoseki,
        nextColor,
        setNextColor,
        isEditable,
        setIsEditable,
        isZooming,
        setIsZooming,
      }}
    >
      {children}
    </JosekiContext.Provider>
  )
}

export default JosekiProvider
