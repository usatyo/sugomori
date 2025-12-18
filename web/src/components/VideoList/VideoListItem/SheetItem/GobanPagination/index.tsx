import Goban from "@/components/Goban"
import OperationArea from "@/components/Goban/OperatinArea"
import { Button } from "@/components/ui/button"
import {
  Pagination,
  PaginationContent,
  PaginationItem,
  PaginationLink,
} from "@/components/ui/pagination"
import type { FC } from "react"
import useGobanPagination from "./useGobanPagination"

type Props = {
  videoId: string
}

const GobanPagination: FC<Props> = ({ videoId }) => {
  const {
    josekiList,
    currentIndex,
    isEditable,
    setCurrentIndex,
    onAddJoseki,
    onDeleteJoseki,
    setIsEditable,
    onStartAdding,
  } = useGobanPagination(videoId)

  if (isEditable) {
    return (
      <div className="flex flex-col gap-4 mt-6">
        <Goban />
        <OperationArea />
        <div className="flex gap-4">
          <Button className="grow" onClick={onAddJoseki}>
            確定
          </Button>
          <Button className="grow" onClick={() => setIsEditable(false)}>
            キャンセル
          </Button>
        </div>
      </div>
    )
  } else {
    return (
      <div className="flex flex-col gap-4 mt-6">
        <Goban />
        <OperationArea />
        <div className="flex gap-4">
          <Pagination>
            <PaginationContent>
              {josekiList.map((_, index) => (
                <PaginationItem key={index}>
                  <PaginationLink
                    onClick={() => setCurrentIndex(index)}
                    isActive={currentIndex === index}
                  >
                    {index + 1}
                  </PaginationLink>
                </PaginationItem>
              ))}
            </PaginationContent>
          </Pagination>
          <Button onClick={onDeleteJoseki} className="grow">
            この定石を削除
          </Button>
          <Button
            onClick={onStartAdding}
            className="grow"
            disabled={josekiList.length === 10}
          >
            定石を新規追加
          </Button>
        </div>
      </div>
    )
  }
}

export default GobanPagination
