import { createContext, useState, type FC, type PropsWithChildren } from "react"

export const CardSizeContext = createContext<{
  size: number | undefined
  setSize: React.Dispatch<React.SetStateAction<number | undefined>>
}>({
  size: undefined,
  setSize: () => {},
})

const CardSizeProvider: FC<PropsWithChildren> = ({ children }) => {
  const [size, setSize] = useState<number | undefined>(undefined)

  return (
    <CardSizeContext.Provider value={{ size, setSize }}>
      {children}
    </CardSizeContext.Provider>
  )
}

export default CardSizeProvider
