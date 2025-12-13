import { createContext, useState, type FC, type PropsWithChildren } from "react"
import { Joseki } from "../models/joseki"

export const JosekiContext = createContext<{
  joseki: Joseki
  setJoseki: React.Dispatch<React.SetStateAction<Joseki>>
}>({ joseki: new Joseki([]), setJoseki: () => {} })

const JosekiProvider: FC<PropsWithChildren> = ({ children }) => {
  const [joseki, setJoseki] = useState<Joseki>(new Joseki([]))

  return <JosekiContext value={{ joseki, setJoseki }}>{children}</JosekiContext>
}

export default JosekiProvider
