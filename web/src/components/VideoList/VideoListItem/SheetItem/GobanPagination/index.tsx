import Goban from "@/components/Goban"
import OperationArea from "@/components/Goban/OperatinArea"
import { Button } from "@/components/ui/button"
import {
  Pagination,
  PaginationContent,
  PaginationItem,
  PaginationLink,
} from "@/components/ui/pagination"
import { LoadingContext } from "@/provider/LoadingProvider"
import { useContext, type FC } from "react"
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
    onCancelAdding,
    onDeleteJoseki,
    onStartAdding,
  } = useGobanPagination(videoId)
  const { loading } = useContext(LoadingContext)

  if (isEditable) {
    return (
      <div className="flex flex-col gap-4 mt-4">
        <h3 className="font-bold text-lg">この動画に関連する定石手順</h3>
        <Goban />
        <OperationArea />
        <div className="flex gap-4">
          <Button onClick={onAddJoseki} className="grow" disabled={loading}>
            確定
          </Button>
          <Button
            variant="outline"
            onClick={onCancelAdding}
            className="grow"
            disabled={loading}
          >
            キャンセル
          </Button>
        </div>
      </div>
    )
  } else {
    return (
      <div className="flex flex-col gap-4 mt-4">
        <h3 className="font-bold text-lg">この動画に関連する定石手順</h3>
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
          <Button
            variant="destructive"
            onClick={onDeleteJoseki}
            className="grow"
            disabled={josekiList.length === 0 || loading}
          >
            この定石を削除
          </Button>
          <Button
            onClick={onStartAdding}
            className="grow"
            disabled={josekiList.length === 10 || loading}
          >
            定石を新規追加
          </Button>
        </div>
      </div>
    )
  }
}

export default GobanPagination
