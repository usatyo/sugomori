import useJosekiApi from "@/hooks/useJosekiApi"
import { Joseki } from "@/models/joseki"
import { JosekiContext } from "@/provider/JosekiProvider"
import { LoadingContext } from "@/provider/LoadingProvider"
import { useContext, useEffect, useState } from "react"

const useGobanPagination = (videoId: string) => {
  const { getJoseki, postJoseki, deleteJoseki } = useJosekiApi()
  const [josekiList, setJosekiList] = useState<Array<Joseki>>([])
  const [currentIndex, setCurrentIndex] = useState<number>(0)
  const { joseki, isEditable, setJoseki, setIsEditable, setNextColor } =
    useContext(JosekiContext)
  const { setLoading } = useContext(LoadingContext)

  const updateJosekiList = async () => {
    const updatedJosekiList = await getJoseki(videoId)
    setJosekiList(updatedJosekiList)
  }

  const onAddJoseki = async () => {
    setLoading(true)
    await postJoseki(videoId, joseki)
    await updateJosekiList()
    setIsEditable(false)
    setLoading(false)
  }

  const onCancelAdding = () => {
    setIsEditable(false)
    setCurrentIndex(0)
    setJoseki(josekiList.length > 0 ? josekiList[0] : new Joseki([]))
  }

  const onDeleteJoseki = async () => {
    setLoading(true)
    await deleteJoseki(videoId, joseki)
    await updateJosekiList()
    setCurrentIndex(0)
    setLoading(false)
  }

  const onStartAdding = () => {
    setIsEditable(true)
    setJoseki(new Joseki([]))
    setNextColor("black")
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
    onCancelAdding,
    onDeleteJoseki,
    setIsEditable,
    onStartAdding,
  }
}

export default useGobanPagination
