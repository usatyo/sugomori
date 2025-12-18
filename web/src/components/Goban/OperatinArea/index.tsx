import {
  ChevronFirstIcon,
  ChevronLeftIcon,
  ChevronsLeftIcon,
  PencilOffIcon,
  RedoIcon,
} from "lucide-react"
import type { FC } from "react"
import { Button } from "../../ui/button"
import { ButtonGroup } from "../../ui/button-group"
import useOperationArea from "./useOperationArea"

type Props = {}

const OperationArea: FC<Props> = () => {
  const { clear, backFive, back, pass, isEditable } = useOperationArea()

  return (
    <div className="flex justify-center items-center gap-4">
      <ButtonGroup>
        <Button variant="outline" onClick={clear} disabled={!isEditable}>
          <ChevronFirstIcon />
          リセット
        </Button>
        <Button variant="outline" onClick={backFive} disabled={!isEditable}>
          <ChevronsLeftIcon />
          5手戻る
        </Button>
        <Button variant="outline" onClick={back} disabled={!isEditable}>
          <ChevronLeftIcon />
          1手戻る
        </Button>
        <Button variant="outline" onClick={pass} disabled={!isEditable}>
          <RedoIcon />
          手抜き
        </Button>
      </ButtonGroup>
      {!isEditable && (
        <div className="flex items-center gap-2">
          <PencilOffIcon size={16} />
          <span className="text-sm">編集不可</span>
        </div>
      )}
    </div>
  )
}

export default OperationArea
