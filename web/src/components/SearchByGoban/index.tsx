import useJosekiApi from "@/hooks/useJosekiApi"
import { JosekiContext } from "@/provider/JosekiProvider"
import { LoadingContext } from "@/provider/LoadingProvider"
import { useContext, type Dispatch, type FC, type SetStateAction } from "react"
import Goban from "../Goban"
import OperationArea from "../Goban/OperatinArea"
import { Button } from "../ui/button"

type Props = {
  setVideoIds: Dispatch<SetStateAction<string[] | null>>
}

const SearchByGoban: FC<Props> = ({ setVideoIds }) => {
  const { getVideos } = useJosekiApi()
  const { joseki } = useContext(JosekiContext)
  const { loading, setLoading } = useContext(LoadingContext)

  const handleSearch = async () => {
    setLoading(true)
    setVideoIds(null)
    const videos = await getVideos(joseki)
    setVideoIds(videos)
    setLoading(false)
  }

  return (
    <>
      <Goban />
      <OperationArea />
      <Button onClick={handleSearch} className="w-full" disabled={loading}>
        検索する
      </Button>
    </>
  )
}

export default SearchByGoban
