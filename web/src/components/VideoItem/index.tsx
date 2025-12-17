import { useEffect } from "react"
import useEmbedApi from "../../hooks/useEmbedApi"
import { Sheet, SheetContent, SheetTrigger } from "../ui/sheet"
import DetailDrawerItem from "./SheetItem"

type Props = {
  videoId: string
}

const VideoItem: React.FC<Props> = ({ videoId }) => {
  const { setParams, fetchData, title, authorName, thumbnailUrl } =
    useEmbedApi()

  useEffect(() => {
    setParams(videoId)
    const asyncData = async () => {
      await fetchData()
    }
    asyncData()
  }, [videoId])

  return (
    <Sheet>
      <SheetTrigger className="w-full cursor-pointer hover:bg-gray-50">
        <div className="flex gap-4 py-4">
          <img
            src={thumbnailUrl}
            alt={title}
            className="w-50"
          />
          <div className="flex flex-col gap-2">
            <h3 className="text-left text-md font-bold">{title}</h3>
            <p className="text-left text-gray-400">{authorName}</p>

            {/* TODO: タグを追加 */}

          </div>
        </div>
      </SheetTrigger>
      <SheetContent className="max-w-none! w-[1000px]">
        <DetailDrawerItem videoId={videoId} />
      </SheetContent>
    </Sheet>
  )
}

export default VideoItem
