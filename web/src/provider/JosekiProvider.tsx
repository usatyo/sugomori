import { createContext, useState, type FC, type PropsWithChildren } from "react"
import { Joseki, type StoneColor } from "../models/joseki"

export const JosekiContext = createContext<{
  joseki: Joseki
  setJoseki: React.Dispatch<React.SetStateAction<Joseki>>
  nextColor: StoneColor
  setNextColor: React.Dispatch<React.SetStateAction<StoneColor>>
}>({
  joseki: new Joseki([]),
  setJoseki: () => {},
  nextColor: "black",
  setNextColor: () => {},
})

const JosekiProvider: FC<PropsWithChildren> = ({ children }) => {
  const [joseki, setJoseki] = useState<Joseki>(new Joseki([]))
  const [nextColor, setNextColor] = useState<StoneColor>("black")

  return (
    <JosekiContext.Provider
      value={{ joseki, setJoseki, nextColor, setNextColor }}
    >
      {children}
    </JosekiContext.Provider>
  )
}

export default JosekiProvider
