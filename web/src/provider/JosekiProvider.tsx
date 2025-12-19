import { createContext, useState, type FC, type PropsWithChildren } from "react"
import { Joseki, type StoneColor } from "../models/joseki"

export const JosekiContext = createContext<{
  joseki: Joseki
  setJoseki: React.Dispatch<React.SetStateAction<Joseki>>
  nextColor: StoneColor
  setNextColor: React.Dispatch<React.SetStateAction<StoneColor>>
  isEditable: boolean
  setIsEditable: React.Dispatch<React.SetStateAction<boolean>>
}>({
  joseki: new Joseki([]),
  setJoseki: () => {},
  nextColor: "black",
  setNextColor: () => {},
  isEditable: true,
  setIsEditable: () => {}
})

const JosekiProvider: FC<PropsWithChildren> = ({ children }) => {
  const [joseki, setJoseki] = useState<Joseki>(new Joseki([]))
  const [nextColor, setNextColor] = useState<StoneColor>("black")
  const [isEditable, setIsEditable] = useState<boolean>(true)

  return (
    <JosekiContext.Provider
      value={{ joseki, setJoseki, nextColor, setNextColor, isEditable, setIsEditable }}
    >
      {children}
    </JosekiContext.Provider>
  )
}

export default JosekiProvider
