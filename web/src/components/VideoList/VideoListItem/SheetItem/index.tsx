import { ScrollArea } from "@/components/ui/scroll-area"
import JosekiProvider from "@/provider/JosekiProvider"
import type { FC } from "react"
import GobanPagination from "./GobanPagination"

type Props = {
  videoId: string
  title: string
  authorName: string
}

const SheetItem: FC<Props> = ({ videoId, title, authorName }) => {
  return (
    <ScrollArea className="h-full">
      <div className="p-12">
        <iframe
          src={`https://www.youtube.com/embed/${videoId}`}
          className="aspect-video"
        />
        <h3 className="text-left text-xl font-bold line-clamp-2 text-ellipsis mt-4">
          {title}
        </h3>
        <p className="text-left text-md text-gray-400 line-clamp-1 text-ellipsis mt-2">
          {authorName}
        </p>
        <JosekiProvider>
          <GobanPagination videoId={videoId} />
        </JosekiProvider>
      </div>
    </ScrollArea>
  )
}

export default SheetItem
