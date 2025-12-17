import { Joseki, reversedColor } from "@/models/joseki"
import { JosekiContext } from "@/provider/JosekiProvider"
import { useContext } from "react"

const useOperationArea = () => {
  const { setJoseki, setNextColor } = useContext(JosekiContext)

  const clear = () => {
    setJoseki(new Joseki([]))
    setNextColor("black")
  }

  const backFive = () => {
    setJoseki((prev) => {
      const newJoseki = new Joseki([...prev.stoneList])
      newJoseki.popStones(5)
      return newJoseki
    })
    setNextColor((prev) => reversedColor(prev))
  }

  const back = () => {
    setJoseki((prev) => {
      const newJoseki = new Joseki([...prev.stoneList])
      newJoseki.popStone()
      return newJoseki
    })
    setNextColor((prev) => reversedColor(prev))
  }

  const pass = () => {
    // バックエンドの仕様と共通のため、手番を変えるだけで良い
    setNextColor((prev) => reversedColor(prev))
  }

  return { clear, backFive, back, pass }
}

export default useOperationArea
