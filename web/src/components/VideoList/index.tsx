import { ScrollArea } from "@radix-ui/react-scroll-area"
import type { FC, ReactNode } from "react"
import { Separator } from "../ui/separator"
import VideoListItem from "./VideoListItem"
import VideoListItemSkeleton from "./VideoListItemSkeleton"

type Props = {
  videoIds: string[] | null
}

const VideoList: FC<Props> = ({ videoIds }) => {
  if (videoIds === null) {
    return (
      <ScrollArea className="h-full overflow-clip">
        {Array.from({ length: 5 })
          .map(() => <VideoListItemSkeleton />)
          .reduce<ReactNode[]>((prev, curr) => {
            return [...prev, curr, <Separator />]
          }, [])
          .slice(0, -1)}
      </ScrollArea>
    )
  } else if (videoIds.length === 0) {
    return <p className="text-center py-8">動画が見つかりませんでした。</p>
  } else {
    return (
      <ScrollArea className="h-full overflow-scroll">
        {videoIds
          .map((videoId) => <VideoListItem key={videoId} videoId={videoId} />)
          .reduce<ReactNode[]>((prev, curr) => {
            return [...prev, curr, <Separator />]
          }, [])
          .slice(0, -1)}
      </ScrollArea>
    )
  }
}

export default VideoList
