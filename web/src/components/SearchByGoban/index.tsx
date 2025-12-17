import useJosekiApi from "@/hooks/useJosekiApi"
import { JosekiContext } from "@/provider/JosekiProvider"
import { useContext, type Dispatch, type FC, type SetStateAction } from "react"
import Goban from "../Goban"
import OperationArea from "../Goban/OperatinArea"
import { Button } from "../ui/button"

type Props = {
  setVideoIds: Dispatch<SetStateAction<string[]>>
}

const SearchByGoban: FC<Props> = ({ setVideoIds }) => {
  const { getVideos } = useJosekiApi()
  const { joseki } = useContext(JosekiContext)

  const handleSearch = async () => {
    const videos = await getVideos(joseki)
    setVideoIds(videos)
  }
  return (
    <>
      <Goban />
      <OperationArea />
      <Button onClick={handleSearch} className="w-full">
        検索する
      </Button>
    </>
  )
}

export default SearchByGoban
