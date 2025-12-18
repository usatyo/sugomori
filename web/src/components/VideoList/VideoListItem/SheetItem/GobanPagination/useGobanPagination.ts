import useJosekiApi from "@/hooks/useJosekiApi"
import { Joseki } from "@/models/joseki"
import { JosekiContext } from "@/provider/JosekiProvider"
import { useContext, useEffect, useState } from "react"

const useGobanPagination = (videoId: string) => {
  const { getJoseki, postJoseki, deleteJoseki } = useJosekiApi()
  const [josekiList, setJosekiList] = useState<Array<Joseki>>([])
  const [currentIndex, setCurrentIndex] = useState<number>(0)
  const { joseki, isEditable, setJoseki, setIsEditable } =
    useContext(JosekiContext)

  const updateJosekiList = async () => {
    const updatedJosekiList = await getJoseki(videoId)
    setJosekiList(updatedJosekiList)
  }

  const onAddJoseki = async () => {
    await postJoseki(videoId, joseki)
    await updateJosekiList()
    setIsEditable(false)
  }

  const onDeleteJoseki = async () => {
    await deleteJoseki(videoId, joseki)
    await updateJosekiList()
  }

  const onStartAdding = () => {
    setIsEditable(true)
    setJoseki(new Joseki([]))
  }

  useEffect(() => {
    setIsEditable(false)
    const asyncData = async () => {
      await updateJosekiList()
    }
    asyncData()
  }, [])

  useEffect(() => {
    if (currentIndex < 0 || currentIndex >= josekiList.length) {
      setJoseki(new Joseki([]))
    } else {
      setJoseki(josekiList[currentIndex])
    }
  }, [currentIndex, josekiList])

  return {
    josekiList,
    currentIndex,
    isEditable,
    setCurrentIndex,
    onAddJoseki,
    onDeleteJoseki,
    setIsEditable,
    onStartAdding,
  }
}

export default useGobanPagination
